import 'package:betterfood_app_android/common/common.dart';
import 'package:betterfood_app_android/widgets/order_card.dart';
import 'package:betterfood_app_android/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Order extends StatelessWidget {
  const Order({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.delete))
                ],
              ),
              expandedHeight: 50,
              pinned: true,
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(15, (index) => const OrderCard()),
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: GestureDetector(
            onTap: () {
              Navigator.popAndPushNamed(context, '/');
            },
            child: const BottomNavBar()));
  }
}
