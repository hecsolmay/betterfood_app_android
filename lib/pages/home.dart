import 'package:betterfood_app_android/widgets/category_card.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: GridView.count(
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
        crossAxisCount: 2,
        children: const [
          CategoryCard(name: 'Carnes'),
          CategoryCard(name: 'Pasteles'),
          CategoryCard(name: 'Tacos'),
          CategoryCard(name: 'Pizzas'),
          CategoryCard(name: 'Comida Rapida'),
          CategoryCard(name: 'Jugos'),
          CategoryCard(name: 'Gaseosas'),
        ],
      ),
    );
  }
}
