import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:abilify/models/resource.dart';
import 'package:abilify/utils/constants.dart';

class ResourceCard extends StatelessWidget {
  final Resource resource;
  final VoidCallback onTap;
  final bool isBookmarked;
  final Function(bool)? onBookmarkToggle;

  const ResourceCard({
    Key? key,
    required this.resource,
    required this.onTap,
    this.isBookmarked = false,
    this.onBookmarkToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(
        vertical: AppSpacing.sm,
        horizontal: AppSpacing.sm,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppBorderRadius.md),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppBorderRadius.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Resource Image or Type Icon
            resource.imageUrl != null
                ? ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(AppBorderRadius.md),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: resource.imageUrl!,
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        height: 120,
                        color: AppColors.background,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        height: 120,
                        color: _getCategoryColor(resource.category),
                        child: Icon(
                          _getTypeIcon(resource.type),
                          size: 48,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                : Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: _getCategoryColor(resource.category),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(AppBorderRadius.md),
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        _getTypeIcon(resource.type),
                        size: 48,
                        color: Colors.white,
                      ),
                    ),
                  ),

            // Resource Content
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Bookmark
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          resource.title,
                          style: AppTextStyles.heading3,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (onBookmarkToggle != null)
                        IconButton(
                          icon: Icon(
                            isBookmarked
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            color: isBookmarked
                                ? AppColors.accent
                                : AppColors.textSecondary,
                          ),
                          onPressed: () => onBookmarkToggle!(!isBookmarked),
                        ),
                    ],
                  ),

                  // Category Chip
                  Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.xs),
                    child: Chip(
                      label: Text(
                        _formatCategory(resource.category),
                        style: AppTextStyles.bodySmall.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: _getCategoryColor(resource.category),
                      padding: const EdgeInsets.all(0),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),

                  // Content Preview
                  Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.sm),
                    child: Text(
                      resource.content,
                      style: AppTextStyles.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to get category color
  Color _getCategoryColor(String category) {
    switch (category) {
      case 'sensory':
        return AppColors.sensory;
      case 'speech':
        return AppColors.speech;
      case 'occupational':
        return AppColors.occupational;
      case 'behavioral':
        return AppColors.behavioral;
      case 'educational':
        return AppColors.educational;
      case 'parenting':
        return AppColors.parenting;
      default:
        return AppColors.primary;
    }
  }

  // Helper method to get icon based on resource type
  IconData _getTypeIcon(String type) {
    switch (type) {
      case 'article':
        return Icons.article;
      case 'video':
        return Icons.video_library;
      case 'guide':
        return Icons.menu_book;
      default:
        return Icons.insert_drive_file;
    }
  }

  // Helper method to format category name
  String _formatCategory(String category) {
    return category.substring(0, 1).toUpperCase() + category.substring(1);
  }
} 