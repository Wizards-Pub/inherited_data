import 'package:built_collection/built_collection.dart';
import 'package:code_builder/code_builder.dart' hide refer;
import 'package:code_builder/code_builder.dart' as cb show refer;
import 'package:inherited_data/inherited_data.dart';
import 'package:inherited_data/src/utils/naming_conventions.dart';
import 'package:inherited_data/src/utils/refer.dart';

import 'widget_annotated_class.dart';

/// InheritedWidget Builder
class IWidgetBuilder {
  final ReferFunction refer;
  final InheritedData annotation;
  final IWidgetAnnotatedClass element;

  IWidgetBuilder({
    required this.annotation,
    required this.element,
    this.refer = cb.refer,
  });

  /// Reference to produced mixin
  TypeReference widgetRef({bool nullable = false}) {
    return TypeReference((b) {
      // ! FIXME: name should be obtained from context / specified explicitly
      b.symbol = element.className.asPrivateMixinName();
      b.isNullable = nullable;
    });
  }

  Class build() {
    return Class((b) {
      b.name = widgetRef().symbol;
      b.constructors = ListBuilder([
        buildDefaultConstructor(),
      ]);
      b.methods = ListBuilder([
        // ?: buildThemeConstructors
        buildDefaultConstructor(),
        buildMerge(),
        buildUpdateShouldNotify(),
        buildOfContext(),
        buildDebugFillProperties(),
      ]);
    });
  }

  Constructor buildDefaultConstructor() {
    return Constructor((b) {
      // TODO: add parameters
      b.requiredParameters = ListBuilder([]);
    });
  }

  Method buildMerge() {
    return Method((b) {
      b.name = 'merge';
      b.optionalParameters = ListBuilder([
        // TODO: add parameters
      ]);
      b.static = true;
      b.returns = refer.widget();
      b.lambda = false;
      // TODO: implement body
      b.body = _throwUnimplementedError();
    });
  }

  Method buildOfContext() {
    return Method((b) {
      b.name = 'of';
      b.requiredParameters = ListBuilder([
        Parameter((p) {
          p.name = 'context';
          p.type = refer.buildContext();
          p.named = false;
        }),
      ]);
      b.static = true;
      b.returns = widgetRef();
      b.lambda = false;
      // TODO: implement body
      b.body = _throwUnimplementedError();
    });
  }

  Method buildUpdateShouldNotify() {
    return Method((b) {
      b.name = 'updateShouldNotify';
      b.requiredParameters = ListBuilder([
        Parameter((p) {
          p.name = 'oldWidget';
          p.type = widgetRef();
          p.named = false;
          // p.required = true;
        }),
      ]);
      b.returns = refer.boolean();
      b.lambda = false;
      // TODO: implement body
      b.body = _throwUnimplementedError();
    });
  }

  Method buildDebugFillProperties() {
    return Method((b) {
      b.name = 'debugFillProperties';
      b.requiredParameters = ListBuilder([
        Parameter((p) {
          p.name = 'properties';
          p.type = refer.diagnosticPropertiesBuilder();
          p.named = false;
          // p.required = true;
        }),
      ]);
      b.returns = refer.voidRef();
      b.lambda = false;
      // TODO: implement body
      b.body = _throwUnimplementedError();
    });
  }

  Code _throwUnimplementedError() {
    return TypeReference((b) {
      b.symbol = 'UnimplementedError';
    }).call([]).thrown.statement;
  }
}
