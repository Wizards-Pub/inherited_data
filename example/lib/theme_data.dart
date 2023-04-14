import 'package:inherited_data/inherited_data.dart';

part 'theme_data.inherited.dart';

@inheritedData
class ThemeData {
  final String title;
  final int color;

  ThemeData({
    required this.title,
    required this.color,
  });
}
