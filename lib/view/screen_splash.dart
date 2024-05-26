// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'package:finfresh_machin_task/controller/product_bloc/product_bloc.dart';
import 'package:finfresh_machin_task/util/constance/colors.dart';
import 'package:finfresh_machin_task/util/constance/text_style.dart';
import 'package:finfresh_machin_task/view/screen_parent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ScreenSplash extends StatefulWidget {
  ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  StreamSubscription? isOnlineConnected;
  bool isOnline = false;
  @override
  void initState() {
    super.initState();
    userLoginValidation(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Expanded(flex: 1, child: SizedBox()),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Container(
                height: 100,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/Frame 2 (1).png'))),
              ),
              Text(
                'Shopfy',
                style: AppText.largeDark,
              ),
            ],
          ),
        ),
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: Transform.scale(
                scale: .9,
                child: const CircularProgressIndicator(
                    strokeWidth: 6, color: AppColor.grey),
              ),
            ),
          ],
        ))
      ]),
    );
  }

  userLoginValidation(BuildContext context) async {
    isOnlineConnected = InternetConnection().onStatusChange.listen((event) {
      print(event);
      switch (event) {
        case InternetStatus.connected:
          isOnline = true;
          break;
        case InternetStatus.disconnected:
          isOnline = false;

          break;
        default:
          isOnline = false;
          break;
      }
    });

    if (isOnline) {
      print('hai');
      // User is online
      context.read<ProductBloc>().add(GetProducttsEvent());
      await Future.delayed(const Duration(seconds: 4));
      context.read<ProductBloc>().add(ImageDownloadAndStoreInfoLoacalyEvent());
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => ScreenParentNavigation()),
      );
    } else {
      // User is offline
      print('hello hai');
      context
          .read<ProductBloc>()
          .add(GetOfflineProductDetailsInDatabaseEvent());
      await Future.delayed(const Duration(seconds: 3));

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => ScreenParentNavigation()),
      );
    }
  }
}
