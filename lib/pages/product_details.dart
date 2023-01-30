import 'package:flutter/material.dart';
import 'package:betterfood_app_android/common/common.dart';

class ProductDetails extends StatelessWidget {
  final String productName;
  const ProductDetails({super.key, required this.productName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Positioned(
                left: 0,
                right: 0,
                child: FadeInImage.assetNetwork(
                  width: double.maxFinite,
                  height: 300,
                  placeholder: 'assets/loading.gif',
                  image:
                      "https://cdn.pixabay.com/photo/2023/01/08/18/42/road-7705906_960_720.jpg",
                  fit: BoxFit.cover,
                )),
            Positioned(
              top: 280,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      text:
                          "Nombre del Product dfsdf sdmmasmks askmakskas askdmaskmf skdmaks",
                      overflow: TextOverflow.clip,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                        "Excepteur sunt commodo nostrud excepteur. Sit laborum eiusmod dolore occaecat non et. Ex ipsum ea commodo nostrud nulla velit voluptate.")
                  ],
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: const BottomCard());
  }
}
