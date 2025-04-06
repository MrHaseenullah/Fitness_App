class BlogPost {
  final String id;
  final String title;
  final String excerpt;
  final String author;
  final String imageUrl;
  final DateTime publishDate;
  final int readTimeMinutes;
  final List<String> tags;

  BlogPost({
    required this.id,
    required this.title,
    required this.excerpt,
    required this.author,
    required this.imageUrl,
    required this.publishDate,
    required this.readTimeMinutes,
    required this.tags,
  });
}
