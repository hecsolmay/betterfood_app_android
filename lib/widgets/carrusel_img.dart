import 'package:betterfood_app_android/widgets/slider_item.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarruselImg extends StatelessWidget {
  const CarruselImg({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: const [
        //1st Image of Slider
        Card_Slider(
            UrlImage:
                "https://cdn.pixabay.com/photo/2016/03/05/23/02/barbecue-1239434_960_720.jpg"),
        Card_Slider(
            UrlImage:
                "https://cdn.pixabay.com/photo/2016/03/05/23/02/barbecue-1239434_960_720.jpg"),
        Card_Slider(
            UrlImage:
                "https://cdn.pixabay.com/photo/2016/02/05/15/34/pasta-1181189_960_720.jpg"),
        Card_Slider(
            UrlImage:
                "https://cdn.pixabay.com/photo/2016/10/22/20/34/wines-1761613_960_720.jpg"),
      ],

      //Slider Container properties
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
