/// A custom exception class for Liquid Galaxy related errors.
/// usage: throw LGException('Could not connect to LG Master');
class LGException implements Exception {
  final String message;
  final String? code;

  LGException(this.message, {this.code});

  @override
  String toString() {
    if (code != null) {
      return 'LGException: $message (Code: $code)';
    }
    return 'LGException: $message';
  }
}