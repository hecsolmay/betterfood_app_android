import 'package:betterfood_app_android/dtos/providers/categoryprovider.dart';
import 'package:betterfood_app_android/dtos/providers/products_provider.dart';
import 'package:betterfood_app_android/pages/order.dart';
import 'package:betterfood_app_android/widgets/buttons.dart';
import 'package:betterfood_app_android/widgets/error_message.dart';
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
      productProvider.initGetAllByCategory(category!.id);
    }
    _tabController.addListener(_handleTabChange);
  }

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
          return TabBody(
            productProvider: productProvider,
            id: e.id,
          );
        }).toList() ??
        [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorias'),
        iconTheme: const IconThemeData(color: Colors.red),
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20),
        backgroundColor: Colors.white,
        actions: const [SearchButton(), HelpButton(), LogoutButton()],
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
              : RefreshIndicator(
                  onRefresh: () => productProvider.refreshProducts(),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: ListView.builder(
                          itemCount: productProvider.products.length + 1,
                          itemBuilder: (context, index) {
                            if (index == productProvider.products.length) {
                              final hasNext =
                                  productProvider.info?.next ?? false;
                              if (hasNext) {
                                productProvider.getPaginate(
                                    productProvider.info!.currentPage! + 1);
                                return const Padding(
                                  padding:
                                      EdgeInsets.only(top: 10.0, bottom: 10.0),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            } else {
                              return ProductsCard(
                                product: productProvider.products[index],
                              );
                            }
                          },
                        ),
                      ),
                      const Positioned(
                        // Ubicar el FloatingActionButton en la esquina inferior derecha
                        bottom: 30,
                        right: 20,
                        child: ShoppingCartButton(),
                      ),
                    ],
                  ),
                ),
          ...listWidgets,
        ],
      ),
      // bottomNavigationBar: const OrdenList(),
    );
  }
}

class TabBody extends StatelessWidget {
  const TabBody({
    super.key,
    required this.productProvider,
    required this.id,
  });

  final ProductsProvider productProvider;
  final String id;

  @override
  Widget build(BuildContext context) {
    final products = productProvider.productsCategory;
    return RefreshIndicator(
      onRefresh: () => productProvider.getAllByCategory(id),
      child: productProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : productProvider.hasError
              ? const ErrorMessage()
              : RefreshIndicator(
                  onRefresh: () => productProvider.refreshProducts(),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: ListView.builder(
                          itemCount: products.length + 1,
                          itemBuilder: (context, index) {
                            if (index == products.length) {
                              final hasNext =
                                  productProvider.infoCategory?.next ?? false;
                              if (hasNext) {
                                productProvider.getProductsCategoryPaginate(
                                    id,
                                    productProvider.infoCategory!.currentPage! +
                                        1);
                                return const Padding(
                                  padding:
                                      EdgeInsets.only(top: 10.0, bottom: 10.0),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            } else {
                              return ProductsCard(
                                product: products[index],
                              );
                            }
                          },
                        ),
                      ),
                      const Positioned(
                        // Ubicar el FloatingActionButton en la esquina inferior derecha
                        bottom: 30,
                        right: 20,
                        child: ShoppingCartButton(),
                      ),
                    ],
                  ),
                ),
    );
  }
}
