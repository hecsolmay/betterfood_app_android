import 'package:betterfood_app_android/dtos/providers/order_provider.dart';
import 'package:betterfood_app_android/dtos/request/order_request.dart';
import 'package:betterfood_app_android/widgets/error_message.dart';
import 'package:betterfood_app_android/widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                      ...ordersProvider.products.asMap().entries.map((e) {
                        int price = e.value.price;

                        total += price * e.value.quantity;
                        return OrderCard(
                          product: e.value,
                          index: e.key,
                        );
                      })
                    ],
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
                      onPressed: () {
                        final orderProducts = ordersProvider.products
                            .map(
                              (e) => ProductOrder(
                                  idProduct: e.product.id,
                                  extras: e.extras,
                                  remove: e.remove,
                                  quantity: e.quantity),
                            )
                            .toList();

                        for (var element in orderProducts) {
                          print('${element.idProduct}');
                          print('${element.extras}');
                          print('${element.remove}');
                          print('${element.quantity}');
                        }
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Padding(
                              padding: const EdgeInsets.only(
                                  top: 15, bottom: 15, right: 10),
                              child: Icon(
                                Icons.info_outline_rounded,
                                size: 100,
                                color: Colors.yellow.shade400,
                              ),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Text(
                                  "Enviar Orden",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 15),
                                Text(
                                  "¿Estas seguro de terminar tu orden?",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            actions: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      await ordersProvider
                                          .postOrder(orderProducts);

                                      if (ordersProvider.hasError) {
                                        print(
                                            "Ocurrio un error al mandar los datos");
                                      } else {
                                        // ignore: use_build_context_synchronously
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: const Text('Orden Creada'),
                                            content: const Padding(
                                              padding: EdgeInsets.only(
                                                  top: 15,
                                                  bottom: 15,
                                                  right: 10),
                                              child: Icon(
                                                Icons.check,
                                                size: 100,
                                                color: Colors.green,
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  ordersProvider.removeAll();
                                                  Navigator
                                                      .pushNamedAndRemoveUntil(
                                                    context,
                                                    '/orderResponse',
                                                    (route) => false,
                                                  );
                                                },
                                                child: const Text("Cerrar"),
                                              )
                                            ],
                                          ),
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      minimumSize: const Size(90, 45),
                                    ),
                                    child: const Text("SI"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () => Navigator.pop(context),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey,
                                      minimumSize: const Size(90, 45),
                                    ),
                                    child: const Text("No"),
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      },
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
