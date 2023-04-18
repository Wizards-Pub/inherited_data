import 'package:inherited_data/inherited_data.dart';
import 'package:source_gen/source_gen.dart';

class InheritedDataAdapter implements InheritedData {
  final ConstantReader _reader;

  InheritedDataAdapter(this._reader);

  @override
  late final String? attachTo = _reader.peek('attachTo')?.stringValue;

  @override
  late final String? fieldName = _reader.peek('fieldName')?.stringValue;

  @override
  late final String? widgetName = _reader.peek('widgetName')?.stringValue;
}
