import 'package:flutter/material.dart';
import 'package:all_table/_core/colors.dart';

InputDecoration getAuthenticationInputDecoration(
    String hintText, IconData iconData) {
  return InputDecoration(
    fillColor: MineColors.azul3,
    filled: true,
    contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide.none,
    ),
    prefixIcon: Icon(
      iconData,
      color: MineColors.cinza3,
      size: 15.0,
    ),
    hintText: hintText,
    hintStyle: const TextStyle(
      fontSize: 13.0,
      fontFamily: 'Poppins',
      color: Color.fromARGB(115, 164, 164, 164),
    ),
    errorBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: Colors.red, width: 1)
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: Colors.red, width: 2)
    ),
  );
}

BoxDecoration getAuthenticationBoxDecoration() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        spreadRadius: 1,
        blurRadius: 5,
        offset: const Offset(0, 2),
      ),
    ],
  );
}
