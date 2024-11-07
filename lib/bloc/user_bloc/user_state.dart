part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

class AuthorizationInitial extends UserState {}

class AuthorizationSuccess extends UserState {}

class AuthorizationFailure extends UserState {}

class AuthorizationLoading extends UserState {}
