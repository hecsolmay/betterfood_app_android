import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String name;
  const CategoryCard({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: Center(
          child: Text(name),
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, '/categories');
      },
    );
  }
}
