import 'package:analyzer/dart/element/element.dart';

abstract class IWidgetAnnotatedClass {
  String get className;

  factory IWidgetAnnotatedClass.analyzer(Element element) = _IWidgetAnnotatedClass;
}

class _IWidgetAnnotatedClass implements IWidgetAnnotatedClass {
  final Element element;

  _IWidgetAnnotatedClass(this.element);

  @override
  String get className => element.displayName;
}
