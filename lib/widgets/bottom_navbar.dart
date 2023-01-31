import 'package:betterfood_app_android/common/common.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        color: Color.fromARGB(98, 211, 211, 211),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("0 Productos"),
              BigText(text: "\$0.00", size: 25),
            ],
          ),
          Container(
            padding:
                const EdgeInsets.only(top: 13, bottom: 13, left: 30, right: 30),
            child: BigText(
              text: "Ver Orden",
              color: Colors.white,
              size: 13,
            ),
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(10)),
          ),
        ],
      ),
    );
  }
}
