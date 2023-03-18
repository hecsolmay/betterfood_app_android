import 'package:betterfood_app_android/dtos/providers/customprovider.dart';
import 'package:betterfood_app_android/dtos/providers/order_provider.dart';
import 'package:betterfood_app_android/dtos/providers/products_provider.dart';
import 'package:betterfood_app_android/dtos/response/productresponse.dart';
import 'package:betterfood_app_android/widgets/ingredents.dart';
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
  int _counter = 1;
  int total = 0;
  int totalPay = 0;

  void _decrementCounter() {
    setState(() {
      if (_counter > 1) {
        _counter--;
        totalPay = _counter * total;
      }
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      totalPay = _counter * total;
    });
  }

  void _addExtraPrice(int extraPrice) {
    setState(() {
      total += extraPrice;
      totalPay = _counter * total;
    });
  }

  void _removeExtraPrice(int extraPrice) {
    setState(() {
      total -= extraPrice;
      totalPay = _counter * total;
    });
  }

  @override
  void initState() {
    super.initState();
    total = widget.product.price;
    totalPay = widget.product.price;
    Provider.of<CustomIngredentsProvider>(context, listen: false).resetState();
  }

  @override
  Widget build(BuildContext context) {
    // final productProvider = Provider.of<ProductsProvider>(context);
    // final productdetail = productProvider.productdetail;
    final product = widget.product;
    final ingredentsProvider = Provider.of<CustomIngredentsProvider>(context);
    final ordersProvider = Provider.of<OrdersProvider>(context);

    final requiredIngredents = product.ingredents.where((e) => e.required);
    final extraIngredents =
        product.ingredents.where((e) => !e.required && e.extraPrice != 0);
    final removeIngredents =
        product.ingredents.where((e) => !e.required && e.extraPrice == 0);

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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      product.ingredents.isNotEmpty
                          ? IngredentsList(
                              ingredents: requiredIngredents,
                              text: "Ingredientes",
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: 15,
                      ),
                      extraIngredents.isNotEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                BigText(
                                  text: "Ingredientes Extra",
                                  size: 15,
                                ),
                                const SizedBox(height: 10),
                                ...extraIngredents.map((e) {
                                  final ingredentsProvider =
                                      Provider.of<CustomIngredentsProvider>(
                                          context);
                                  final found =
                                      ingredentsProvider.extrasContains(e.id);
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(e.name),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              found ? '1' : '0',
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            ),
                                            const SizedBox(width: 15),
                                            Text(
                                                '\$${e.extraPrice.toStringAsFixed(2)}'),
                                            const SizedBox(width: 16),
                                            found
                                                ? IconButton(
                                                    icon: const Icon(
                                                      Icons
                                                          .remove_circle_outline_rounded,
                                                      color: Colors.black,
                                                    ),
                                                    iconSize: 30,
                                                    onPressed: () {
                                                      _removeExtraPrice(
                                                          e.extraPrice);
                                                      ingredentsProvider
                                                          .removeExtra(e.id);
                                                    },
                                                  )
                                                : IconButton(
                                                    icon: const Icon(
                                                      Icons.add_box_rounded,
                                                      color: Colors.black,
                                                    ),
                                                    iconSize: 30,
                                                    onPressed: () {
                                                      _addExtraPrice(
                                                          e.extraPrice);
                                                      ingredentsProvider
                                                          .addExtra(e.id);
                                                    },
                                                  ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ],
                            )
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
      bottomNavigationBar: Container(
        height: 70,
        padding: const EdgeInsets.only(left: 25, right: 25),
        decoration: const BoxDecoration(
          color: Color.fromARGB(98, 211, 211, 211),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 60,
              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline,
                            color: Color.fromRGBO(186, 0, 0, 1)),
                        onPressed: _decrementCounter,
                      ),
                      const SizedBox(width: 0.5),
                      BigText(text: '$_counter'),
                      const SizedBox(width: 0.5),
                      IconButton(
                        icon: const Icon(Icons.add_circle,
                            color: Color.fromRGBO(186, 0, 0, 1)),
                        onPressed: _incrementCounter,
                      ),
                    ],
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                if (_counter > 0) {
                  final productAdd = Product(
                      product: widget.product,
                      extras: ingredentsProvider.extras,
                      remove: ingredentsProvider.remove,
                      quantity: _counter,
                      price: total);

                  ordersProvider.addProduct(productAdd);
                  print(
                      'agregando el producto ${widget.product.id} la cantidad de $_counter');
                  Navigator.pop(context);
                }
              },
              child: Container(
                padding: const EdgeInsets.only(
                    top: 13, bottom: 13, left: 7, right: 7),
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(10)),
                child: BigText(
                  text: "\$$totalPay  Agregar A la Orden",
                  color: Colors.white,
                  size: 13,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
