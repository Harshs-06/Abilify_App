import 'package:flutter/material.dart';
import 'package:abilify/utils/constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double height;
  final double borderRadius;
  final IconData? icon;
  final bool isLoading;
  final bool isOutlined;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height = 50.0,
    this.borderRadius = AppBorderRadius.md,
    this.icon,
    this.isLoading = false,
    this.isOutlined = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? 
        (isOutlined ? Colors.transparent : AppColors.primary);
    final txtColor = textColor ?? 
        (isOutlined ? AppColors.primary : AppColors.textLight);
    
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: txtColor,
          elevation: isOutlined ? 0 : 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: isOutlined
                ? BorderSide(color: AppColors.primary)
                : BorderSide.none,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon),
                    const SizedBox(width: AppSpacing.sm),
                  ],
                  Text(
                    text,
                    style: AppTextStyles.button.copyWith(
                      color: txtColor,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class ChildCustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double height;
  final double borderRadius;
  final IconData? icon;
  final bool isLoading;

  const ChildCustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height = 60.0,
    this.borderRadius = AppBorderRadius.lg,
    this.icon,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? AppColors.accent;
    final txtColor = textColor ?? AppColors.textLight;
    
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: txtColor,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                  color: AppColors.textLight,
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 28),
                    const SizedBox(width: AppSpacing.md),
                  ],
                  Text(
                    text,
                    style: AppTextStyles.childButton.copyWith(
                      color: txtColor,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
} 