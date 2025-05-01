import 'package:fab_app/consgt/constWar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';




class CustomField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? keyBoardType;
  final String? initText;
  final bool redOnly;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;

  const CustomField({
    this.controller,
    this.initText,
    this.hintText,
    this.inputFormatters,
    this.validator,
    this.keyBoardType,
    this.redOnly = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator:validator,
      readOnly: redOnly,
      initialValue: initText,
      inputFormatters: inputFormatters,
      keyboardType: keyBoardType,
      
      style: AppConstant.richInfoTextLabel(BuildContext),

      decoration: InputDecoration(
        hintText: hintText,

        filled: true,
        fillColor: Colors.white,

        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
        errorBorder: InputBorder.none
      ),


    );
  }
}
