import 'dart:async';
import 'package:finfresh_machin_task/controller/user_bloc/user_bloc.dart';
import 'package:finfresh_machin_task/util/constance/colors.dart';
import 'package:finfresh_machin_task/util/constance/text_style.dart';
import 'package:finfresh_machin_task/view/screen_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({Key? key}) : super(key: key);

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  StreamSubscription? isOnlineConnected;
  late ValueNotifier<bool> isOnline;
  final LocalAuthentication auth = LocalAuthentication();
  bool isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    isOnline = ValueNotifier<bool>(false);
    _authenticate();
  }

  @override
  void dispose() {
    isOnlineConnected?.cancel();
    isOnline.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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

  Future<void> _authenticate() async {
    bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    if (canAuthenticateWithBiometrics) {
      try {
        final bool didAuthenticate = await auth.authenticate(
          localizedReason: 'Please authenticate to show Bank balance',
          options: const AuthenticationOptions(biometricOnly: false),
        );
        if (didAuthenticate) {
          Future.delayed(const Duration(seconds: 4), () {
            context.read<UserBloc>().add(GetUserDetailsFromDatabaseEvent());
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const ScreenHome()),
            );
          });
        }
        // ignore: empty_catches
      } catch (e) {}
    }
  }
}
