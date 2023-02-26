import 'package:betterfood_app_android/dtos/providers/mesa_provider.dart';
import 'package:betterfood_app_android/dtos/providers/mesero_provider.dart';
import 'package:betterfood_app_android/dtos/response/mesero_response.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscan/qrscan.dart' as scanner;
class LoginMesa extends StatefulWidget {
  const LoginMesa({super.key});

  @override
  State<LoginMesa> createState() => _LoginMesaState();
}

class _LoginMesaState extends State<LoginMesa> {


  String qrMesa = " ";
  
  WaiterResponseDto? _waiter;
  @override
  void initState() {
    super.initState();
    // Obtener la instancia del provider en el initState
    _waiter = Provider.of<WaiterProvider>(context, listen: false).waiter;
  }

  void scanQr() async {
    String? cameraScanResult = await scanner.scan();
    setState(() {
      qrMesa = cameraScanResult!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Fondo.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.10,
            left: MediaQuery.of(context).size.width * 0.30,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.40,
              height: MediaQuery.of(context).size.width * 0.40,
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
          Container(
            margin: const EdgeInsets.only(top: 450),
            height: 300,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  children: [
                    const Text(
                      'Bienvenido a BetterFood',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    if (_waiter != null)
                      Text(
                        'Mesa atendida por: ${_waiter?.name} ${_waiter?.lastName}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    const SizedBox(height: 25),
                    IconButton(
                      onPressed: () async {
                        String? cameraScanResult = await scanner.scan();
                        setState(() {
                          qrMesa = cameraScanResult!;
                        });
                        await Provider.of<TableProvider>(context, listen: false).getByIdTable(qrMesa);
                        Navigator.pushNamed(context, '/home');
                      },
                      icon: const Icon(
                        Icons.camera,
                        color: Colors.black,
                      ),
                      iconSize: 50.0,
                    ),
                    const SizedBox(
                        height: 25,
                      ),

                      const Text(
                        'Oprima el icono para scanear el QR de la mesa',
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
        ],
      ),
    );
  }
}