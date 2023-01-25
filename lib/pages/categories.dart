import 'package:betterfood_app_android/widgets/products_card.dart';
import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: GridView.count(
        crossAxisSpacing: 1,
        mainAxisSpacing: 2,
        crossAxisCount: 2,
        children: const [
          ProductsCard(productName: 'productName'),
          ProductsCard(productName: 'productName'),
          ProductsCard(productName: 'productName'),
          ProductsCard(productName: 'productName'),
          ProductsCard(productName: 'productName'),
          ProductsCard(productName: 'productName'),
          ProductsCard(productName: 'productName'),
          ProductsCard(productName: 'productName'),
        ],
      ),
    );
  }
}
