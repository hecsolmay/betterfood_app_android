
import 'package:betterfood_app_android/dtos/response/productresponse.dart';
import 'package:betterfood_app_android/widgets/slider_item.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarruselImg extends StatelessWidget {
  final List<ProductResponseDto> products;
  const CarruselImg({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: products.map((e) => Card_Slider(UrlImage: e.imgUrl)).toList(),
      options: CarouselOptions(
        height: 220.0,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        viewportFraction: 0.8,
      ),
    );
  }
}
