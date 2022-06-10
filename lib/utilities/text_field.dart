import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import '../app/constants/color_constant.dart';
import '../app/constants/sizeConstant.dart';

TextFormField getTextField({
  String? hintText,
  TextEditingController? textEditingController,
  Widget? prefixIcon,
  double? borderRadius,
  Widget? suffixIcon,
  double? size = 52,
  Widget? suffix,
  int? maxLine,
  Color? fillColor,
  bool isFillColor = false,
  FormFieldValidator<String>? validator,
  TextInputType textInputType = TextInputType.text,
  bool textVisible = false,
  bool readonly = false,
  List<TextInputFormatter>? textInputFormatter,
  Callback? onTap,
  Color? borderColor,
  FunctionStringCallback? onChanged,
  FunctionStringCallback? onSubmitted,
}) {
  return TextFormField(
    controller: textEditingController,
    obscureText: textVisible,
    textInputAction: TextInputAction.next,
    keyboardType: textInputType,
    validator: validator,
    maxLines: maxLine ?? 1,
    readOnly: readonly,
    onTap: onTap,
    onChanged: onChanged,
    inputFormatters: textInputFormatter,
    onFieldSubmitted: onSubmitted,
    cursorColor: appTheme.primaryTheme,
    decoration: InputDecoration(
      fillColor: fillColor,
      filled: isFillColor,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: (isNullEmptyOrFalse(borderColor))
                ? Color(0xffE8E8E8)
                : borderColor!),
        borderRadius: BorderRadius.circular(
            (borderRadius == null) ? MySize.size10! : borderRadius),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
            (borderRadius == null) ? MySize.size10! : borderRadius),
        borderSide: BorderSide(
            color: (isNullEmptyOrFalse(borderColor))
                ? Color(0xffE8E8E8)
                : borderColor!),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
            (borderRadius == null) ? MySize.size10! : borderRadius),
      ),
      contentPadding: EdgeInsets.only(
        left: MySize.size20!,
        right: MySize.size10!,
        bottom: size! / 2, // HERE THE IMPORTANT PART
      ),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      suffix: suffix,
      hintText: hintText,
      hintStyle: TextStyle(
          fontSize: MySize.size14!,
          color: Color(0xff626262),
          fontWeight: FontWeight.w600),
    ),
  );
}
