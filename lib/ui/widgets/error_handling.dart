import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'login_expired_screen.dart';
import 'no_internet_screen.dart';


class ErrorHandling {
  static String parseError(error) {
    if (kDebugMode) {
      print('###ErrorHandling###');
      print(error);
    }
    try {
      if (error is DioException) {
        switch (error.type) {
          case DioExceptionType.badResponse:
            if (error.response?.statusCode == 400) {
              var map = error.response?.data;
              return badRequestMsg(map);
            } else if (error.response?.statusCode == 422) {
              return _messageFromData(error.response?.data) ??
                  'Unprocessable request';
            } else if (error.response?.statusCode == 404) {
              return _messageFromData(error.response?.data) ?? 'Not found';
            } else if (error.response?.statusCode == 401) {
              Future.delayed(
                const Duration(seconds: 1),
                () {
                  LoginExpiredScreen.open;
                },
              );
              return _messageFromData(error.response?.data) ?? 'Session expired';
            }
            return _messageFromData(error.response?.data) ??
                'Something went wrong';
          case DioExceptionType.unknown:
            if (error.error is SocketException) {
              Future.delayed(const Duration(seconds: 1), NoInternetScreen.open);
              if (kDebugMode) {
                print('SocketException');
                print(error.error);
              }
              if (kReleaseMode) return 'Unable to connect';
              return (error.error as SocketException).message;
            }
            if (kReleaseMode) return 'Unknown error!';
            return _messageFromData(error.response?.data) ??
                error.message ??
                'Unknown error!';
          default:
            if (kReleaseMode) return 'Unknown error!';
            return _messageFromData(error.response?.data) ??
                error.message ??
                'Unknown error!';
        }
      } else if (error is Exception) {
        return error.toString().replaceFirst('Exception: ', '');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error while parsing error: $e');
      }
      return 'Unknown error!';
    }
    return error?.toString() ?? 'Unknown error!';
  }

  /// Safely extracts a human readable `message` field from a response body,
  /// returning `null` when it is missing so callers can supply a fallback
  /// instead of propagating a `null` as a non-nullable [String].
  static String? _messageFromData(dynamic data) {
    if (data is Map && data['message'] is String) {
      return data['message'] as String;
    }
    return null;
  }

  static String badRequestMsg(map) {
    if (map is Map && map['message'] is String) {
      var message = map['message'] as String;
      var params = map['parameters'];
      if (params is! List) return message;
      for (int i = 0; i < params.length; i++) {
        message = message.replaceFirst('%${i + 1}', params[i].toString());
      }
      return message;
    } else {
      return 'Unknown error!';
    }
  }
}
