import 'dart:convert';

import 'package:betterfood_app_android/dtos/providers/register_provider.dart';
import 'package:betterfood_app_android/dtos/response/qr_response.dart';
import 'package:betterfood_app_android/utils/shared_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class LoginMesero extends StatefulWidget {
  const LoginMesero({super.key});

  @override
  State<LoginMesero> createState() => _LoginMeseroState();
}

class _LoginMeseroState extends State<LoginMesero> {
  String qrResult = " ";
  final sharedCache = SharedCache();

  void scanQr() async {
    PermissionStatus cameraPermissionStatus = await Permission.camera.request();

    if (cameraPermissionStatus == PermissionStatus.denied ||
        cameraPermissionStatus == PermissionStatus.permanentlyDenied) {
      SystemNavigator.pop();
    }
    String? cameraScanResult = await scanner.scan();
    setState(() {
      qrResult = cameraScanResult ?? "{waiterId: " ", tableId: " "}";
    });

    final qrResponse = QrResponse.fromJson(jsonDecode(qrResult));

    final registerProvider =
        Provider.of<RegisterProvider>(context, listen: false);

    await registerProvider.getByIdWaiter(qrResponse.waiterId);
    await registerProvider.getByIdTable(qrResponse.tableId);
    if (registerProvider.found && registerProvider.foundTable) {
      registerProvider.table;
      await sharedCache.saveWaiterToCache(registerProvider.waiter);
      await sharedCache.saveTableToCache(registerProvider.table);
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    } else {
      await alertNotFound(context);
      // Reiniciar la cámara
      scanQr();
    }
  }

  @override
  void initState() {
    super.initState();
    scanQr();
  }

  @override
  Widget build(BuildContext context) {
    final waiterprovider = Provider.of<RegisterProvider>(
      context,
    );
    return Scaffold(
      body: Container(
        height: 800, // Set a fixed height for the container
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Fondo.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0.05 * MediaQuery.of(context).size.height,
              left: 0.3 * MediaQuery.of(context).size.width,
              child: Container(
                width: 0.4 * MediaQuery.of(context).size.width,
                height: 0.4 * MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/logo.png',
                    ),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(
                    top: 0.5 * MediaQuery.of(context).size.height),
                width: 0.9 * MediaQuery.of(context).size.width,
                height: 220,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      children: const [
                        Text(
                          'Bienvenido a BetterFood - MESERO',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Por favor escanee el qr con su id y el de la mesa para continuar',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> alertNotFound(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error en econtrar mesero'),
        content: Column(mainAxisSize: MainAxisSize.min, children: const [
          SizedBox(
            height: 20,
          ),
          Icon(
            Icons.cancel,
            size: 64,
            color: Colors.red,
          ),
          SizedBox(
            height: 20,
          )
        ]),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          )
        ],
      ),
    );
  }
}
