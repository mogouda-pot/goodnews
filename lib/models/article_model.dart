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
      urlToImage:
          json['urlToImage'] ??
          'https://media.gettyimages.com/id/1673064753/vector/breaking-news-world-map-background.jpg?s=612x612&w=gi&k=20&c=xqtMzWHNfVcQHeZosiHAWKJS0QuUtgbZUKJjBlkirBA=',
    );
  }
}