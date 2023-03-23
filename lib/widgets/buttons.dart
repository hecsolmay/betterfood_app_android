import 'package:betterfood_app_android/dtos/providers/register_provider.dart';
import 'package:betterfood_app_android/dtos/request/help_request.dart';
import 'package:betterfood_app_android/utils/custom_delegate.dart';
import 'package:betterfood_app_android/utils/shared_cache.dart';
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
            title: Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15, right: 10),
              child: Icon(
                Icons.help_outline_rounded,
                size: 100,
                color: Colors.blue.shade400,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  "Pedir Ayuda",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 15),
                Text(
                  "¿Deseas Pedir ayuda al mesero Pepito Perez?",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final newHelp = HelpRequest(
                          waiterId: '63f804a8757fa73689a81958',
                          idTable: '63f8df91757fa73689a81a98');

                      await request.postHelp(newHelp);

                      if (request.notificationSend) {
                        // ignore: use_build_context_synchronously
                        return Navigator.pop(context);
                      } else {
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                        // ignore: use_build_context_synchronously
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Error al solicitar ayuda'),
                            content: const Padding(
                              padding: EdgeInsets.only(
                                  top: 15, bottom: 15, right: 10),
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(90, 45),
                    ),
                    child: const Text("SI"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      minimumSize: const Size(90, 45),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text("No"),
                  ),
                ],
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

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15, right: 10),
              child: Icon(
                Icons.logout,
                size: 100,
                color: Colors.red.shade400,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  "Cerrar Sesion",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 15),
                Text(
                  "¿Estas seguro de cerra sesion despues no podras regresar a esta pantalla?",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      Provider.of<RegisterProvider>(context, listen: false)
                          .cleanData();
                      final sharedCache = SharedCache();
                      await sharedCache.clearCache();
                      Navigator.pop(context);
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/login',
                        (route) => false,
                      );
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
        print("Cerrando Sesion");
      },
      icon: const Icon(Icons.logout),
    );
  }
}
