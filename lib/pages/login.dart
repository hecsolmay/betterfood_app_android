import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/FondoImg.jpg'),
              fit: BoxFit.cover,
            )),
          ),
          Positioned(
            left: 90,
            top: 3,
            child: Image.asset(
              'assets/images/logo.png',
              width: 180,
              height: 180,
            ),
          ),
          Positioned(
            bottom: 40,
            right: 10,
            left: 10,
            child: TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontSize: 20),
                  backgroundColor: const Color.fromRGBO(186, 0, 0, 1),
                  fixedSize: const Size(200, 40)),
              onPressed: () {
                Navigator.pushNamed(context, '/register-form');
              },
              child: const Text('Registro'),
            ),
          ),
        ],
      ),
    );
  }
}
