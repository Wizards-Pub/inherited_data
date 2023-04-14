import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:inherited_data/inherited_data.dart';
import 'package:inherited_data/src/inherited_data_adapter.dart';
import 'package:inherited_data/src/inherited_data_mixin/data_annotated_class.dart';
import 'package:inherited_data/src/inherited_data_mixin/data_mixin_builder.dart';
import 'package:inherited_data/src/inherited_widget/widget_annotated_class.dart';
import 'package:inherited_data/src/inherited_widget/widget_builder.dart';
import 'package:source_gen/source_gen.dart';

class InheritedDataMixinGenerator extends GeneratorForAnnotation<InheritedData> {
  @override
  FutureOr<String> generate(LibraryReader library, BuildStep buildStep) {
    print('ITS HAPPENING!!!');
    return super.generate(library, buildStep);
  }

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final annotationAdapter = InheritedDataAdapter(annotation);
    final mixinBuilder = IDataMixinBuilder(
      annotation: annotationAdapter,
      element: IDataAnnotatedClass.analyzer(element),
    );
    final generatedMixin = mixinBuilder.build();

    final widgetBuilder = IWidgetBuilder(
      annotation: annotationAdapter,
      element: IWidgetAnnotatedClass.analyzer(element),
    );
    final generatedWidget = widgetBuilder.build();

    final emitter = DartEmitter(useNullSafetySyntax: true);

    final generatedString = '''
${generatedWidget.accept(emitter)}

${generatedMixin.accept(emitter)}
''';

    try {
      return DartFormatter().format(generatedString);
    } catch (e) {
      // TODO: log error
      print(e);
    }

    return generatedString;
  }
}
