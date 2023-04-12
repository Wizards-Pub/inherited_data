import 'package:analyzer/dart/element/element.dart';

abstract class IDataAnnotatedClass {
  String get className;

  factory IDataAnnotatedClass.analyzer(Element element) = _IDataAnnotatedClass;
}

class _IDataAnnotatedClass implements IDataAnnotatedClass {
  final Element element;

  _IDataAnnotatedClass(this.element);

  @override
  String get className => element.displayName;
}
