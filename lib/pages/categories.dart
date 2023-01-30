import 'package:betterfood_app_android/widgets/products_card.dart';
import 'package:flutter/material.dart';
import 'package:betterfood_app_android/common/common.dart';

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
        bottomNavigationBar: Container(
          height: 70,
          // padding:
          // const EdgeInsets.only(top: 20, bottom: 20, left: 25, right: 25),
          decoration: const BoxDecoration(
            color: Color.fromARGB(98, 211, 211, 211),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
        ));
  }
}
/*

GridView.count(
        crossAxisSpacing: 1,
        mainAxisSpacing: 2,
        crossAxisCount: 1,
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
*/
