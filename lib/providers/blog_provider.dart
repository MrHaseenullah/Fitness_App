import 'package:flutter/foundation.dart';
import '../models/blog_post_model.dart';

class BlogProvider with ChangeNotifier {
  final List<BlogPost> _blogPosts = [
    // Original blog posts with updated image paths
    BlogPost(
      id: '1',
      title: 'How to Maximize Your Cardio Workout',
      excerpt:
          'Learn the best techniques to get the most out of your cardio sessions and burn more calories in less time.',
      author: 'Sarah Johnson',
      imageUrl: 'assets/images/cardio.jpg',
      publishDate: DateTime(2023, 10, 15),
      readTimeMinutes: 5,
      tags: ['Cardio', 'Fitness', 'Weight Loss'],
    ),
    BlogPost(
      id: '2',
      title: '5 Essential Arm Exercises for Beginners',
      excerpt:
          'Build stronger arms with these beginner-friendly exercises that target biceps, triceps, and shoulders.',
      author: 'Mike Peterson',
      imageUrl: 'assets/images/arms.jpg',
      publishDate: DateTime(2023, 10, 10),
      readTimeMinutes: 4,
      tags: ['Arms', 'Strength', 'Beginners'],
    ),
    BlogPost(
      id: '3',
      title: 'The Benefits of Yoga for Mental Health',
      excerpt:
          'Discover how incorporating yoga into your routine can reduce stress, anxiety, and improve overall mental wellbeing.',
      author: 'Emma Roberts',
      imageUrl: 'assets/images/yoga.jpg',
      publishDate: DateTime(2023, 10, 5),
      readTimeMinutes: 6,
      tags: ['Yoga', 'Mental Health', 'Wellness'],
    ),
    BlogPost(
      id: '4',
      title: 'Nutrition Tips for Better Workout Recovery',
      excerpt:
          'Learn what to eat before and after workouts to maximize recovery and see better results from your training.',
      author: 'David Chen',
      imageUrl: 'assets/images/pilates.jpg',
      publishDate: DateTime(2023, 9, 28),
      readTimeMinutes: 7,
      tags: ['Nutrition', 'Recovery', 'Fitness'],
    ),
    BlogPost(
      id: '5',
      title: 'How to Stay Motivated with Your Fitness Goals',
      excerpt:
          'Struggling to stay consistent? These proven strategies will help you maintain motivation and achieve your fitness goals.',
      author: 'Lisa Thompson',
      imageUrl: 'assets/images/hiit.jpg',
      publishDate: DateTime(2023, 9, 20),
      readTimeMinutes: 5,
      tags: ['Motivation', 'Goals', 'Fitness'],
    ),

    // New blog posts
    BlogPost(
      id: '6',
      title: 'The Ultimate Guide to HIIT Workouts',
      excerpt:
          'High-Intensity Interval Training (HIIT) is one of the most effective ways to burn fat and improve cardiovascular health. Learn how to structure your HIIT sessions for maximum results.',
      author: 'James Wilson',
      imageUrl: 'assets/images/hiit.jpg',
      publishDate: DateTime(2023, 9, 15),
      readTimeMinutes: 8,
      tags: ['HIIT', 'Cardio', 'Fat Loss'],
    ),
    BlogPost(
      id: '7',
      title: "Pilates for Core Strength: A Beginner's Guide",
      excerpt:
          'Discover how Pilates can transform your core strength and improve your posture. This beginner-friendly guide will help you get started with the most effective Pilates exercises.',
      author: 'Sophia Martinez',
      imageUrl: 'assets/images/pilates.jpg',
      publishDate: DateTime(2023, 9, 10),
      readTimeMinutes: 6,
      tags: ['Pilates', 'Core', 'Beginners'],
    ),
    BlogPost(
      id: '8',
      title: 'Full Body Workouts vs. Split Routines: Which Is Better?',
      excerpt:
          'Should you train your entire body in one session or split your workouts by muscle group? This article breaks down the pros and cons of each approach to help you decide.',
      author: 'Alex Thompson',
      imageUrl: 'assets/images/full_body.jpg',
      publishDate: DateTime(2023, 9, 5),
      readTimeMinutes: 7,
      tags: ['Training', 'Workout Planning', 'Muscle Building'],
    ),
    BlogPost(
      id: '9',
      title: 'The Importance of Stretching: Before and After Workouts',
      excerpt:
          "Many people skip stretching, but it's a crucial part of any fitness routine. Learn why stretching matters and how to incorporate it effectively into your workouts.",
      author: 'Olivia Chen',
      imageUrl: 'assets/images/stretching.jpg',
      publishDate: DateTime(2023, 8, 28),
      readTimeMinutes: 5,
      tags: ['Stretching', 'Recovery', 'Flexibility'],
    ),
    BlogPost(
      id: '10',
      title: 'Building a Stronger Core: Beyond Crunches',
      excerpt:
          'A strong core is about more than just six-pack abs. Discover effective exercises that target all the muscles in your core for better stability, posture, and performance.',
      author: 'Ryan Miller',
      imageUrl: 'assets/images/core.jpg',
      publishDate: DateTime(2023, 8, 20),
      readTimeMinutes: 6,
      tags: ['Core', 'Strength', 'Abs'],
    ),
    BlogPost(
      id: '11',
      title: 'How to Create a Balanced Fitness Routine',
      excerpt:
          'Balance is key to a sustainable fitness journey. Learn how to create a well-rounded routine that includes strength, cardio, flexibility, and recovery for optimal results.',
      author: 'Jennifer Adams',
      imageUrl: 'assets/images/cardio.jpg',
      publishDate: DateTime(2023, 8, 15),
      readTimeMinutes: 8,
      tags: ['Fitness', 'Workout Planning', 'Balance'],
    ),
  ];

  // Get all blog posts
  List<BlogPost> get blogPosts => [..._blogPosts];

  // Get recent blog posts (limited to a specific number)
  List<BlogPost> getRecentBlogPosts({int limit = 3}) {
    return _blogPosts.take(limit).toList();
  }

  // Get a specific blog post by ID
  BlogPost? getBlogPostById(String id) {
    try {
      return _blogPosts.firstWhere((post) => post.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get blog posts by tag
  List<BlogPost> getBlogPostsByTag(String tag) {
    return _blogPosts.where((post) => post.tags.contains(tag)).toList();
  }
}
