library inherited_data;

import 'package:flutter/foundation.dart' show DiagnosticPropertiesBuilder;
import 'package:flutter/widgets.dart' show InheritedWidget, Widget;

const inheritedData = InheritedData();

// class InheritedData {
//   final String? themeName;
//   final String? fieldName;
//   final bool debugFillProperties;
//   final bool updateShouldNotify;
//   final bool lerp;

//   const InheritedData({
//     this.themeName = defaultThemeName,
//     this.fieldName = defaultFieldName,
//     this.debugFillProperties = true,
//     this.updateShouldNotify = true,
//     this.lerp = true,
//   });

//   static const defaultFieldName = '';
//   static const defaultThemeName = '';

//   static defaultDebugFillProperties() => throw UnimplementedError();
//   static defaultLerp() => throw UnimplementedError();
//   static defaultToStringShort() => throw UnimplementedError();
//   static defaultHashCode() => throw UnimplementedError();
//   static defaultEquality() => throw UnimplementedError();
//   static defaultCopyWith() => throw UnimplementedError();
// }

class InheritedData {
  final String? themeName;
  final String? fieldName;
  final InheritedDebugFillProperties debugFillProperties;
  final InheritedUpdateShouldNotify updateShouldNotify;

  const InheritedData({
    this.themeName,
    this.fieldName,
    this.debugFillProperties = const InheritedDebugFillProperties(),
    this.updateShouldNotify = const InheritedUpdateShouldNotify(),
  });
}

class InheritedUpdateShouldNotify<T extends InheritedWidget> {
  final bool Function(T oldWidget, T widget)? functionOverride;
  final List<Symbol> excludedFields;

  const InheritedUpdateShouldNotify({
    this.functionOverride,
    this.excludedFields = const [],
  });
}

class InheritedDebugFillProperties<T extends InheritedWidget> {
  final void Function(DiagnosticPropertiesBuilder properties, T widget)? functionOverride;
  final List<Symbol> excludedFields;

  const InheritedDebugFillProperties({
    this.functionOverride,
    this.excludedFields = const [],
  });
}

class InheritedMerge<T extends InheritedWidget> {
  final Widget Function(T widget, T parent)? functionOverride;
  final List<Symbol> excludedFields;

  const InheritedMerge({
    this.functionOverride,
    this.excludedFields = const [],
  });
}

abstract class GenParam<T> {
  const factory GenParam(T value) = _GenParamValue;
  const factory GenParam.byDefault() = _GenParamDefault;
  const factory GenParam.disabled() = _GenParamDisabled;

  U unwrap<U>({
    required U Function() byDefault,
    required U Function(T v) value,
    required U Function() disabled,
  });
}

class _GenParamValue<T> implements GenParam<T> {
  final T value;

  const _GenParamValue(this.value);

  @override
  U unwrap<U>({
    required U Function() byDefault,
    required U Function(T v) value,
    required U Function() disabled,
  }) {
    return value(this.value);
  }
}

class _GenParamDefault<T> implements GenParam<T> {
  const _GenParamDefault();

  @override
  U unwrap<U>({
    required U Function() byDefault,
    required U Function(T v) value,
    required U Function() disabled,
  }) {
    return byDefault();
  }
}

class _GenParamDisabled<T> implements GenParam<T> {
  const _GenParamDisabled();

  @override
  U unwrap<U>({
    required U Function() byDefault,
    required U Function(T v) value,
    required U Function() disabled,
  }) {
    return disabled();
  }
}
