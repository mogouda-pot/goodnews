import 'package:flutter/material.dart';
import 'package:test1/models/CategoryModel.dart';
import '../views/category_card.dart';

class ListCatgoryContainer extends StatefulWidget {
  final Function(String) onCategorySelected;
  
  const ListCatgoryContainer({
    super.key,
    required this.onCategorySelected,
  });

  @override
  State<ListCatgoryContainer> createState() => _ListCatgoryContainerState();
}

class _ListCatgoryContainerState extends State<ListCatgoryContainer> {
  String selectedCategory = 'general';
  
  final List<CategoryModel> categories = [
    CategoryModel(imgUrl: 'images/business.jpg', categoryName: 'Business'),
    CategoryModel(imgUrl: 'images/entertainment.jpg', categoryName: 'Entertainment'),
    CategoryModel(imgUrl: 'images/general.jpg', categoryName: 'General'),
    CategoryModel(imgUrl: 'images/health.avif', categoryName: 'Health'),
    CategoryModel(imgUrl: 'images/science.jpg', categoryName: 'Science'),
    CategoryModel(imgUrl: 'images/sports.avif', categoryName: 'Sports'),
    CategoryModel(imgUrl: 'images/technology.jpg', categoryName: 'Technology'),
  ];

  void _handleCategorySelection(String category) {
    setState(() {
      selectedCategory = category;
    });
    widget.onCategorySelected(category);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100,
          width: double.infinity,
          child: ListView.builder(
            itemCount: categories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              final category = categories[index];
              return CategoryCard(
                categoryModel: category,
                onCategorySelected: _handleCategorySelection,
                isSelected: category.categoryName.toLowerCase() == selectedCategory,
              );
            },
          ),
        ),
      ],
    );
  }
}
