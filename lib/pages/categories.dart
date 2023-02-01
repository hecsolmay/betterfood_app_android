import 'package:flutter/material.dart';

import '../widgets/appbar.dart';
import '../widgets/bottom_navbar.dart';
import '../widgets/categoriacard.dart';
import '../widgets/products_card.dart';
import 'order.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarSearch(),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 110,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                Categoria(
                  nameCategoria: 'Recomenados',
                  routeName: 'wgsrt',
                  urlImg:
                      'https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_960_720.jpg',
                ),
                Categoria(
                  nameCategoria: 'Ensaladas',
                  routeName: 'wgsrt',
                  urlImg:
                      'https://cdn.pixabay.com/photo/2015/05/31/12/58/spinach-791629_960_720.jpg',
                ),
                Categoria(
                  nameCategoria: 'Postres',
                  routeName: 'wgsrt',
                  urlImg:
                      'https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg',
                ),
                Categoria(
                  nameCategoria: 'Carnes',
                  routeName: '/categories',
                  urlImg:
                      'https://cdn.pixabay.com/photo/2016/03/05/23/02/barbecue-1239434_960_720.jpg',
                ),
                Categoria(
                  nameCategoria: 'Pastas',
                  routeName: 'wgsrt',
                  urlImg:
                      'https://cdn.pixabay.com/photo/2016/02/05/15/34/pasta-1181189_960_720.jpg',
                ),
                Categoria(
                  nameCategoria: 'Bebidas',
                  routeName: 'wgsrt',
                  urlImg:
                      'https://cdn.pixabay.com/photo/2016/10/22/20/34/wines-1761613_960_720.jpg',
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) => ProductsCard(
                productName: "Hector $index",
              ),
            ),
          ),
        ],
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
