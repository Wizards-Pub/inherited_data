import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:inherited_builder/inherited_data.dart';

part 'theme_data.inherited.dart';

@inheritedData
class ThemeData extends DiagnosticableTree with _$ThemeData {
  final String title;
  final int color;

  ThemeData({
    required this.title,
    required this.color,
  });

  static ThemeData lerp(ThemeData? a, ThemeData? b, double t) {
    return _$ThemeData.lerp(a, b, t);
  }
}
