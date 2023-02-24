import 'dart:developer';

import 'package:betterfood_app_android/common/common.dart';
import 'package:betterfood_app_android/pages/product_details.dart';
import 'package:flutter/material.dart';

import 'botones_count.dart';

class ProductsCard extends StatelessWidget {
  final String productName;
  bool description;
  ProductsCard({super.key, required this.productName, this.description = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: RowContain(
            productName: productName,
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetails(productName: productName),
          ),
        );
      },
    );
  }
}

class RowContain extends StatelessWidget {
  const RowContain({
    Key? key,
    required this.productName,
  }) : super(key: key);

  final String productName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          ImageBorder(
            image:
                "https://cdn.pixabay.com/photo/2014/05/05/19/52/charcuterie-338498_960_720.jpg",
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),
                BigText(text: productName),
                const SizedBox(height: 10),
                Paragraph(
                    text:
                        "assksad msdkamsdk  admaskmdk Adipisicing v Sunt sunt cillum cupidatat nulla do duis do ex incididunt exercitation.",
                    maxLines: 3),
                const SizedBox(height: 10),
                PriceText(text: '\$360', size: 14),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Buttons(),
                    Container(
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(186, 0, 0, 1),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5)),
                      ),
                      child: const Icon(Icons.add, color: Colors.white),
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

class ImageBorder extends StatelessWidget {
  final String image;
  double? width;
  double? height;
  ImageBorder(
      {Key? key, required this.image, this.width = 120, this.height = 170})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
        child: FadeInImage.assetNetwork(
            fit: BoxFit.fill, placeholder: 'assets/loading.gif', image: image),
      ),
    );
  }
}
