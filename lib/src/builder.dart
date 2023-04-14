library inherited_data.builder;

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'inherited_data_mixin_generator.dart';

Builder inheritedBuilder(BuilderOptions options) {
  return PartBuilder(
    [
      InheritedDataMixinGenerator(),
      // InheritedWidgetGenerator(),
    ],
    '.inherited.dart',
    options: options,
  );
}
