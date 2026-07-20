import 'package:flutter_test/flutter_test.dart';
import 'package:money_transact/bloc/user_bloc/user_bloc.dart';
import 'package:money_transact/data/local/shared_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('UserEvent', () {
    test('LoginSucceeded exposes its token and toString', () {
      const event = LoginSucceeded(token: 'tok');
      expect(event.token, 'tok');
      expect(event.toString(), 'LoggedIn { token: tok }');
    });
  });

  group('UserBloc', () {
    test('initial state is UserInitial', () {
      final bloc = UserBloc();
      expect(bloc.state, isA<UserInitial>());
      bloc.close();
    });
  });

  group('UserBloc.mapEventToState', () {
    test('AppStarted emits AuthorizationFailure when no token stored', () {
      final bloc = UserBloc();
      expect(
        bloc.mapEventToState(AppStarted()),
        emitsInOrder([isA<AuthorizationFailure>(), emitsDone]),
      );
      addTearDown(bloc.close);
    });

    test('AppStarted emits AuthorizationSuccess when token stored', () async {
      await Prefs.setToken('abc');
      final bloc = UserBloc();
      expect(
        bloc.mapEventToState(AppStarted()),
        emitsInOrder([isA<AuthorizationSuccess>(), emitsDone]),
      );
      addTearDown(bloc.close);
    });

    test('LoginSucceeded emits loading then success and persists token',
        () async {
      final bloc = UserBloc();
      await expectLater(
        bloc.mapEventToState(const LoginSucceeded(token: 'xyz')),
        emitsInOrder([
          isA<AuthorizationLoading>(),
          isA<AuthorizationSuccess>(),
          emitsDone,
        ]),
      );
      expect(await Prefs.getToken(), 'Bearer xyz');
      await bloc.close();
    });

    test('LogoutSucceeded emits loading then initial and clears token',
        () async {
      await Prefs.setToken('abc');
      final bloc = UserBloc();
      await expectLater(
        bloc.mapEventToState(LogoutSucceeded()),
        emitsInOrder([
          isA<AuthorizationLoading>(),
          isA<AuthorizationInitial>(),
          emitsDone,
        ]),
      );
      expect(await Prefs.getToken(), isNull);
      await bloc.close();
    });
  });
}
