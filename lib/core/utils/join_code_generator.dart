import 'dart:math';

class JoinCodeGenerator {
  static const String _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  static const int _codeLength = 6;

  static String generate() {
    final random = Random();
    return String.fromCharCodes(
      Iterable.generate(
        _codeLength,
        (_) => _chars.codeUnitAt(random.nextInt(_chars.length)),
      ),
    );
  }

  static bool isValid(String code) {
    if (code.length != _codeLength) return false;
    return code.toUpperCase().split('').every((char) => _chars.contains(char));
  }
}
