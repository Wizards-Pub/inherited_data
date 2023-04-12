import 'package:inherited_data/inherited_data.dart';

// part 'inherited_data_example.g.dart';

@inheritedData
class CodeStyle {
  final String field1;
  final String field2;

  CodeStyle({
    required this.field1,
    required this.field2,
  });
}
