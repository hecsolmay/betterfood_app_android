import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
class LoginMesa extends StatefulWidget {
  const LoginMesa({super.key});

  @override
  State<LoginMesa> createState() => _LoginMesaState();
}

class _LoginMesaState extends State<LoginMesa> {
  String qrValue = "Codigo qr";

  void scanQr()async {
    String? cameraScanResult = await scanner.scan();
    setState(() {
      qrValue = cameraScanResult!;
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
                        'Bienvenido a BetterFood - MESA',
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
                            qrValue = cameraScanResult!;
                          });
                          Navigator.pushNamed(context, '/home');
                        },
                        icon: const Icon(Icons.camera, color: Colors.black,),
                        iconSize: 50.0,
                      ),

                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(186, 0, 0, 1),
                            fixedSize: const Size(300, 40)),
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/home',
                            (route) => false,
                          );
                        },
                        child: const Text('Ingresar'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      
        
        
      )

    );
    
  }
}