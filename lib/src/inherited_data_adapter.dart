import 'package:inherited_data/inherited_data.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';

@protected
class InheritedDataAdapter implements InheritedData {
  final ConstantReader _reader;

  InheritedDataAdapter(this._reader);

  @override
  // TODO: implement debugFillProperties
  bool get debugFillProperties => throw UnimplementedError();

  @override
  // TODO: implement fieldName
  String? get fieldName => throw UnimplementedError();

  @override
  // TODO: implement lerp
  bool get lerp => throw UnimplementedError();

  @override
  // TODO: implement themeName
  String? get themeName => throw UnimplementedError();

  @override
  // TODO: implement updateShouldNotify
  bool get updateShouldNotify => throw UnimplementedError();
}
