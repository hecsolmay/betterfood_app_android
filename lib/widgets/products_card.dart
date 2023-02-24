import 'dart:developer';

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
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: RowContain(
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
            builder: (context) => ProductDetails(productName: product.name),
          ),
        );
      },
    );
  }
}

class RowContain extends StatelessWidget {
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          ImageBorder(
            image: imageUrl,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),
                BigText(text: name),
                const SizedBox(height: 10),
                Paragraph(text: description, maxLines: 3),
                const SizedBox(height: 10),
                PriceText(text: '\$$price', size: 14),
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
