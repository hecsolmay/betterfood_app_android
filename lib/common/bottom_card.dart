import 'package:betterfood_app_android/common/common.dart';
import 'package:flutter/material.dart';
import 'package:betterfood_app_android/widgets/products_card.dart';

class BottomCard extends StatelessWidget {
  const BottomCard({super.key});

  @override
  Widget build(BuildContext context) {
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
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Row(
              children: const [
                Buttons()
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding:
                  const EdgeInsets.only(top: 13, bottom: 13, left: 7, right: 7),
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(10)),
              child: BigText(
                text: "\$340.0  Agregar A la Orden",
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
