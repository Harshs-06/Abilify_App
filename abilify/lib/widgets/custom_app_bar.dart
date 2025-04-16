import 'package:flutter/material.dart';
import 'package:abilify/utils/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final Color? backgroundColor;
  final Widget? leading;
  final double elevation;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.showBackButton = true,
    this.onBackPressed,
    this.backgroundColor,
    this.leading,
    this.elevation = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: AppTextStyles.heading2.copyWith(
          color: AppColors.textLight,
        ),
      ),
      backgroundColor: backgroundColor ?? AppColors.primary,
      elevation: elevation,
      centerTitle: true,
      leading: showBackButton && Navigator.canPop(context)
          ? leading ??
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: onBackPressed ?? () => Navigator.pop(context),
              )
          : null,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class ChildCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final Color? backgroundColor;
  final Widget? leading;
  final double elevation;

  const ChildCustomAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.showBackButton = true,
    this.onBackPressed,
    this.backgroundColor,
    this.leading,
    this.elevation = 4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: AppTextStyles.childHeading.copyWith(
          color: AppColors.textLight,
          fontSize: 24,
        ),
      ),
      backgroundColor: backgroundColor ?? AppColors.accent,
      elevation: elevation,
      centerTitle: true,
      leading: showBackButton && Navigator.canPop(context)
          ? leading ??
              IconButton(
                icon: const Icon(Icons.arrow_back, size: 28),
                onPressed: onBackPressed ?? () => Navigator.pop(context),
              )
          : null,
      actions: actions,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(AppBorderRadius.lg),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
} 