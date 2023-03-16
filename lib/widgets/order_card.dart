import 'package:betterfood_app_android/common/common.dart';
import 'package:betterfood_app_android/dtos/providers/order_provider.dart';
import 'package:betterfood_app_android/dtos/response/productresponse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'botones_count.dart';

// class OrderCard extends StatelessWidget {
//   const OrderCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Padding(
//       padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
//       child: Card(
//         shadowColor: Colors.amber,
//         child: RowContain(
//           productName: "Hola",
//         ),
//       ),
//     );
//   }
// }

// class RowContain extends StatelessWidget {
//   const RowContain({
//     Key? key,
//     required this.productName,
//   }) : super(key: key);

//   final String productName;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 8.0, right: 8.0),
//       child: Row(
//         mainAxisSize: MainAxisSize.max,
//         children: [
//           ImageBorder(
//             height: 80,
//             image:
//                 "https://cdn.pixabay.com/photo/2014/05/05/19/52/charcuterie-338498_960_720.jpg",
//           ),
//           const SizedBox(width: 15),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 BigText(text: productName),
//                 Text("asavkdlbm am,ssssssssssssssss"),
//                 const SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Buttons(),
//                     Container(
//                       decoration: const BoxDecoration(
//                         color: Color.fromRGBO(186, 0, 0, 1),
//                         borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(5),
//                             bottomRight: Radius.circular(5)),
//                       ),
//                     ),
//                     PriceText(text: '\$360', size: 16),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ignore: must_be_immutable
// class ImageBorder extends StatelessWidget {
//   final String image;
//   double? width;
//   double? height;
//   ImageBorder(
//       {Key? key, required this.image, this.width = 120, this.height = 160})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: width,
//       height: height,
//       child: ClipRRect(
//         child: FadeInImage.assetNetwork(
//             fit: BoxFit.fill, placeholder: 'assets/loading.gif', image: image),
//       ),
//     );
//   }
// }

class OrderCard extends StatelessWidget {
  final Product product;
  final int index;

  const OrderCard({super.key, required this.product, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Card(
        shadowColor: Color.fromARGB(255, 201, 38, 38),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: RowContain(
          index: index,
          product: product.product,
          name: product.product.name,
          description: product.product.description,
          imageUrl: product.product.imgUrl,
          price: product.product.price,
          quantity: product.quantity,
        ),
      ),
    );
  }
}

class RowContain extends StatefulWidget {
  final ProductResponseDto product;
  final int index;
  final int quantity;
  final String name;
  final String description;
  final int price;
  final String imageUrl;
  const RowContain({
    Key? key,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.product,
    required this.quantity,
    required this.index,
  }) : super(key: key);

  @override
  State<RowContain> createState() => _RowContainState();
}

class _RowContainState extends State<RowContain> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    _counter = widget.quantity;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _counter = widget.quantity;
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 1) {
        _counter--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrdersProvider>(context);
    int totalPrice = widget.price * _counter;
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          ImageBorder(image: widget.imageUrl),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 10),
                    BigText(text: widget.name),
                    const SizedBox(height: 10),
                    Paragraph(text: widget.description, maxLines: 2),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PriceText(
                          text: '$_counter x \$${widget.price}',
                          size: 14,
                        ),
                        PriceText(
                          text: '\$$totalPrice',
                          size: 14,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline,
                                  color: Color.fromRGBO(186, 0, 0, 1)),
                              onPressed: () {
                                _decrementCounter();
                                orderProvider.updateQuantity(
                                    widget.index, _counter);
                              },
                            ),
                            const SizedBox(width: 0.5),
                            BigText(text: '$_counter'),
                            const SizedBox(width: 0.5),
                            IconButton(
                              icon: const Icon(Icons.add_circle,
                                  color: Color.fromRGBO(186, 0, 0, 1)),
                              onPressed: () {
                                _incrementCounter();
                                orderProvider.updateQuantity(
                                    widget.index, _counter);
                              },
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            orderProvider.removeProduct(widget.index);
                          },
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all<Size>(
                                const Size(10, 30)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromRGBO(186, 0, 0, 1)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                ),
                              ),
                            ),
                          ),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ImageBorder extends StatelessWidget {
  final String image;
  double? width;
  double? height;
  ImageBorder(
      {Key? key, required this.image, this.width = 120, this.height = 170})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
        // border: Border.all(
        //   color: Colors.black54,
        //   width: 1.0,
        // ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
          child: FadeInImage.assetNetwork(
              fit: BoxFit.fill,
              placeholder: 'assets/loading.gif',
              image: image),
        ),
      ),
    );
  }
}
