import 'package:recase/recase.dart';

extension NamingConventions on String {
  String asPrivateMixinName() {
    if (isPrivate) {
      return '_\$${substring(1)._toTypeName()}';
    }
    return '_\$$_toTypeName()';
  }

  String _toTypeName() {
    return pascalCase.replaceAll(const DartProhibitedCharacters(), '');
  }

  bool get isPrivate => startsWith('_');
  // bool get isGenerated => startsWith('_\$') || startsWith('\$');
}

/// 48-57 (0 - 9)
/// 65-90 (A - Z)
/// 97-122 (a - z)
/// exceptions: 36 ($) and 95 (_)
class DartProhibitedCharacters implements Pattern {
  const DartProhibitedCharacters();

  @override
  Iterable<Match> allMatches(String string, [int start = 0]) sync* {
    if (string.isEmpty) {
      return;
    }
    final codeUnits = string.codeUnits;
    final firstCodeUnit = codeUnits.first;

    // only (A - z), '$' and '_' are allowed to be a first character
    if (!(_isLetter(firstCodeUnit) || _isUnderscore(firstCodeUnit) || _isDollar(firstCodeUnit))) {
      yield _CharacterMatch(start: 0, end: 1, input: string, pattern: this);
    }

    var index = 0;
    for (final codeUnit in codeUnits.skip(index + 1)) {
      index++;
      if (_isLetter(codeUnit) ||
          _isNumber(codeUnit) ||
          _isUnderscore(codeUnit) ||
          _isDollar(codeUnit)) {
        continue;
      }

      yield _CharacterMatch(start: index, end: index + 1, input: string, pattern: this);
    }
  }

  @pragma("vm:always-consider-inlining")
  static bool _isNumber(int codeUnit) {
    // 0 - 9
    return codeUnit >= 48 && codeUnit <= 57;
  }

  @pragma("vm:always-consider-inlining")
  static bool _isUppercaseLetter(int codeUnit) {
    // A - Z
    return codeUnit >= 65 && codeUnit <= 90;
  }

  @pragma("vm:always-consider-inlining")
  static bool _isLowercaseLetter(int codeUnit) {
    // a - z
    return codeUnit >= 97 && codeUnit <= 122;
  }

  @pragma("vm:always-consider-inlining")
  static bool _isLetter(int codeUnit) {
    // A - z
    return _isLowercaseLetter(codeUnit) && _isUppercaseLetter(codeUnit);
  }

  @pragma("vm:always-consider-inlining")
  static bool _isDollar(int codeUnit) {
    return codeUnit == 36;
  }

  @pragma("vm:always-consider-inlining")
  static bool _isUnderscore(int codeUnit) {
    return codeUnit == 95;
  }

  @override
  Match? matchAsPrefix(String string, [int start = 0]) {
    final codeUnit = string.codeUnitAt(start);

    if (start == 0) {
      if (_isLetter(codeUnit) || _isUnderscore(codeUnit) || _isDollar(codeUnit)) {
        return null;
      }

      return _CharacterMatch(start: start, end: start + 1, input: string, pattern: this);
    }

    if (_isLetter(codeUnit) ||
        _isNumber(codeUnit) ||
        _isUnderscore(codeUnit) ||
        _isDollar(codeUnit)) {
      return null;
    }

    return _CharacterMatch(start: start, end: start + 1, input: string, pattern: this);
  }
}

class _CharacterMatch extends Match {
  @override
  final int start;

  @override
  final int end;

  @override
  final String input;

  @override
  final Pattern pattern;

  late final String _value = input[start];

  _CharacterMatch({
    required this.start,
    required this.end,
    required this.input,
    required this.pattern,
  }) : assert(end - start == 1);

  @override
  String? operator [](int group) {
    if (group == 0) return _value;
    return null;
  }

  @override
  String? group(int group) {
    if (group == 0) return _value;
    return null;
  }

  @override
  final int groupCount = 1;

  @override
  List<String?> groups(List<int> groupIndices) {
    if (groupIndices.contains(0)) {
      return List<String?>.filled(groupIndices.length, null)..[groupIndices.indexOf(0)] = _value;
    }
    return List<String?>.filled(groupIndices.length, null);
  }
}
