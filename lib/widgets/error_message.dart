import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          SizedBox(height: 50),
          Icon(
            Icons.cloud_off,
            size: 200,
          ),
          Text(
            'Ocurrio un error al traer los datos',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Intentelo de nuevo',
            style: TextStyle(fontSize: 20, color: Colors.red),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class EmptyShoppingCart extends StatelessWidget {
  const EmptyShoppingCart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.remove_shopping_cart,
            size: 200,
          ),
          Text(
            'Aun no hay productos en el carrito',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
