import 'package:flutter/material.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.search_off,
            size: 300,
          ),
          const Text(
            'Producto no encontrado',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Intente una busqueda diferente',
            style: TextStyle(fontSize: 20, color: Colors.red),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Volver al inicio'),
          ),
        ],
      ),
    );
  }
}
