import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_search_test/core/startup.dart';
import 'package:user_search_test/presentation/features/users/presentation/manager/users_bloc.dart';
import 'package:user_search_test/presentation/features/users/presentation/users_page.dart';

/// The Widget that configures your application.
class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UsersBloc>(
          create: (context) => sl<UsersBloc>(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        restorationScopeId: 'app',
        home: UsersPage(),
      ),
    );
  }
}
