import 'package:betterfood_app_android/screens/product_details.dart';
import 'package:flutter/material.dart';

class ProductsCard extends StatelessWidget {
  final String productName;
  const ProductsCard({super.key, required this.productName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: Center(
          child: Text(productName),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                const ProductDetails(productName: 'productName'),
          ),
        );
      },
    );
  }
}
