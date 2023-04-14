import 'package:built_collection/built_collection.dart';
import 'package:code_builder/code_builder.dart' hide refer;
import 'package:code_builder/code_builder.dart' as cb show refer;
import 'package:inherited_data/inherited_data.dart';
import 'package:inherited_data/src/utils/naming_conventions.dart';
import 'package:inherited_data/src/utils/refer.dart';

import 'data_annotated_class.dart';

/// InheritedData Mixin Builder
class IDataMixinBuilder {
  final ReferFunction refer;
  final InheritedData annotation;
  final IDataAnnotatedClass element;

  IDataMixinBuilder({
    required this.annotation,
    required this.element,
    this.refer = cb.refer,
  });

  /// Reference to produced mixin
  TypeReference mixinRef({bool nullable = false}) {
    return TypeReference((b) {
      b.symbol = element.className.asPrivateMixinName();
      b.isNullable = nullable;
    });
  }

  Mixin build() {
    return Mixin((b) {
      b.name = mixinRef().symbol;
      b.methods = ListBuilder([
        buildLerp(),
        buildCopyWith(),
        buildDebugDescribeChildren(),
        buildHashCode(),
        buildEqualityOperator(),
      ]);
    });
  }

  Method buildDebugDescribeChildren() {
    return Method((b) {
      b.name = 'debugDescribeChildren';
      b.returns = refer.listOf(refer.diagnosticsNode());
      b.lambda = false;
      // TODO: Implement body
      b.body = _throwUnimplementedError();
    });
  }

  Method buildCopyWith() {
    return Method((b) {
      b.name = 'copyWith';
      b.returns = refer(element.className);
      b.lambda = false;
      b.optionalParameters = ListBuilder([
        // TODO add parameters
      ]);
      // TODO: implement body
      b.body = _throwUnimplementedError();
    });
  }

  Method buildLerp() {
    return Method((b) {
      b.name = 'lerp';
      b.returns = TypeReference((b) {
        b.symbol = element.className;
      });
      b.static = true;
      b.lambda = false;
      b.docs = ListBuilder([
        '/// ```dart',
        '/// static ${element.className} lerp(${element.className}? a, ${element.className}? b, double t) {',
        '/// \t${mixinRef().symbol}.lerp(a, b, t);',
        '/// }',
        '/// ```',
      ]);

      final nullableClassRef = TypeReference((b) {
        b.symbol = element.className;
        b.isNullable = true;
      });
      b.requiredParameters = ListBuilder([
        /// `ClassName? a` parameter
        Parameter((p) {
          p.name = 'a';
          p.type = nullableClassRef;
          p.named = false;
        }),

        /// `ClassName? b` parameter
        Parameter((p) {
          p.name = 'b';
          p.type = nullableClassRef;
          p.named = false;
        }),

        /// `double t` parameter
        Parameter((p) {
          p.name = 't';
          p.type = refer.double();
          p.named = false;
        }),
      ]);
      // TODO: implement body
      b.body = _throwUnimplementedError();
    });
  }

  Method buildToStringShort() {
    return Method((b) {
      b.name = 'toStringShort';
      b.returns = refer(element.className);
      b.lambda = true;
      // TODO: refactor
      b.body = refer('objectRuntimeType').call([refer('this'), refer(element.className)]).statement;
    });
  }

  Method buildHashCode() {
    return Method((b) {
      b.name = 'hashCode';
      b.annotations = ListBuilder([refer.overrideAnnotation]);
      b.type = MethodType.getter;
      b.returns = refer.integer();
      b.lambda = false;
      // TODO: implement body
      b.body = _throwUnimplementedError();
    });
  }

  Method buildEqualityOperator() {
    return Method((b) {
      final pRef = refer('other');
      b.name = 'operator ==';
      b.annotations = ListBuilder([refer.overrideAnnotation]);
      b.returns = refer.boolean();
      b.lambda = false;
      b.types = ListBuilder([]);
      b.requiredParameters = ListBuilder([
        Parameter((p) {
          p.name = pRef.symbol!;
          p.type = refer.object();
          p.named = false;
        }),
      ]);
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
