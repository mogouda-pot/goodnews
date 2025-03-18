import 'package:flutter/material.dart';
import 'package:test1/models/CategoryModel.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel categoryModel;
  final Function(String) onCategorySelected;
  final bool isSelected;

  const CategoryCard({
    super.key, 
    required this.categoryModel,
    required this.onCategorySelected,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onCategorySelected(categoryModel.categoryName.toLowerCase()),
      child: Container(
        alignment: Alignment.center,
        width: 150,
        height: 100,
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(categoryModel.imgUrl),
            fit: BoxFit.fill,
          ),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.red,
            width: 2,
            style: BorderStyle.solid,
          ),
        ),
        child: Text(
          categoryModel.categoryName,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}