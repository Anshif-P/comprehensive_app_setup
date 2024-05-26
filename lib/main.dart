import 'package:finfresh_machin_task/controller/product_bloc/product_bloc.dart';
import 'package:finfresh_machin_task/view/screen_home.dart';
import 'package:finfresh_machin_task/view/screen_splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      ],
      child: MaterialApp(
        home: ScreenSplash(),
      ),
    );
  }
}
