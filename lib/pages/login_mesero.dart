import 'package:betterfood_app_android/dtos/providers/mesero_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class LoginMesero extends StatefulWidget {
  const LoginMesero({super.key});

  @override
  State<LoginMesero> createState() => _LoginMeseroState();
}

class _LoginMeseroState extends State<LoginMesero> {
  
  String qrMesero = " ";

  void scanQr()async {
    String? cameraScanResult = await scanner.scan();
    setState(() {
      qrMesero = cameraScanResult!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image:  DecorationImage(
                image: AssetImage('assets/images/Fondo.png'),
                fit: BoxFit.cover
              )
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
                    fit: BoxFit.fitWidth
                ),
              )
            )
          ),
          Container(
              margin: const EdgeInsets.only(top: 450),
              height: 300,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    children: [
                      const Text(
                        'Bienvenido a BetterFood - MESERO',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      // ignore: prefer_const_constructors
                      SizedBox(
                        height: 30,
                      ),
                     IconButton(
                        onPressed: () async {
                          String? cameraScanResult = await scanner.scan();
                          setState(() {
                            qrMesero = cameraScanResult!;
                          });
                         await Provider.of<WaiterProvider>(context, listen: false).getByIdWaiter(qrMesero);
                          
                          Navigator.pushNamed(context, '/loginmesa');
                        },
                        icon: const Icon(Icons.camera, color: Colors.black,),
                        iconSize: 50.0,
                      ),
                      const SizedBox(
                        height: 30,
                      ),

                      const Text(
                        'Oprima el icono para scanear su codigo QR',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        textAlign: TextAlign.center,
                        ),
                      
                     
                    ]
                  )
                )
              )
            )
        ],
      )
    );
  }
}