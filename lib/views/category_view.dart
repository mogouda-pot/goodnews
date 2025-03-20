import 'package:flutter/material.dart';
import 'package:test1/models/article_model.dart';
import 'package:test1/services/api_service.dart';

class CategoryView extends StatefulWidget {
  final String category;

  const CategoryView({Key? key, required this.category}) : super(key: key);

  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List<Article> _articles = [];

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  void _fetchNews() async {
    final apiService = ApiService();
    final response = await apiService.getTopHeadlines4Category(widget.category);
    final articles = response['articles'].cast<Map<String, dynamic>>();
    setState(() {
      _articles =
          articles.map<Article>((json) => Article.fromJson(json)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[50],
      appBar: AppBar(
        elevation: 5,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
        ),
        backgroundColor: Colors.red,
        shadowColor: Colors.black,
        title: Text(widget.category),
      ),
      body: ListView.builder(
        itemCount: _articles.length,
        itemBuilder: (context, index) {
          final article = _articles[index];
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
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  article.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
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
        },
      ),
    );
  }
}
