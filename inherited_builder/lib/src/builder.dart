library inherited_data.builder;

import 'package:build/build.dart';
import 'package:dart_style/dart_style.dart';
import 'package:source_gen/source_gen.dart';

import 'inherited_data_mixin_generator.dart';
import 'inherited_widget_generator.dart';

Builder inheritedBuilder(BuilderOptions options) {
  return PartBuilder(
    [
      InheritedWidgetGenerator(),
      InheritedDataMixinGenerator(),
    ],
    '.inherited.dart',
    allowSyntaxErrors: true,
    formatOutput: (code) {
      // TODO: obtain page width from BuilderOptions
      return DartFormatter(pageWidth: 100).format(code);
    },
  );
}
