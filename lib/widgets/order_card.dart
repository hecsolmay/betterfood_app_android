import 'package:betterfood_app_android/common/common.dart';
import 'package:flutter/material.dart';

import 'botones_count.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: const Padding(
        padding: EdgeInsets.only(bottom: 8.0),
        child: Card(
          child: RowContain(
            productName: "Hola",
          ),
        ),
      ),
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
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          ImageBorder(
            height: 80,
            image:
                "https://cdn.pixabay.com/photo/2014/05/05/19/52/charcuterie-338498_960_720.jpg",
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BigText(text: productName),
                const SizedBox(height: 20),
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
                    ),
                    PriceText(text: '\$360', size: 16),
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
      {Key? key, required this.image, this.width = 120, this.height = 160})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        child: FadeInImage.assetNetwork(
            fit: BoxFit.fill, placeholder: 'assets/loading.gif', image: image),
      ),
    );
  }
}
