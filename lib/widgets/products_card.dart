import 'package:betterfood_app_android/common/common.dart';
import 'package:betterfood_app_android/dtos/response/productresponse.dart';
import 'package:betterfood_app_android/pages/product_details.dart';
import 'package:flutter/material.dart';

import 'botones_count.dart';

class ProductsCard extends StatelessWidget {
  final ProductResponseDto product;
  const ProductsCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: RowContain(
            id: product.id,
            name: product.name,
            description: product.description,
            imageUrl: product.imgUrl,
            price: product.price,
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetails(
              product: product,
            ),
          ),
        );
      },
    );
  }
}

class RowContain extends StatefulWidget {
  final String id;
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
    required this.id,
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

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          ImageBorder(
            image: widget.imageUrl,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),
                BigText(text: widget.name),
                const SizedBox(height: 10),
                Paragraph(text: widget.description, maxLines: 3),
                const SizedBox(height: 10),
                PriceText(text: '\$${widget.price}', size: 14),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    ),
                    Container(
                      height: 20,
                      width: 20,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(186, 0, 0, 1),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                      ),
                      child: IconButton(
                        iconSize: 10.0,
                        color: Colors.white,
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          print(
                              'El Producto ${widget.id} se pidio una cantidad de $_counter');
                        },
                      ),
                    )
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
