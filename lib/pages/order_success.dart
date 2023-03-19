import 'package:betterfood_app_android/dtos/providers/order_provider.dart';
import 'package:betterfood_app_android/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderResponse extends StatelessWidget {
  const OrderResponse({super.key});

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrdersProvider>(context);
    final orderNumber = orderProvider.order?.orderNumber ?? '#001';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedido exitoso'),
        actions: const [HelpButton(), CloseSesionButton()],
      ),
      body: Center(
        child: SizedBox(
          height: 330,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.task_alt_rounded,
                  color: Colors.green.shade400, size: 100),
              const SizedBox(height: 20),
              const Text(
                'Su orden fue realizada exitosamente',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Numero de orden: ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    orderNumber,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              IconButton(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/home',
                  (route) => false,
                ),
                icon: const Icon(Icons.home),
                iconSize: 50,
                tooltip: 'Regresar al inicio',
              )
            ],
          ),
        ),
      ),
    );
  }
}
