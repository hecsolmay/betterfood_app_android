import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  final String productName;
  const ProductDetails({super.key, required this.productName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles'),
      ),
      body: Center(
        child: Text('Aqui van los detalles de $productName'),
      ),
    );
  }
}
