import 'package:betterfood_app_android/dtos/providers/categoryprovider.dart';
import 'package:betterfood_app_android/dtos/providers/products_provider.dart';
import 'package:betterfood_app_android/widgets/appbar.dart';
import 'package:betterfood_app_android/widgets/carrusel_img.dart';
import 'package:betterfood_app_android/widgets/category_card.dart';
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
  @override
  onSearch(String search) {
    print(search);
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    await Provider.of<CategoryProvider>(context, listen: false).fetchCategory();
    await Provider.of<ProductsProvider>(context, listen: false).getAll();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarSearch(),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => categoryProvider.isLoading ||
                productProvider.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: constraints.maxWidth > 600
                          ? const EdgeInsets.symmetric(horizontal: 60)
                          : const EdgeInsets.only(left: 30, top: 20),
                      child: const _titleApp(),
                    ),
                    const SizedBox(height: 20),
                    CarouselSlider(
                      items: productProvider.products
                          ?.map((e) => Card_Slider(UrlImage: e.imgUrl))
                          .toList(),
                      options: CarouselOptions(
                        height: 220.0,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        aspectRatio: 16 / 9,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        viewportFraction: 0.8,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          if (constraints.maxWidth < 600) {
                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1,
                                crossAxisSpacing: 0.5,
                                mainAxisSpacing: 0.5,
                              ),
                              itemCount: categoryProvider.categories?.length,
                              itemBuilder: (BuildContext context, int index) {
                                final category =
                                    categoryProvider.categories?[index];
                                return Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Categoria(
                                    nameCategoria: '${category?.name}',
                                    routeName: '/categories',
                                    urlImg: '${category?.imgUrl}',
                                  ),
                                );
                              },
                            );
                          } else {
                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                childAspectRatio: 1,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                              itemCount: categoryProvider.categories?.length,
                              itemBuilder: (BuildContext context, int index) {
                                final category =
                                    categoryProvider.categories?[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: Center(
                                        child: Categoria(
                                      nameCategoria: '${category?.name}',
                                      routeName: '/categories',
                                      urlImg: '${category?.imgUrl}',
                                    )),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class _titleApp extends StatelessWidget {
  const _titleApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            Text(
              'Bienvenido a ',
              style: TextStyle(fontSize: 25, color: Colors.black),
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
              ),
            ),
          ],
        ),
      ],
    );
  }
}
