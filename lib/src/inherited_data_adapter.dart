import 'package:analyzer/dart/element/element.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:flutter/widgets.dart' show InheritedWidget;
import 'package:inherited_data/inherited_data.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';

@protected
class InheritedDataAdapter implements InheritedData {
  final ConstantReader _reader;

  InheritedDataAdapter(this._reader);

  @override
  late final InheritedDebugFillPropertiesAdapter<InheritedWidget> debugFillProperties =
      InheritedDebugFillPropertiesAdapter(_reader.peek('debugFillProperties')!);

  @override
  late final String? fieldName = _reader.peek('fieldName')?.stringValue;

  @override
  late final String? themeName = _reader.peek('themeName')?.stringValue;

  @override
  // TODO: implement updateShouldNotify
  InheritedUpdateShouldNotify<InheritedWidget> get updateShouldNotify => throw UnimplementedError();
}

@protected
class InheritedDebugFillPropertiesAdapter<T extends InheritedWidget>
    implements InheritedDebugFillProperties<T> {
  final ConstantReader _reader;

  InheritedDebugFillPropertiesAdapter(this._reader);

  @override
  // TODO: make it safe and sound
  late final List<Symbol> excludedFields =
      _reader.peek('excludedFields')!.listValue.map((e) => Symbol(e.toSymbolValue()!)).toList();

  late final ExecutableElement? functionOverrideElement =
      _reader.peek('functionOverride')?.objectValue.toFunctionValue();

  @override
  void Function(DiagnosticPropertiesBuilder properties, T widget)? get functionOverride {
    assert(false);
    return (_, __) {};
  }
}

@protected
class InheritedUpdateShouldNotifyAdapter<T extends InheritedWidget>
    implements InheritedUpdateShouldNotify<T> {
  final ConstantReader _reader;

  InheritedUpdateShouldNotifyAdapter(this._reader);

  @override
  // TODO: make it safe and sound
  late final List<Symbol> excludedFields =
      _reader.peek('excludedFields')!.listValue.map((e) => Symbol(e.toSymbolValue()!)).toList();

  late final ExecutableElement? functionOverrideElement =
      _reader.peek('functionOverride')?.objectValue.toFunctionValue();

  @override
  bool Function(T oldWidget, T widget)? get functionOverride {
    assert(false);
    return (_, __) => true;
  }
}
