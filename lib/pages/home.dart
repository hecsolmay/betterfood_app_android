import 'package:betterfood_app_android/dtos/providers/categoryprovider.dart';
import 'package:betterfood_app_android/dtos/providers/mesa_provider.dart';
import 'package:betterfood_app_android/dtos/providers/register_provider.dart';
import 'package:betterfood_app_android/dtos/providers/products_provider.dart';
import 'package:betterfood_app_android/widgets/buttons.dart';
import 'package:betterfood_app_android/widgets/category_card.dart';
import 'package:betterfood_app_android/widgets/error_message.dart';
import 'package:betterfood_app_android/widgets/slider_item.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _carruselOptions = CarouselOptions(
    height: 220.0,
    enlargeCenterPage: true,
    autoPlay: true,
    aspectRatio: 16 / 9,
    autoPlayCurve: Curves.fastOutSlowIn,
    enableInfiniteScroll: true,
    autoPlayAnimationDuration: const Duration(milliseconds: 800),
    viewportFraction: 0.8,
  );

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future<void> loadData() async {
    Provider.of<CategoryProvider>(context, listen: false).fetchCategory();
    Provider.of<ProductsProvider>(context, listen: false).getAll();
  }

  Future<void> refreshData() async {
    Provider.of<CategoryProvider>(context, listen: false).refreshCategory();
    Provider.of<ProductsProvider>(context, listen: false).refreshProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 241, 241, 241),
        foregroundColor: Colors.red,
        shadowColor: Colors.black26,
        actions: const [SearchButton(), HelpButton()],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => SafeArea(
          child: RefreshIndicator(
            onRefresh: () => refreshData(),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TitleApp(),
                          const SizedBox(height: 20),
                          categoryProvider.isLoading ||
                                  productProvider.isLoading
                              ? const SizedBox(
                                  height: 400,
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                )
                              : categoryProvider.hasError ||
                                      productProvider.hasError
                                  ? const ErrorMessage()
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CarouselSlider(
                                          items: productProvider.products
                                              .map((e) => CardSlider(
                                                  urlImage: e.imgUrl))
                                              .toList(),
                                          options: _carruselOptions,
                                        ),
                                        const SizedBox(height: 20),
                                        const SectionText(text: 'Categorias'),
                                        const SizedBox(height: 15),
                                        LayoutBuilder(
                                          builder: (context, constraints) {
                                            return GridView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount:
                                                    constraints.maxWidth < 600
                                                        ? 2
                                                        : 3,
                                                childAspectRatio: 1,
                                                crossAxisSpacing:
                                                    constraints.maxWidth < 600
                                                        ? 0.5
                                                        : 10,
                                                mainAxisSpacing:
                                                    constraints.maxWidth < 600
                                                        ? 0.5
                                                        : 10,
                                              ),
                                              itemCount: categoryProvider
                                                  .categories?.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                final category =
                                                    categoryProvider
                                                        .categories?[index];
                                                return Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Categoria(
                                                    index: index,
                                                    nameCategoria:
                                                        '${category?.name}',
                                                    urlImg:
                                                        '${category?.imgUrl}',
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SectionText extends StatelessWidget {
  final String text;
  const SectionText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class TitleApp extends StatelessWidget {
  const TitleApp({super.key});

  @override
  Widget build(BuildContext context) {
    final table = Provider.of<RegisterProvider>(context).table;
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Column(
        children: [
          Row(
            children: const [
              Text(
                'Bienvenido a ',
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            children: const [
              Text(
                'BETTER FOOD',
                style: TextStyle(
                    fontSize: 25,
                    color: Color.fromRGBO(186, 0, 0, 1),
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              if (table != null)
                Text(
                  'Mesa #: ${table.numMesa}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}
