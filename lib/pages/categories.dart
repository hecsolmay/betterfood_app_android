import 'package:flutter/material.dart';
import '../widgets/appbar.dart';
import '../widgets/bottom_navbar.dart';
import '../widgets/products_card.dart';
import 'order.dart';

class Categories extends StatefulWidget {
  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarSearch(),
        backgroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Recomedados'),
            Tab(text: 'Carnes'),
            Tab(text: 'Pastas'),
            Tab(text: 'Ensaladas'),
            Tab(text: 'Postres'),
            Tab(text: 'Bebidas'),
          ],
          labelColor: Color.fromRGBO(186, 0, 0, 1),
          unselectedLabelColor: Color.fromARGB(255, 235, 56, 56),
          indicatorColor: Color.fromRGBO(186, 0, 0, 1),
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 2.0,
          indicatorPadding: EdgeInsets.symmetric(horizontal: 16.0),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) => ProductsCard(
                productName: "Recomendacion $index",
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) => ProductsCard(
                productName: "Carne $index",
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) => ProductsCard(
                productName: "Pasta $index",
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) => ProductsCard(
                productName: "Ensalada $index",
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) => ProductsCard(
                productName: "Postre $index",
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) => ProductsCard(
                productName: "Bebida $index",
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
            builder: (context, scrollController) => const Order(),
          ),
        ),
        child: const BottomNavBar(),
      ),
    );
  }
}
