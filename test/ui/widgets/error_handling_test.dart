import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:money_transact/ui/widgets/error_handling.dart';

DioException _dioError({
  required int statusCode,
  dynamic data,
  DioExceptionType type = DioExceptionType.badResponse,
}) {
  final requestOptions = RequestOptions(path: '/test');
  return DioException(
    requestOptions: requestOptions,
    type: type,
    response: Response(
      requestOptions: requestOptions,
      statusCode: statusCode,
      data: data,
    ),
  );
}

void main() {
  group('ErrorHandling.parseError', () {
    test('400 without parameters returns the raw message', () {
      final error = _dioError(
        statusCode: 400,
        data: {'message': 'Bad request'},
      );
      expect(ErrorHandling.parseError(error), 'Bad request');
    });

    test('400 with parameters substitutes placeholders', () {
      final error = _dioError(
        statusCode: 400,
        data: {
          'message': 'Field %1 must be %2',
          'parameters': ['email', 'valid'],
        },
      );
      expect(ErrorHandling.parseError(error), 'Field email must be valid');
    });

    test('422 returns the message field', () {
      final error = _dioError(
        statusCode: 422,
        data: {'message': 'Unprocessable'},
      );
      expect(ErrorHandling.parseError(error), 'Unprocessable');
    });

    test('404 returns the message field', () {
      final error = _dioError(
        statusCode: 404,
        data: {'message': 'Not found'},
      );
      expect(ErrorHandling.parseError(error), 'Not found');
    });

    test('401 returns provided message', () {
      final error = _dioError(
        statusCode: 401,
        data: {'message': 'Token invalid'},
      );
      expect(ErrorHandling.parseError(error), 'Token invalid');
    });

    test('401 without a message falls back to "Session expired"', () {
      final error = _dioError(statusCode: 401, data: {});
      expect(ErrorHandling.parseError(error), 'Session expired');
    });

    test('plain Exception strips the "Exception: " prefix', () {
      expect(
        ErrorHandling.parseError(Exception('boom')),
        'boom',
      );
    });

    test('non-error object falls back to its string form', () {
      expect(ErrorHandling.parseError('raw string'), 'raw string');
    });

    test('null falls back to "Unknown error!"', () {
      expect(ErrorHandling.parseError(null), 'Unknown error!');
    });
  });

  group('ErrorHandling.badRequestMsg', () {
    test('returns message unchanged when parameters are null', () {
      expect(
        ErrorHandling.badRequestMsg({'message': 'Simple'}),
        'Simple',
      );
    });

    test('substitutes %1..%n placeholders in order', () {
      expect(
        ErrorHandling.badRequestMsg({
          'message': '%1 and %2',
          'parameters': ['one', 'two'],
        }),
        'one and two',
      );
    });

    test('returns "Unknown error!" for non-map input', () {
      expect(ErrorHandling.badRequestMsg('not a map'), 'Unknown error!');
    });
  });
}
