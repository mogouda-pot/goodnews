// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '../models/article_model.dart';
import '../services/api_service.dart';

class ListNewsContainer extends StatefulWidget {
  final String category;
  const ListNewsContainer({super.key, required this.category});

  @override
  State<ListNewsContainer> createState() => _ListNewsContainerState();
}

class _ListNewsContainerState extends State<ListNewsContainer> {
  final ApiService _apiService = ApiService();
  List<Article> articles = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  @override
  void didUpdateWidget(ListNewsContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.category != widget.category) {
      _fetchNews();
    }
  }

  Future<void> _fetchNews() async {
    try {
      setState(() {
        isLoading = true;
        error = null;
      });
      
      print('Fetching news for category: ${widget.category}');
      final response = await _apiService.getTopHeadlines(widget.category);
      print('API Response: $response');
      
      if (response['articles'] != null) {
        setState(() {
          articles = (response['articles'] as List)
              .map((article) => Article.fromJson(article))
              .toList();
          isLoading = false;
        });
        print('Articles loaded: ${articles.length}');
      } else {
        throw Exception('Invalid response format');
      }
    } catch (e) {
      print('Error fetching news: $e');
      setState(() {
        isLoading = false;
        error = e.toString();
        articles = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Expanded(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (error != null) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _fetchNews,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (articles.isEmpty) {
      return const Expanded(
        child: Center(
          child: Text('No articles found'),
        ),
      );
    }

    return Expanded(
      child: RefreshIndicator(
        onRefresh: _fetchNews,
        child: ListView.builder(
          itemCount: articles.length,
          itemBuilder: (BuildContext context, int index) {
            return NewsContainer(article: articles[index]);
          },
        ),
      ),
    );
  }
}

class NewsContainer extends StatelessWidget {
  final Article article;
  
  const NewsContainer({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              article.urlToImage,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.network(
                  "https://via.placeholder.com/400x200",
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Text(
            article.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            article.description,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
