import 'package:betterfood_app_android/dtos/providers/order_provider.dart';
import 'package:betterfood_app_android/widgets/error_message.dart';
import 'package:betterfood_app_android/widgets/order_card.dart';
import 'package:betterfood_app_android/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// class Order extends StatelessWidget {
//   const Order({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: CustomScrollView(
//           slivers: [
//             SliverAppBar(
//               backgroundColor: const Color.fromARGB(185, 221, 0, 0),
//               title: Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   IconButton(onPressed: () {}, icon: const Icon(Icons.delete))
//                 ],
//               ),
//               expandedHeight: 50,
//               pinned: true,
//             ),
//             SliverToBoxAdapter(
//               child: Container(
//                 padding: const EdgeInsets.all(15),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: List.generate(15, (index) => const OrderCard()),
//                 ),
//               ),
//             )
//           ],
//         ),
//         bottomNavigationBar: GestureDetector(
//             onTap: () {
//               Navigator.popAndPushNamed(context, '/');
//             },
//             child: const BottomNavBar()));
//   }
// }

class Order extends StatelessWidget {
  const Order({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);
    int total = 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text("LISTA DE ORDENES"),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("¿Estas seguro de eliminar las ordenes?"),
                    content: const Padding(
                      padding:
                          EdgeInsets.only(top: 8.0, bottom: 8.0, right: 10),
                      child: Icon(
                        Icons.warning,
                        size: 100,
                        color: Colors.amber,
                      ),
                    ),
                    // icon:
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          ordersProvider.removeAll();
                          return Navigator.pop(context);
                        },
                        child: const Text("SI"),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("No"),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: ordersProvider.products.isEmpty
          ? const EmptyShoppingCart()
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ...ordersProvider.products.map((e) {
                      //   total += e.product.price * e.quantity;
                      //   return OrderCard(
                      //     product: e,
                      //   );
                      // })
                      ...ordersProvider.products.asMap().entries.map((e) {
                        total += e.value.product.price * e.value.quantity;
                        return OrderCard(
                          product: e.value,
                          index: e.key,
                        );
                      })
                    ],
                    // [...List.generate(15, (index) => const OrderCard())],
                  ),
                ),
              ),
            ),
      bottomNavigationBar: ordersProvider.products.isEmpty
          ? const SizedBox.shrink()
          : Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0, 3),
                    blurRadius: 6,
                  ),
                ],
              ),
              height: 100,
              child: Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, top: 5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 26),
                        ),
                        Text(
                          "\$$total",
                          style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 26),
                        )
                      ],
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          minimumSize: const Size(330, 50)),
                      child: const Text("Ordenar"),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
