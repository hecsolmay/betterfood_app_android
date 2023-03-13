import 'package:betterfood_app_android/dtos/providers/customprovider.dart';
import 'package:betterfood_app_android/dtos/providers/products_provider.dart';
import 'package:betterfood_app_android/dtos/response/productdetailresponse.dart';
import 'package:betterfood_app_android/dtos/response/productresponse.dart';
import 'package:flutter/material.dart';
import 'package:betterfood_app_android/common/common.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  final ProductResponseDto product;
  const ProductDetails({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  void initState() {
    super.initState();

    Provider.of<ProductsProvider>(context, listen: false)
        .getById(widget.product.id);
    Provider.of<CustomIngredentsProvider>(context, listen: false).resetState();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    final ingredentProvider = Provider.of<CustomIngredentsProvider>(context);
    final productdetail = productProvider.productdetail;
    final product = widget.product;

    final requiredIngredents =
        productdetail?.ingredents.where((e) => e.required);
    final extraIngredents = productdetail?.ingredents
        .where((e) => !e.required && e.extraPrice != 0);
    final removeIngredents = productdetail?.ingredents
            .where((e) => !e.required && e.extraPrice == 0) ??
        [];

    if (removeIngredents.isNotEmpty) {
      ingredentProvider.addIngredentsRemove(removeIngredents);
    }

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
              background: FadeInImage.assetNetwork(
                width: double.maxFinite,
                height: 280,
                placeholder: 'assets/loading.gif',
                image: product.imgUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(
                      text: product.name,
                      overflow: TextOverflow.clip,
                      size: 18),
                  const SizedBox(height: 20),
                  Text(
                    product.description,
                    style: const TextStyle(
                      height: 1.5,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 20),
                  BigText(
                    text: "MX ${product.price}",
                    size: 18,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 1,
                    width: 340,
                    decoration:
                        BoxDecoration(color: Colors.black.withOpacity(0.5)),
                  ),
                  productProvider.isLoading
                      ? const SizedBox(
                          height: 300,
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            productdetail!.ingredents.isNotEmpty
                                ? IngredentsList(
                                    ingredents: requiredIngredents,
                                    text: "Ingredientes",
                                  )
                                : const SizedBox(),
                            const SizedBox(
                              height: 15,
                            ),
                            extraIngredents!.isNotEmpty
                                ? ListExtraIngredents(
                                    extraIngredents: extraIngredents)
                                : const SizedBox(),
                            removeIngredents.isNotEmpty
                                ? ListRemoveIngredents(
                                    removeIngredents: removeIngredents)
                                : const SizedBox(),
                          ],
                        )
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomCard(price: product.price),
    );
  }
}

class ListRemoveIngredents extends StatelessWidget {
  const ListRemoveIngredents({
    super.key,
    required this.removeIngredents,
  });

  final Iterable<Ingredent> removeIngredents;

  @override
  Widget build(BuildContext context) {
    final ingredentProvider = Provider.of<CustomIngredentsProvider>(context);
    final removeIngredents = ingredentProvider.ingredentsRemove;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        BigText(
          text: "Ingredientes que se pueden quitar",
          size: 15,
        ),
        const SizedBox(height: 20),
        ...removeIngredents!
            .map((e) => RemoveIngredent(id: e.id, name: e.name))
            .toList(),
      ],
    );
  }
}

class RemoveIngredent extends StatelessWidget {
  final String id;
  final String name;
  const RemoveIngredent({
    super.key,
    required this.id,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final ingredentProvider = Provider.of<CustomIngredentsProvider>(context);
    return Dismissible(
      key: Key(id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        print('eliminando $id');
        ingredentProvider.deleteIngredentRemove(id);
        ingredentProvider.addRemove(id);
      },
      background: Container(
        color: Colors.red,
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: SizedBox(
          height: 40,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text(name),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListExtraIngredents extends StatelessWidget {
  const ListExtraIngredents({
    super.key,
    required this.extraIngredents,
  });

  final Iterable<Ingredent> extraIngredents;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        BigText(
          text: "Ingredientes Extra",
          size: 15,
        ),
        const SizedBox(height: 10),
        ...extraIngredents.map((e) {
          // final bool found =
          //     extras.contains(e.id);
          return ExtraIngredent(
            id: e.id,
            name: e.name,
            extraPrice: e.extraPrice,
          );
        }).toList(),
      ],
    );
  }
}

class ExtraIngredent extends StatelessWidget {
  final String name;
  final int extraPrice;
  final String id;
  const ExtraIngredent({
    super.key,
    required this.name,
    required this.id,
    required this.extraPrice,
  });

  @override
  Widget build(BuildContext context) {
    final ingredentsProvider = Provider.of<CustomIngredentsProvider>(context);
    final found = ingredentsProvider.extrasContains(id);
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                found ? '1' : '0',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(width: 15),
              Text('\$${extraPrice.toStringAsFixed(2)}'),
              const SizedBox(width: 16),
              found
                  ? IconButton(
                      icon: const Icon(
                        Icons.remove_circle_outline_rounded,
                        color: Colors.black,
                      ),
                      iconSize: 30,
                      onPressed: () {
                        print("Eliminando el ingrediente $id");
                        ingredentsProvider.removeExtra(id);
                      },
                    )
                  : IconButton(
                      icon: const Icon(
                        Icons.add_box_rounded,
                        color: Colors.black,
                      ),
                      iconSize: 30,
                      onPressed: () {
                        print("Agregando el ingrediente $id");
                        ingredentsProvider.addExtra(id);
                      },
                    ),
            ],
          ),
        ],
      ),
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
