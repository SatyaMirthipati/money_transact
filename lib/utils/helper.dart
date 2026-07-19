class Helper {}

class Validators {
  /// Returns an error message when [value] is null/blank, otherwise null.
  static String? required(
    String? value, {
    String message = 'This field cannot be empty',
  }) {
    if (value?.trim().isEmpty ?? true) return message;
    return null;
  }
}
