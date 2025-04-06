import 'package:flutter/material.dart';
import '../models/blog_post_model.dart';
import '../utils/constants.dart';

class BlogPostDetailDialog extends StatelessWidget {
  final BlogPost blogPost;

  const BlogPostDetailDialog({super.key, required this.blogPost});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(AppConstants.spacingM),
      child: Container(
        width: size.width * 0.9,
        height: size.height * 0.8,
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[900] : Colors.white,
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
        ),
        child: Column(
          children: [
            // Header with close button
            Padding(
              padding: const EdgeInsets.all(AppConstants.spacingM),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Blog Post',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),

            // Blog post content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppConstants.spacingM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Featured image
                    if (blogPost.imageUrl.isNotEmpty)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                          AppConstants.borderRadiusM,
                        ),
                        child: Image.asset(
                          blogPost.imageUrl,
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: double.infinity,
                              height: 200,
                              color: Colors.grey[300],
                              child: const Icon(
                                Icons.image,
                                size: 50,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                      ),
                    const SizedBox(height: AppConstants.spacingM),

                    // Title
                    Text(
                      blogPost.title,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: AppConstants.spacingS),

                    // Author and date
                    Wrap(
                      spacing: AppConstants.spacingM,
                      runSpacing: AppConstants.spacingS,
                      children: [
                        // Author info
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              radius: 15,
                              backgroundColor: theme.colorScheme.primary
                                  .withAlpha(50),
                              child: Text(
                                blogPost.author[0].toUpperCase(),
                                style: TextStyle(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(width: AppConstants.spacingXS),
                            Flexible(
                              child: Text(
                                blogPost.author,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color:
                                      isDarkMode
                                          ? Colors.white70
                                          : Colors.black87,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),

                        // Date info
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 14,
                              color:
                                  isDarkMode
                                      ? Colors.white70
                                      : Colors.grey[600],
                            ),
                            const SizedBox(width: AppConstants.spacingXS),
                            Text(
                              '${blogPost.publishDate.day}/${blogPost.publishDate.month}/${blogPost.publishDate.year}',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color:
                                    isDarkMode
                                        ? Colors.white70
                                        : Colors.grey[600],
                              ),
                            ),
                          ],
                        ),

                        // Read time info
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 14,
                              color:
                                  isDarkMode
                                      ? Colors.white70
                                      : Colors.grey[600],
                            ),
                            const SizedBox(width: AppConstants.spacingXS),
                            Text(
                              '${blogPost.readTimeMinutes} min read',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color:
                                    isDarkMode
                                        ? Colors.white70
                                        : Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: AppConstants.spacingM),

                    // Tags
                    Wrap(
                      spacing: AppConstants.spacingXS,
                      runSpacing: AppConstants.spacingXS,
                      children:
                          blogPost.tags.map((tag) {
                            return Chip(
                              label: Text(
                                tag,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                              backgroundColor: theme.colorScheme.primary
                                  .withAlpha(25),
                              padding: const EdgeInsets.all(4),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            );
                          }).toList(),
                    ),
                    const SizedBox(height: AppConstants.spacingM),

                    // Content
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        blogPost.excerpt,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: isDarkMode ? Colors.white : Colors.black87,
                          height: 1.6,
                        ),
                        softWrap: true,
                      ),
                    ),
                    const SizedBox(height: AppConstants.spacingM),

                    // Dummy content for the full article
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam auctor, nisl eget ultricies tincidunt, nisl nisl aliquam nisl, eget ultricies nisl nisl eget nisl. Nullam auctor, nisl eget ultricies tincidunt, nisl nisl aliquam nisl, eget ultricies nisl nisl eget nisl.\n\nNullam auctor, nisl eget ultricies tincidunt, nisl nisl aliquam nisl, eget ultricies nisl nisl eget nisl. Nullam auctor, nisl eget ultricies tincidunt, nisl nisl aliquam nisl, eget ultricies nisl nisl eget nisl.\n\nNullam auctor, nisl eget ultricies tincidunt, nisl nisl aliquam nisl, eget ultricies nisl nisl eget nisl. Nullam auctor, nisl eget ultricies tincidunt, nisl nisl aliquam nisl, eget ultricies nisl nisl eget nisl.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: isDarkMode ? Colors.white70 : Colors.black87,
                          height: 1.6,
                        ),
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
