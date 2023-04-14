import 'package:built_collection/built_collection.dart';
import 'package:code_builder/code_builder.dart' show Reference, TypeReference;

typedef ReferFunction = Reference Function(String symbol, [String? url]);

extension KnownReferences on ReferFunction {
  /// Returns reference to `List<{ref}>`
  TypeReference listOf(TypeReference ref, {bool nullable = false}) {
    return TypeReference((b) {
      b.symbol = 'List';
      b.types = ListBuilder([ref]);
      b.isNullable = nullable;
    });
  }

  /// Refers to `void`
  TypeReference voidRef({bool nullable = false}) {
    return TypeReference((b) {
      b.symbol = 'void';
      b.isNullable = nullable;
    });
  }

  /// Refers to `int`
  TypeReference integer({bool nullable = false}) {
    return TypeReference((b) {
      b.symbol = 'int';
      b.isNullable = nullable;
    });
  }

  /// Refers to `double`
  TypeReference double({bool nullable = false}) {
    return TypeReference((b) {
      b.symbol = 'double';
      b.isNullable = nullable;
    });
  }

  /// Refers to `bool`
  TypeReference boolean({bool nullable = false}) {
    return TypeReference((b) {
      b.symbol = 'bool';
      b.isNullable = nullable;
    });
  }

  /// Refers to `Object`
  TypeReference object({bool nullable = false}) {
    return TypeReference((b) {
      b.symbol = 'Object';
      b.isNullable = nullable;
    });
  }

  /// Refers to `Widget`
  TypeReference widget({bool nullable = false}) {
    return TypeReference((b) {
      b.symbol = 'Widget';
      b.isNullable = nullable;
      b.url = _RefUrl.flutterWidgets.string;
    });
  }

  /// Refers to `InheritedWidget`
  TypeReference inheritedWidget({bool nullable = false}) {
    return TypeReference((b) {
      b.symbol = 'InheritedWidget';
      b.isNullable = nullable;
      b.url = _RefUrl.flutterWidgets.string;
    });
  }

  /// Refers to `BuildContext`
  TypeReference buildContext({bool nullable = false}) {
    return TypeReference((b) {
      b.symbol = 'BuildContext';
      b.isNullable = nullable;
    });
  }

  /// Refers to `DiagnosticPropertiesBuilder`
  TypeReference diagnosticPropertiesBuilder({bool nullable = false}) {
    return TypeReference((b) {
      b.symbol = 'DiagnosticPropertiesBuilder';
      b.isNullable = nullable;
    });
  }

  /// Refers to `@override` annotation
  Reference get overrideAnnotation => this('override');

  /// Refers to `DiagnosticNode` class from package:flutter/foundation.dart
  TypeReference diagnosticsNode({bool nullable = false}) {
    return TypeReference((b) {
      b.symbol = 'DiagnosticsNode';
      b.url = _RefUrl.flutterFoundation.string;
      b.isNullable = nullable;
    });
  }
}

enum _RefUrl {
  flutterFoundation('package:flutter/foundation.dart'),
  flutterWidgets('package:flutter/widgets.dart');

  final String string;
  const _RefUrl(this.string);
}
