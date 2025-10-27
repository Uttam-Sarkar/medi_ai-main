import 'package:flutter/material.dart';

import '../style/app_colors.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController? controller;
  String? label;
  TextInputType? textInputType;
  int? maxLength;
  ValueChanged? onChange;
  bool isObscure = false;
  bool isEditable;

  CustomTextField(
    this.controller,
    this.label,
    this.textInputType,
    this.maxLength,
    this.onChange,
    this.isEditable, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: textInputType,
      maxLength: maxLength,
      onChanged: onChange,
      enabled: isEditable,
      obscureText:
          label?.toLowerCase().toString() == 'password' ? isObscure : false,
      decoration: InputDecoration(
        labelText: label,
        isDense: true,
        counterText: '',
        suffixIcon: label?.toLowerCase().toString() == 'password'
            ? IconButton(
                onPressed: () {
                  isObscure = !isObscure;
                },
                icon: isObscure
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.visibility),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
      ),
    );
  }
}
