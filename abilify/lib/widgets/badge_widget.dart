import 'package:flutter/material.dart';
import 'package:abilify/utils/constants.dart';

class BadgeWidget extends StatelessWidget {
  final String id;
  final String title;
  final String description;
  final String imagePath;
  final bool isUnlocked;
  final int? requiredPoints;
  final String? specialRequirement;

  const BadgeWidget({
    Key? key,
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    this.isUnlocked = false,
    this.requiredPoints,
    this.specialRequirement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(AppSpacing.sm),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppBorderRadius.lg),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppBorderRadius.lg),
          color: isUnlocked ? Colors.white : Colors.grey[200],
        ),
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Badge Image
            Stack(
              alignment: Alignment.center,
              children: [
                // Badge Circle Container
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isUnlocked
                        ? AppColors.badgeBackground
                        : Colors.grey[300],
                    border: Border.all(
                      color: isUnlocked
                          ? AppColors.badgeBorder
                          : Colors.grey[400]!,
                      width: 3,
                    ),
                  ),
                  child: Center(
                    child: isUnlocked
                        ? Image.asset(
                            imagePath,
                            width: 60,
                            height: 60,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.emoji_events,
                                size: 60,
                                color: AppColors.accent,
                              );
                            },
                          )
                        : Icon(
                            Icons.lock,
                            size: 40,
                            color: Colors.grey[600],
                          ),
                  ),
                ),

                // Unlock Status
                if (isUnlocked)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.success,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: AppSpacing.md),

            // Badge Title
            Text(
              title,
              style: AppTextStyles.childBody.copyWith(
                fontWeight: FontWeight.bold,
                color: isUnlocked
                    ? AppColors.textPrimary
                    : AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: AppSpacing.xs),

            // Badge Description
            Text(
              description,
              style: AppTextStyles.bodySmall.copyWith(
                color: isUnlocked
                    ? AppColors.textSecondary
                    : AppColors.textSecondary.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: AppSpacing.sm),

            // Requirements
            if (!isUnlocked) ...[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(AppBorderRadius.sm),
                ),
                child: Text(
                  requiredPoints != null
                      ? 'Need ${requiredPoints! - 0} more points'
                      : specialRequirement ?? 'Complete special task',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
} 