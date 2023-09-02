import 'package:flutter/material.dart';

class FormDropdownField<T> extends StatelessWidget {
  const FormDropdownField({
    Key? key,
    this.validator,
    this.fillColor = Colors.white,
    required this.label,
    this.hintText,
    required this.items,
    required this.onChanged,
    required this.value,
  }) : super(key: key);

  final String? Function(T?)? validator;
  final Color fillColor;
  final String? hintText;
  final String label;
  final List<DropdownMenuItem<T>>? items;
  final ValueChanged<T?>? onChanged;
  final T value;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      items: items,
      onChanged: onChanged,
      isExpanded: true,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Color(0xFFE3E5E5),
            width: 1.0,
          ),
        ),
        filled: true,
        fillColor: fillColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Color(0xFFE3E5E5),
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
          borderSide: const BorderSide(color: Color(0xFFE3E5E5), width: 1),
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
      ),
      validator: validator,
    );
  }
}
