import 'package:betterfood_app_android/common/common.dart';
import 'package:betterfood_app_android/dtos/providers/customprovider.dart';
import 'package:betterfood_app_android/dtos/providers/order_provider.dart';
import 'package:betterfood_app_android/dtos/response/productresponse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomCard extends StatefulWidget {
  final ProductResponseDto product;
  const BottomCard({super.key, required this.product});

  @override
  State<BottomCard> createState() => _BottomCardState();
}

class _BottomCardState extends State<BottomCard> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ingredentsProvider = Provider.of<CustomIngredentsProvider>(context);
    final ordersProvider = Provider.of<OrdersProvider>(context);
    return Container(
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
                    quantity: _counter);

                ordersProvider.addProduct(productAdd);
                print(
                    'agregando el producto ${widget.product.id} la cantidad de $_counter');
                Navigator.pop(context);
              }
            },
            child: Container(
              padding:
                  const EdgeInsets.only(top: 13, bottom: 13, left: 7, right: 7),
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(10)),
              child: BigText(
                text: "\$${widget.product.price}  Agregar A la Orden",
                color: Colors.white,
                size: 13,
              ),
            ),
          )
        ],
      ),
    );
  }
}
