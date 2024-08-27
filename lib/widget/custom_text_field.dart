//Created by MansoorSatti 8/27/2024

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextEditingController? controller;
  final String? labelText;
  final FontWeight? fontWeight;
  final bool autofocus;
  final String? hintText;
  final double borderRadius;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool enabled;
  final double fontSize;
  final int? maxLines;
  final Color? labelColor;
  final Color? hintColor;
  final bool isBorder;
  final bool isShadow;
  final bool? filled;
  final Color? fillColor;
  final void Function(String)? onChanged;
  final Color? textColor;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String?)? onSaved;

  const CustomTextField({
    super.key,
    this.keyboardType,
    this.validator,
    this.onSaved,
    this.obscureText = false,
    this.controller,
    this.labelText,
    this.enabled = true,
    this.maxLines = 1,
    this.hintText,
    this.borderRadius = 14,
    this.fontWeight = FontWeight.w400,
    this.suffixIcon,
    this.fontSize = 12,
    this.labelColor = Colors.grey,
    this.hintColor = Colors.grey,
    this.prefixIcon,
    this.isBorder = false,
    this.isShadow = true,
    this.filled = true,
    this.fillColor = CupertinoColors.lightBackgroundGray,
    this.onChanged,
    this.textColor = Colors.black,
    this.inputFormatters,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: isBorder == true
            ? Border.all(color: Colors.black, width: 1)
            : const Border(),
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: isShadow == false
            ? null
            : [
                BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 12,
                    spreadRadius: 0,
                    offset: const Offset(0, 1)),
              ],
      ),
      child: TextFormField(
        autofocus: autofocus,
        maxLines: maxLines,
        obscuringCharacter: '∗',
        keyboardType: keyboardType,
        validator: validator,
        onChanged: onChanged,
        obscureText: obscureText,
        controller: controller,
        style: TextStyle(
          fontWeight: fontWeight,
          fontSize: fontSize,
          color: textColor,
        ),
        onSaved: onSaved,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          enabled: enabled,
          fillColor: fillColor,
          filled: filled,
          contentPadding: const EdgeInsets.only(
            left: 16,
            top: 14,
            bottom: 14,
            right: 16,
          ),
          // alignLabelWithHint:
          labelText: labelText,
          labelStyle: TextStyle(
            fontWeight: fontWeight,
            fontSize: fontSize,
            color: labelColor,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            fontWeight: fontWeight,
            fontSize: fontSize,
            color: hintColor,
          ),
          errorStyle: const TextStyle(
            color: Colors.red,
          ),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
    );
  }
}
