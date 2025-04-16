import 'package:flutter/material.dart';
import 'package:abilify/utils/constants.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconPressed;
  final int? maxLines;
  final int? minLines;
  final bool enabled;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final AutovalidateMode autovalidateMode;

  const CustomTextField({
    Key? key,
    this.label,
    this.hint,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.maxLines = 1,
    this.minLines,
    this.enabled = true,
    this.focusNode,
    this.textInputAction,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      maxLines: maxLines,
      minLines: minLines,
      enabled: enabled,
      focusNode: focusNode,
      textInputAction: textInputAction,
      autovalidateMode: autovalidateMode,
      style: AppTextStyles.bodyLarge,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: suffixIcon != null
            ? IconButton(
                icon: Icon(suffixIcon),
                onPressed: onSuffixIconPressed,
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.md),
          borderSide: const BorderSide(color: AppColors.primaryLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.md),
          borderSide: const BorderSide(color: AppColors.primaryLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.md),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.md),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.md),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
      ),
    );
  }
}

class ChildCustomTextField extends StatelessWidget {
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final IconData? prefixIcon;
  final int? maxLines;
  final bool enabled;
  final FocusNode? focusNode;

  const ChildCustomTextField({
    Key? key,
    this.label,
    this.hint,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.onChanged,
    this.onSubmitted,
    this.prefixIcon,
    this.maxLines = 1,
    this.enabled = true,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      maxLines: maxLines,
      enabled: enabled,
      focusNode: focusNode,
      style: AppTextStyles.childBody.copyWith(
        fontSize: 20,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: AppTextStyles.childBody,
        hintStyle: AppTextStyles.childBody.copyWith(
          color: AppColors.textSecondary.withOpacity(0.7),
        ),
        prefixIcon: prefixIcon != null ? Icon(prefixIcon, size: 24) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.lg),
          borderSide: const BorderSide(color: AppColors.primaryLight, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.lg),
          borderSide: const BorderSide(color: AppColors.primaryLight, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.lg),
          borderSide: const BorderSide(color: AppColors.accent, width: 3),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
} 