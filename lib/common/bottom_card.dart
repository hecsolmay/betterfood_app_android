import 'package:betterfood_app_android/common/common.dart';
import 'package:flutter/material.dart';

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
        children: [
          Container(
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Row(
              children: [
                GestureDetector(
                  child: Icon(Icons.remove_circle_outline, color: Colors.red),
                  onTap: () => print("less click"),
                ),
                // const Icon(Icons.remove_circle_outline, color: Colors.red),
                const SizedBox(width: 10),
                BigText(text: "0"),
                const SizedBox(width: 10),
                GestureDetector(
                  child: Icon(Icons.add_circle, color: Colors.red),
                  onTap: () => print("plus click"),
                ),
                // const Icon(Icons.add_circle, color: Colors.red),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
