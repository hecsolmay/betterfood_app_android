import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage(
                'assets/images/FondoImg.jpg',
              ),
              fit: BoxFit.cover,
            )),
          ),
          ListView(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            children: <Widget>[
              // const SizedBox(height: 20.0
              // ),
              Column(
                children: <Widget>[
                  Image.asset(
                    'assets/images/logo.png',
                    width: 180,
                    height: 180,
                  ),
                  const SizedBox(height: 230.0),
                ],
              ),

              //const SizedBox(height: 120.0),
              SizedBox(
                height: 300,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                  color: Colors.white,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'Bienvenido a BetterFood',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 45,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            labelText: 'Numero De Mesa:',
                            fillColor: Color.fromARGB(255, 255, 255, 255),
                            labelStyle: TextStyle(
                                color: Color.fromRGBO(255, 131, 17, 100)),
                          ),
                          obscureText: true,
                        ),
                      ),
                      const SizedBox(height: 60),
                      TextButton(
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            textStyle: const TextStyle(fontSize: 20),
                            backgroundColor: const Color.fromRGBO(186, 0, 0, 1),
                            fixedSize: const Size(280, 20),
                            alignment: Alignment.bottomCenter),
                        onPressed: () {
                          // Navigator.pushNamed(context, '/home');
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/home',
                            (route) => false,
                          );
                        },
                        child: const Text('Enviar'),
                      )
                    ],
                  ),
                ),
              ),
              // spacer
            ],
          ),
        ],
      ),
    );
  }
}
