import 'package:betterfood_app_android/utils/custom_delegate.dart';
import 'package:flutter/material.dart';

class HelpButton extends StatelessWidget {
  const HelpButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("¿Deseas Pedir ayuda al mesero Pepito Perez?"),
            content: const Padding(
              padding: EdgeInsets.only(top: 15, bottom: 15, right: 10),
              child: Icon(
                Icons.help,
                size: 100,
                color: Colors.amber,
              ),
            ),
            // icon:
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: const Text("SI"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                onPressed: () => Navigator.pop(context),
                child: const Text("No"),
              ),
            ],
          ),
        );
      },
      icon: const Icon(Icons.help),
    );
  }
}

class SearchButton extends StatelessWidget {
  const SearchButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showSearch(
          context: context,
          delegate: CustomDelegate(),
        );
      },
      icon: const Icon(Icons.search),
    );
  }
}

class ShoppingCartButton extends StatelessWidget {
  const ShoppingCartButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.pushNamed(context, '/order'),
      child: const Icon(Icons.shopping_cart),
    );
  }
}
