import 'package:betterfood_app_android/dtos/providers/register_provider.dart';
import 'package:betterfood_app_android/dtos/request/help_request.dart';
import 'package:betterfood_app_android/utils/custom_delegate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HelpButton extends StatelessWidget {
  const HelpButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final request = Provider.of<RegisterProvider>(context);
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
                onPressed: () async {
                  final newHelp = HelpRequest(
                      waiterId: '63f804a8757fa73689a81958',
                      idTable: '63f8df91757fa73689a81a98');

                  await request.postHelp(newHelp);

                  if (request.notificationSend) {
                    return Navigator.pop(context);
                  } else {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Error al solicitar ayuda'),
                        content: const Padding(
                          padding:
                              EdgeInsets.only(top: 15, bottom: 15, right: 10),
                          child: Icon(
                            Icons.error,
                            size: 100,
                            color: Colors.red,
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Cerrar"),
                          )
                        ],
                      ),
                    );
                  }
                },
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
