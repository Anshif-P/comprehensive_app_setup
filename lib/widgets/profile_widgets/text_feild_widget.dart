import 'package:finfresh_machin_task/util/constance/colors.dart';
import 'package:flutter/material.dart';
import '../../util/constance/text_style.dart';

// ignore: must_be_immutable
class TextFieldWidget extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final IconData icon;
  final bool textVisibility;
  final FormFieldValidator validator;
  bool isObscure = true;
  final bool isHintShwo;

  TextFieldWidget({
    super.key,
    required this.hintText,
    required this.controller,
    required this.icon,
    required this.validator,
    required this.isHintShwo,
    this.isObscure = false,
    this.textVisibility = false,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        onEditingComplete: () {
          FocusScope.of(context).nextFocus();
        },
        validator: widget.validator,
        controller: widget.controller,
        obscureText: widget.isObscure,
        decoration: InputDecoration(
          isDense: true,
          constraints: const BoxConstraints(maxHeight: 70, minHeight: 35),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(10.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.grey),
            borderRadius: BorderRadius.circular(10.0),
          ),
          prefixIcon: Icon(widget.icon, color: AppColor.lightGreyColor),
          suffixIcon: widget.textVisibility
              ? IconButton(
                  icon: Icon(widget.isObscure
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      widget.isObscure = !widget.isObscure;
                    });
                  },
                )
              : null,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          hintText: widget.isHintShwo ? widget.hintText : null,
          hintStyle: AppText.mediumGrey,
        ),
      ),
    );
  }
}
