import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../data/local/shared_prefs.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserEvent>((event, emit) {});
  }

  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is AppStarted) {
      final String? hasToken = await Prefs.getToken();

      if (hasToken != null) {
        yield AuthorizationSuccess();
      } else {
        yield AuthorizationFailure();
      }
    }

    if (event is LoginSucceeded) {
      yield AuthorizationLoading();
      await Prefs.setToken(event.token);

      yield AuthorizationSuccess();
    }

    if (event is LogoutSucceeded) {
      yield AuthorizationLoading();
      await Prefs.clearPrefs();

      yield AuthorizationInitial();
    }
  }
}
