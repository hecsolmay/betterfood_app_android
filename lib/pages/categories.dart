import 'package:betterfood_app_android/dtos/providers/categoryprovider.dart';
import 'package:betterfood_app_android/dtos/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/appbar.dart';
import '../widgets/orden_list.dart';
import '../widgets/products_card.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const AppBarSearch(),
        backgroundColor: Colors.white,
        bottom: TabBar(
          physics: const BouncingScrollPhysics(),
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Todos'),
            Tab(text: 'Recomendados'),
            Tab(text: 'Carnes'),
            Tab(text: 'Pastas'),
            // Tab(text: 'Ensaladas'),
            // Tab(text: 'Postres'),
            // Tab(text: 'Bebidas'),
          ],
          labelColor: const Color.fromRGBO(186, 0, 0, 1),
          unselectedLabelColor: const Color.fromARGB(255, 235, 56, 56),
          indicatorColor: const Color.fromRGBO(186, 0, 0, 1),
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 2.0,
          indicatorPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        ),
      ),
      body: TabBarView(
        physics: const BouncingScrollPhysics(),
        controller: _tabController,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: productProvider.products?.length,
              itemBuilder: (context, index) => ProductsCard(
                product: productProvider.products![index],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: productProvider.products?.length,
              itemBuilder: (context, index) => ProductsCard(
                product: productProvider.products![index],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: productProvider.products?.length,
              itemBuilder: (context, index) => ProductsCard(
                product: productProvider.products![index],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: productProvider.products?.length,
              itemBuilder: (context, index) => ProductsCard(
                product: productProvider.products![index],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const orden_list(),
    );
  }
}
