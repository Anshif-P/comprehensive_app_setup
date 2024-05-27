import 'package:finfresh_machin_task/util/constance/text_style.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final bool paymentButtonCheck;
  final String text;
  final bool colorCheck;
  final bool borderCheck;
  final VoidCallback onpressFunction;
  final bool loadingCheck;
  final bool reviewButtonCheck;
  const ButtonWidget(
      {super.key,
      this.reviewButtonCheck = false,
      this.paymentButtonCheck = false,
      required this.onpressFunction,
      required this.text,
      required this.colorCheck,
      this.loadingCheck = false,
      this.borderCheck = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: reviewButtonCheck ? 35 : 48,
        width: 250,
        child: ElevatedButton(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(
                const Size.fromWidth(double.maxFinite)),
            elevation: MaterialStateProperty.all(0),
            side: borderCheck
                ? MaterialStateProperty.all<BorderSide>(const BorderSide(
                    color: Color(0xFFD1D1D1),
                    width: 1,
                  ))
                : null,
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            backgroundColor:
                MaterialStateProperty.all(Theme.of(context).primaryColor),
          ),
          onPressed: onpressFunction,
          child: loadingCheck
              ? Transform.scale(
                  scale: 0.5,
                  child: const CircularProgressIndicator(
                    strokeWidth: 5,
                    color: Colors.white,
                  ))
              : Text(
                  text,
                  style: borderCheck ? AppText.mediumdark : AppText.mediumLight,
                ),
        ));
  }
}
