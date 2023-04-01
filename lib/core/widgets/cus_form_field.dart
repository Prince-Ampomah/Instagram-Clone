import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instagram_clone/core/theme/theme.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    Key? key,
    this.controller,
    this.initialValue,
    this.autofillHints,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.focusNode,
    this.maxLines = 1,
    this.minLines = 1,
    this.readOnly = false,
    this.isPasswordField = false,
    this.hasPrefixIcon = false,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.inputFormatters,
    this.cursorColor = AppColors.blackColor,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.contentPadding,
    this.onFieldSubmitted,
    this.onTap,
    this.filled = false,
    this.fillColor,
    this.border = const OutlineInputBorder(),
    this.errorBorder = const OutlineInputBorder(),
    this.enabledBorder = const OutlineInputBorder(),
    this.disabledBorder = const OutlineInputBorder(),
    this.focusedBorder = const OutlineInputBorder(),
    this.focusedErrorBorder = const OutlineInputBorder(),
    this.maxLength,
  }) : super(key: key);

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final int? maxLength, maxLines, minLines;
  final bool readOnly, isPasswordField, hasPrefixIcon, filled;

  final String? Function(String?)? onChanged,
      onSaved,
      validator,
      onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final Color? cursorColor, fillColor;
  final String? labelText, hintText, initialValue;
  final Widget? prefixIcon, suffixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final Iterable<String>? autofillHints;
  final Function()? onTap;
  final InputBorder? border,
      errorBorder,
      enabledBorder,
      disabledBorder,
      focusedBorder,
      focusedErrorBorder;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      controller: controller,
      initialValue: initialValue,
      autofillHints: autofillHints,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      inputFormatters: inputFormatters,
      focusNode: focusNode,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      readOnly: readOnly,
      obscureText: isPasswordField ? true : false,
      onChanged: onChanged ?? (value) {},
      onSaved: onSaved ?? (value) {},
      onFieldSubmitted: onFieldSubmitted ?? (value) {},
      validator: validator ??
          (value) {
            return null;
          },
      cursorColor: cursorColor,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsets.symmetric(
          horizontal: hasPrefixIcon ? 0.0 : 10.0,
          vertical: 10.0,
        ),
        filled: filled,
        fillColor: fillColor,
        border: border,
        errorBorder: errorBorder,
        enabledBorder: enabledBorder,
        disabledBorder: disabledBorder,
        focusedBorder: focusedBorder,
        focusedErrorBorder: focusedErrorBorder,
      ),
    );
  }
}
