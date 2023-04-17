import 'package:built_collection/built_collection.dart';
import 'package:code_builder/code_builder.dart' show Reference, TypeReference;
import 'package:meta/meta.dart';

class ReferFunction {
  const ReferFunction();

  @internal
  Reference call(
    String symbol, {
    String? url,
  }) {
    return Reference(symbol, url);
  }

  @internal
  TypeReference type(
    String symbol, {
    String? url,
    Reference? bound,
    Iterable<Reference> types = const [],
    bool isNullable = false,
  }) {
    return TypeReference((b) {
      b.symbol = symbol;
      b.url = url;
      b.bound = bound;
      b.types = ListBuilder(types);
      b.isNullable = isNullable;
    });
  }
}

extension KnownReferences on ReferFunction {
  /// Returns reference to `List<{ref}>`
  TypeReference listOf(TypeReference ref, {bool isNullable = false}) {
    return type('List', types: [ref], isNullable: isNullable);
  }

  /// Refers to `void`
  TypeReference voidRef() {
    return type('void');
  }

  /// Refers to `int`
  TypeReference integer({bool isNullable = false}) {
    return type('int', isNullable: isNullable);
  }

  /// Refers to `double`
  TypeReference double({bool isNullable = false}) {
    return type('double', isNullable: isNullable);
  }

  /// Refers to `bool`
  TypeReference boolean({bool isNullable = false}) {
    return type('bool', isNullable: isNullable);
  }

  /// Refers to `Object`
  TypeReference object({bool isNullable = false}) {
    return type('Object', isNullable: isNullable);
  }

  /// Refers to `Widget`
  TypeReference widget({bool isNullable = false}) {
    return type('Widget', url: _RefUrl.flutterWidgets.string, isNullable: isNullable);
  }

  /// Refers to `InheritedWidget`
  TypeReference inheritedWidget({bool isNullable = false}) {
    return type('InheritedWidget', url: _RefUrl.flutterWidgets.string, isNullable: isNullable);
  }

  /// Refers to `BuildContext`
  TypeReference buildContext({bool isNullable = false}) {
    return type('BuildContext', url: _RefUrl.flutterWidgets.string, isNullable: isNullable);
  }

  /// Refers to `DiagnosticPropertiesBuilder`
  TypeReference diagnosticPropertiesBuilder({bool isNullable = false}) {
    return type('DiagnosticPropertiesBuilder',
        url: _RefUrl.flutterWidgets.string, isNullable: isNullable);
  }

  /// Refers to `@override` annotation
  Reference get overrideAnnotation => this('override');

  /// Refers to `DiagnosticNode` class from package:flutter/foundation.dart
  TypeReference diagnosticsNode({bool isNullable = false}) {
    return type('DiagnosticsNode', url: _RefUrl.flutterFoundation.string, isNullable: isNullable);
  }
}

enum _RefUrl {
  flutterFoundation('package:flutter/foundation.dart'),
  flutterWidgets('package:flutter/widgets.dart');

  final String string;
  const _RefUrl(this.string);
}
