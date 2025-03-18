class Article {
  final String title;
  final String description;
  final String urlToImage;

  Article({
    required this.title,
    required this.description,
    required this.urlToImage,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      urlToImage: json['urlToImage'] ?? 'https://thumbs.dreamstime.com/b/breaking-news-background-breaking-news-background-world-global-tv-news-banner-design-100399311.jpg',
    );
  }
}