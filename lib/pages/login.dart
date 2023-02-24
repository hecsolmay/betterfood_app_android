import 'package:betterfood_app_android/dtos/providers/categoryprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
   final categoryProvider= Provider.of<CategoryProvider>(context);

   categoryProvider.fetchCategory();
   
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
            left: MediaQuery.of(context).size.width * 0.3,
            top: MediaQuery.of(context).size.height * 0.03,
            child: Image.asset(
              'assets/images/logo.png',
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.width * 0.4,
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.1,
            right: 10,
            left: 10,
            child: TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontSize: 20),
                  backgroundColor: const Color.fromRGBO(186, 0, 0, 1),
                  fixedSize: const Size(200, 40)),
              onPressed: () {
                Navigator.pushNamed(context, '/loginmesero');
              },
              child: const Text('Registro'),
            ),
          ),
        ],
      ),
    );

  }
}
