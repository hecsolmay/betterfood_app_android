import 'package:betterfood_app_android/common/common.dart';
import 'package:betterfood_app_android/pages/screens.dart';
import 'package:betterfood_app_android/widgets/products_card.dart';
import 'package:betterfood_app_android/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => ProductsCard(
          productName: "Hector $index",
        ),
      ),
      bottomNavigationBar: GestureDetector(
          onTap: () => showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => DraggableScrollableSheet(
                    initialChildSize: 0.8,
                    expand: false,
                    builder: (context, scrollController) => Order()),
              ),
          child: const BottomNavBar()),
    );
  }
}
