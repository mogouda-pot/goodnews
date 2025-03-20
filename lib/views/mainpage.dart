import 'package:flutter/material.dart';
import 'package:test1/views/category_view.dart';

import '../widget/cus_apppbar.dart';
import '../widget/list-cat-container.dart';
import '../widget/list-news-container.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String selectedCategory = 'general';

  void updateCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              ListCatgoryContainer(
                onCategorySelected: (category) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CategoryView(category: category),
                    ),
                  );
                },
              ),

              ListNewsContainer(),
            ],
          ),
        ),
      ),
    );
  }
}
