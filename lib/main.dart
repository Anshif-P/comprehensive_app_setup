import 'package:finfresh_machin_task/controller/product_bloc/product_bloc.dart';
import 'package:finfresh_machin_task/controller/user_bloc/user_bloc.dart';
import 'package:finfresh_machin_task/util/themes/dark_theme.dart';
import 'package:finfresh_machin_task/util/themes/light_theme.dart';
import 'package:finfresh_machin_task/view/screen_splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'controller/theme_bloc/theam_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductBloc(),
        ),
        BlocProvider(
          create: (context) => UserBloc(),
        ),
        BlocProvider(
          create: (context) => TheamBloc(),
        )
      ],
      child: BlocBuilder<TheamBloc, ThemeMode>(
        builder: (context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: state,
          home: const ScreenSplash(),
        ),
      ),
    );
  }
}
