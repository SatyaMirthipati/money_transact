import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'bloc/user_bloc/user_bloc.dart';

void main() {
  runApp(
    BlocProvider<UserBloc>(
      create: (context) {
        return UserBloc()..add(AppStarted());
      },
      child: const App(),
    ),
  );
}
