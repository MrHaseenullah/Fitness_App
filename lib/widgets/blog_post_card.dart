import 'package:flutter/material.dart';
import '../models/blog_post_model.dart';
import '../utils/constants.dart';
import 'blog_post_detail_dialog.dart';

class BlogPostCard extends StatelessWidget {
  final BlogPost blogPost;

  const BlogPostCard({
    super.key,
    required this.blogPost,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => BlogPostDetailDialog(blogPost: blogPost),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: AppConstants.spacingM),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[800] : Colors.white,
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
          border: isDarkMode ? Border.all(color: Colors.grey[700]!, width: 1) : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(isDarkMode ? 30 : 10),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Blog image
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppConstants.borderRadiusL),
                topRight: Radius.circular(AppConstants.borderRadiusL),
              ),
              child: Image.asset(
                blogPost.imageUrl,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 120,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image, size: 40, color: Colors.grey),
                  );
                },
              ),
            ),
            
            // Blog content
            Padding(
              padding: const EdgeInsets.all(AppConstants.spacingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    blogPost.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppConstants.spacingXS),
                  
                  // Excerpt
                  Text(
                    blogPost.excerpt,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isDarkMode ? Colors.white70 : Colors.grey[700],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppConstants.spacingS),
                  
                  // Author and read time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: theme.colorScheme.primary.withOpacity(0.2),
                            child: Text(
                              blogPost.author[0].toUpperCase(),
                              style: TextStyle(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ),
                          const SizedBox(width: AppConstants.spacingXS),
                          Text(
                            blogPost.author,
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: isDarkMode ? Colors.white70 : Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 12,
                            color: isDarkMode ? Colors.white70 : Colors.grey[600],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${blogPost.readTimeMinutes} min read',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: isDarkMode ? Colors.white70 : Colors.grey[600],
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
