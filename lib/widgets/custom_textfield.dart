import 'package:flutter/material.dart';
import 'package:flutter_card_scanner/theme/app_colors.dart';

class FormTextField extends StatelessWidget {
  const FormTextField({
    Key? key,
    this.controller,
    this.validator,
    this.fillColor = Colors.white,
    required this.label,
    this.hintText,
    this.onChanged,
    this.onEditingComplete,
    this.suffixIcon,
    this.maxLength,
    this.focusNode,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Color fillColor;
  final String? hintText;
  final String label;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final Widget? suffixIcon;
  final int? maxLength;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColor.fieldBorder,
            width: 1.0,
          ),
        ),
        filled: true,
        fillColor: fillColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColor.fieldBorder,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.blueAccent, width: 1)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red, width: 1)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red, width: 1)),
        errorStyle: const TextStyle(
          fontSize: 12,
          color: Colors.red,
          fontWeight: FontWeight.w400,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColor.fieldBorder, width: 1),
        ),
        labelText: label,
        labelStyle: const TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        floatingLabelStyle: const TextStyle(
          fontSize: 14,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        hintText: hintText,
        suffixIcon: suffixIcon,
        counterText: "",
      ),
      validator: validator,
      maxLength: maxLength,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
