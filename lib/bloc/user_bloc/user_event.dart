part of 'user_bloc.dart';

@immutable
abstract class UserEvent {
  const UserEvent();
}

class AppStarted extends UserEvent {}

class LoginSucceeded extends UserEvent {
  final String token;

  const LoginSucceeded({required this.token});

  @override
  String toString() => 'LoggedIn { token: $token }';
}

class LogoutSucceeded extends UserEvent {}

