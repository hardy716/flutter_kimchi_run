import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/theme.dart';
import '../../../gen/colors.gen.dart';

class StyledTextFormField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextAlign textAlign;
  final Size size;
  final TextStyle textStyle;
  final TextStyle hintStyle;
  final TextStyle errorStyle;
  final TextStyle counterStyle;
  final bool obscureText;
  final Widget? leading;
  final Function(String)? onSubmitted;
  final bool isError;

  const StyledTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    this.keyboardType,
    this.textInputAction,
    this.textAlign = TextAlign.center,
    this.size = AppSizes.textFormFieldSize,
    this.textStyle = AppTexts.h2,
    this.hintStyle = AppTexts.h2,
    this.errorStyle = AppTexts.h2,
    this.counterStyle = AppTexts.b2,
    this.obscureText = false,
    this.leading,
    this.onSubmitted,
    this.isError = false,
  });

  @override
  State<StyledTextFormField> createState() => _StyledTextFormFieldState();
}

class _StyledTextFormFieldState extends State<StyledTextFormField> {
  bool _showObscureText = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: widget.size.width, maxHeight: widget.size.height),
      child: TextFormField(
        cursorColor: ColorName.black100,
        controller: widget.controller,
        autofocus: false,
        maxLength: AppConstants.maxLength,
        style: widget.textStyle.copyWith(color: ColorName.black100),
        obscureText: _showObscureText ? false : widget.obscureText,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        textAlign: widget.textAlign,
        onFieldSubmitted: widget.onSubmitted,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]')),
        ],
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: widget.hintStyle.copyWith(color: ColorName.black70.withAlpha(AppConstants.hintTextAlpha)),
          errorText: widget.isError ? 'Duplicated' : null,
          errorStyle: widget.errorStyle.copyWith(color: ColorName.red500),
          counterStyle: widget.counterStyle,
          prefixIcon: widget.leading,
          suffixIcon: !widget.obscureText
              ? null
              : IconButton(
            onPressed: () {
              setState(() {
                _showObscureText = !_showObscureText;
              });
            },
            icon: Icon(_showObscureText ? Icons.visibility : Icons.visibility_off, color: ColorName.black70),
          ),
          border: const OutlineInputBorder(
            borderRadius: AppBorderRadius.box,
            borderSide: BorderSide.none,
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: AppBorderRadius.box,
            borderSide: BorderSide.none,
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: AppBorderRadius.box,
            borderSide: BorderSide(color: ColorName.red500),
          ),
          fillColor: ColorName.black70.withAlpha(AppConstants.hintTextAlpha),
          filled: true,
        ),
      ),
    );
  }
}
