import 'package:betterfood_app_android/dtos/providers/products_provider.dart';
import 'package:betterfood_app_android/dtos/response/productdetailresponse.dart';
import 'package:flutter/material.dart';
import 'package:betterfood_app_android/common/common.dart';
import 'package:provider/provider.dart';

class Ingredient {
  final String name;
  final double price;

  Ingredient(this.name, this.price);
}

class ExtraIngredient {
  final String name;
  final double price;

  ExtraIngredient(this.name, this.price);
}

class ProductDetails extends StatefulWidget {
  final String id;
  ProductDetails({super.key, required this.id});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final List<Ingredient> _ingredients = [
    Ingredient('Tomato', 0.5),
    Ingredient('Onion', 0.3),
    Ingredient('Pepper', 0.2),
  ];

  final List<ExtraIngredient> _extraIngredients = [
    ExtraIngredient('Cheese', 1.0),
    ExtraIngredient('Mushrooms', 0.8),
    ExtraIngredient('Bacon', 1.5),
  ];

  final List<Ingredient> _selectedIngredients = [];

  void _addIngredient(Ingredient ingredient) {
    setState(() {
      _selectedIngredients.add(ingredient);
    });
  }

  @override
  void initState() {
    super.initState();
    Provider.of<ProductsProvider>(context, listen: false).getById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    final product = productProvider.productdetail;

    final requiredIngredents = product?.ingredents.where((e) => e.required);
    return Scaffold(
      extendBodyBehindAppBar: true,
      
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: const Color.fromRGBO(186, 0, 0, 1),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.shopping_cart_outlined))
              ],
            ),
            expandedHeight: 280,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: productProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : FadeInImage.assetNetwork(
                      width: double.maxFinite,
                      height: 280,
                      placeholder: 'assets/loading.gif',
                      image: product?.imgUrl ??
                          'https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_960_720.jpg',
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          SliverToBoxAdapter(
            child: productProvider.isLoading
                ? Container(
                    height: 300,
                    child: const Center(child: CircularProgressIndicator()),
                  )
                : Container(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BigText(
                          text: product?.name ?? "nombre",
                          overflow: TextOverflow.clip,
                          size: 18,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          product?.description ?? "",
                          style: const TextStyle(
                            height: 1.5,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 20),
                        BigText(
                          text: "MX ${product?.price}",
                          size: 18,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 1,
                          width: 340,
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5)),
                        ),
                        product!.ingredents.isNotEmpty
                            ? IngredentsList(
                                ingredents: requiredIngredents,
                                text: "Ingredientes",
                              )
                            : const SizedBox(),
                        SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'Productos Extra',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 200,
                          child: ListView.builder(
                            itemCount: _extraIngredients.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                title: Text(
                                  _extraIngredients[index].name,
                                  style: TextStyle(fontSize: 15),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                        '\$${_extraIngredients[index].price.toStringAsFixed(2)}'),
                                    const SizedBox(width: 16),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.add_box_rounded,
                                        color: Colors.black,
                                      ),
                                      iconSize: 30,
                                      onPressed: () {
                                        _addIngredient(Ingredient(
                                          _extraIngredients[index].name,
                                          _extraIngredients[index].price,
                                        ));
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        const Text(
                          'Ingredientes que se pueden quitar',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 200,
                          child: ListView.builder(
                            itemCount: _ingredients.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Dismissible(
                                key: Key(_ingredients[index].name),
                                direction: DismissDirection.startToEnd,
                                onDismissed: (direction) {
                                  final removedIngredient =
                                      _ingredients.removeAt(index);
                                  setState(() {});
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Ingrediente eliminado'),
                                      duration: Duration(milliseconds: 15),
                                      action: SnackBarAction(
                                        label: 'Deshacer',
                                        onPressed: () {
                                          setState(() {
                                            _ingredients.insert(
                                                index, removedIngredient);
                                          });
                                        },
                                      ),
                                    ),
                                  );
                                },
                                background: Container(
                                  color: Colors.red,
                                ),
                                child: Container(
                                  padding: EdgeInsets.zero,
                                  child: ListTile(
                                    title: Text(
                                      _ingredients[index].name,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    trailing: Text(
                                        '\$${_ingredients[index].price.toStringAsFixed(2)}'),
                                    onTap: () {
                                      _addIngredient(_ingredients[index]);
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
          )
        ],
      ),
      bottomNavigationBar: productProvider.isLoading
          ? Container(height: 70)
          : BottomCard(price: product?.price ?? 0),
    );
  }
}

class IngredentsList extends StatelessWidget {
  const IngredentsList({
    super.key,
    required this.ingredents,
    required this.text,
  });

  final Iterable<Ingredent>? ingredents;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        BigText(
          text: text,
          size: 15,
        ),
        const SizedBox(height: 10),
        ...ingredents?.map((e) => UnorderedListItem(text: e.name)).toList() ??
            [],
      ],
    );
  }
}

class CheckBoxState {
  final String title;
  bool value;

  CheckBoxState({required this.title, this.value = false});
}

class UnorderedListItem extends StatelessWidget {
  final String text;
  const UnorderedListItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            "• ",
            style: TextStyle(fontSize: 14),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
