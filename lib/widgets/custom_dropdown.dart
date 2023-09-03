import 'dart:math';

import 'package:dropdown_search/dropdown_search.dart';
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
    this.itemAsString,
    this.showSearchBox = false,
  }) : super(key: key);

  final String? Function(T?)? validator;
  final Color fillColor;
  final String? hintText;
  final String label;
  final List<T> items;
  final Function(T?)? onChanged;
  final T? value;
  final String Function(T)? itemAsString;
  final bool showSearchBox;

  @override
  Widget build(BuildContext context) {
    final inputDecoration = InputDecoration(
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
      floatingLabelStyle: const TextStyle(
        fontSize: 14,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
      labelStyle: const TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
      labelText: label,
      hintText: "Search..",
    );
    return DropdownSearch<T>(
      selectedItem: value,
      items: items,
      onChanged: onChanged,
      popupProps: showSearchBox
          ? PopupProps.modalBottomSheet(
              showSearchBox: showSearchBox,
              modalBottomSheetProps: ModalBottomSheetProps(
                isScrollControlled: true,
                useRootNavigator: true,
                useSafeArea: true,
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height - 200,
                ),
              ),
              searchFieldProps: TextFieldProps(
                decoration: inputDecoration,
              ),
            )
          : PopupProps.menu(
              menuProps: const MenuProps(
                borderRadius: BorderRadius.all(
                  Radius.circular(16.0),
                ),
              ),
              showSearchBox: showSearchBox,
              searchFieldProps: TextFieldProps(
                decoration: inputDecoration,
              ),
            ),
      autoValidateMode: AutovalidateMode.onUserInteraction,
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: inputDecoration,
        baseStyle: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
      dropdownButtonProps: DropdownButtonProps(
        icon: Transform.rotate(
          angle: pi / 2,
          child: const Icon(
            Icons.chevron_right_rounded,
          ),
        ),
      ),
      itemAsString: itemAsString,
      validator: validator,
    );
  }
}
