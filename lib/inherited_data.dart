library inherited_data;

const inheritedData = InheritedData();

class InheritedData {
  /// A name of a generated `InheritedWidget`.
  ///
  /// Default value will generate an InheritedWidget with prefix + name of
  /// an annotated class + postfix. For example:
  ///
  /// ```dart
  /// @inherited
  /// class FooThemeData {}
  ///
  /// // Generates
  /// class DefaultFooThemeData extends InheritedWidget {}
  /// ```
  /// Prefix and postfix can be specified globally in build.yaml config.
  final String? widgetName;

  /// A name of a parent theme data where this data will be attached to.
  ///
  /// {@template global_theme_example}
  /// Example:
  ///
  /// ```dart
  /// @InheritedData(attachTo: 'ParentThemeData', fieldName: 'aChild')
  /// class AChildData {}
  ///
  /// @InheritedData(attachTo: 'ParentThemeData', fieldName: 'bChild')
  /// class BChildData {}
  ///
  /// // Generates
  /// class ParentThemeData {
  ///   final AChildData aChild;
  ///   final BChildData bChild;
  ///
  ///   // ...
  /// }
  /// ```
  /// {@endtemplate}
  final String? attachTo;

  /// A field name of a global theme.
  ///
  /// {@macro global_theme_example}
  final String? fieldName;

  const InheritedData({
    this.widgetName,
    this.attachTo,
    this.fieldName,
  });
}
