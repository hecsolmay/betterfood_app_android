import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Aqui va el login'),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/register-form');
            },
            child: const Text('Registrese'),
          )
        ],
      )),
    );
  }
}
