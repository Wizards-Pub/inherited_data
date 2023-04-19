import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:inherited_builder/src/inherited_data_adapter.dart';
import 'package:inherited_builder/src/inherited_widget/widget_annotated_class.dart';
import 'package:inherited_builder/src/inherited_widget/widget_builder.dart';
import 'package:inherited_data/inherited_data.dart';
import 'package:source_gen/source_gen.dart';

class InheritedWidgetGenerator extends GeneratorForAnnotation<InheritedData> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final annotationAdapter = InheritedDataAdapter(annotation);

    final widgetBuilder = IWidgetBuilder(
      annotation: annotationAdapter,
      element: IWidgetAnnotatedClass.analyzer(element),
    );
    final generatedWidget = widgetBuilder.build();

    final emitter = DartEmitter(useNullSafetySyntax: true);

    final generatedString = generatedWidget.accept(emitter).toString();
    return generatedString;
  }
}
