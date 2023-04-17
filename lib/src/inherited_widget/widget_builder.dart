import 'package:built_collection/built_collection.dart';
import 'package:code_builder/code_builder.dart' hide refer;
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
    this.refer = const ReferFunction(),
  });

  /// Reference to produced mixin
  TypeReference widgetRef({bool isNullable = false}) {
    // ! FIXME: name should be obtained from context / specified explicitly
    return refer.type(
      element.className.asInheritedWidgetName(),
      isNullable: isNullable,
    );
  }

  Class build() {
    return Class((b) {
      b.name = widgetRef().symbol;
      b.extend = refer.inheritedWidget();
      b.constructors = ListBuilder([
        buildDefaultConstructor(),
      ]);
      b.methods = ListBuilder([
        // ?: buildThemeConstructors
        buildMerge(),
        buildOfContext(),
        buildUpdateShouldNotify(),
        buildDebugFillProperties(),
      ]);
    });
  }

  Constructor buildDefaultConstructor() {
    return Constructor((b) {
      // TODO: add parameters
      b.optionalParameters = ListBuilder([
        Parameter((p) {
          p.toSuper = true;
          p.named = true;
          p.name = 'key';
        }),
        Parameter((p) {
          p.toSuper = true;
          p.required = true;
          p.named = true;
          p.name = 'child';
        }),
      ]);
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
      b.annotations = ListBuilder([refer.overrideAnnotation]);
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
      b.annotations = ListBuilder([refer.overrideAnnotation]);
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

  // TODO: remove
  Code _throwUnimplementedError() {
    return refer.type('UnimplementedError').call([]).thrown.statement;
  }
}
