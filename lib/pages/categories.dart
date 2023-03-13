import 'package:betterfood_app_android/dtos/providers/categoryprovider.dart';
import 'package:betterfood_app_android/dtos/providers/products_provider.dart';
import 'package:betterfood_app_android/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:betterfood_app_android/widgets/orden_list.dart';
import 'package:betterfood_app_android/widgets/products_card.dart';

class Categories extends StatefulWidget {
  final int index;
  const Categories({super.key, required this.index});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    int tabLength = Provider.of<CategoryProvider>(context, listen: false)
            .categories!
            .length +
        1;

    int inicialIndex = widget.index;

    if (inicialIndex == 0) {
      _tabController = TabController(length: tabLength, vsync: this);
    } else {
      _tabController = TabController(
          length: tabLength, vsync: this, initialIndex: inicialIndex);
      final categoryProvider =
          Provider.of<CategoryProvider>(context, listen: false);
      final productProvider =
          Provider.of<ProductsProvider>(context, listen: false);

      productProvider.isLoading = true;
      final category = categoryProvider.categories?[inicialIndex - 1];
      productProvider.getAllByCategory(category!.id);
    }
    _tabController.addListener(_handleTabChange);
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   int inicialIndex = ModalRoute.of(context)?.settings.arguments as int? ?? 0;
  //   int tabLength = Provider.of<CategoryProvider>(context, listen: false)
  //           .categories!
  //           .length +
  //       1;

  //   if (inicialIndex == 0) {
  //     _tabController = TabController(length: tabLength, vsync: this);
  //   } else {
  //     _tabController = TabController(
  //         length: tabLength, vsync: this, initialIndex: inicialIndex);
  //     final categoryProvider =
  //         Provider.of<CategoryProvider>(context, listen: false);
  //     // final productProvider =
  //     //     Provider.of<ProductsProvider>(context, listen: false);

  //     // productProvider.isLoading = true;
  //     final category = categoryProvider.categories?[inicialIndex - 1];
  //     Provider.of<ProductsProvider>(
  //       context,
  //     ).getAllByCategory(category!.id);
  //   }
  //   _tabController.addListener(_handleTabChange);
  // }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    if (!_tabController.indexIsChanging) {
      final selectedTabIndex = _tabController.index;
      if (selectedTabIndex != 0) {
        final categoryProvider =
            Provider.of<CategoryProvider>(context, listen: false);
        final productProvider =
            Provider.of<ProductsProvider>(context, listen: false);

        if (selectedTabIndex != 0) {
          productProvider.isLoading = true;
          final category = categoryProvider.categories?[selectedTabIndex - 1];
          productProvider.getAllByCategory(category!.id);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final productProvider = Provider.of<ProductsProvider>(context);
    final listWidgets = categoryProvider.categories?.map((e) {
          return TabBody(productProvider: productProvider);
        }).toList() ??
        [];
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.red),
        backgroundColor: Colors.white,
        actions: const [SearchButton(), HelpButton()],
        bottom: TabBar(
          physics: const BouncingScrollPhysics(),
          controller: _tabController,
          isScrollable: true,
          tabs: [
            const Tab(text: "Todos"),
            ...categoryProvider.categories?.map((item) {
                  return Tab(text: item.name);
                }).toList() ??
                []
          ],
          onTap: (int index) {
            if (index == 0) {
            } else {
              final category = categoryProvider.categories?[index - 1];
              final stringId = category!.id;
              productProvider.getAllByCategory(stringId);
            }
          },
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
          productProvider.isLoading || categoryProvider.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: ListView.builder(
                      itemCount: productProvider.products?.length,
                      itemBuilder: (context, index) => ProductsCard(
                        product: productProvider.products![index],
                      ),
                    ),
                  ),
                ),
          ...listWidgets,
        ],
      ),
      bottomNavigationBar: const orden_list(),
    );
  }
}

class TabBody extends StatelessWidget {
  const TabBody({
    super.key,
    required this.productProvider,
  });

  final ProductsProvider productProvider;

  @override
  Widget build(BuildContext context) {
    final products = productProvider.productsCategory;
    return Expanded(
      child: productProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.only(top: 25),
              child: ListView.builder(
                itemCount: products?.length,
                itemBuilder: (context, index) => ProductsCard(
                  product: products![index],
                ),
              ),
            ),
    );
  }
}
