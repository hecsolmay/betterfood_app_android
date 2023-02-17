import 'package:flutter/material.dart';
import 'package:betterfood_app_android/pages/screens.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final routes = {
    '/': (context) => const Home(),
    '/register': (context) => const Login(),
    '/register-form': (context) => const LoginForm(),
    '/categories': (context) => Categories(),
    '/order': (context) => const Order(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red)),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const Login(),
        '/home': (context) => const Home(),
        '/register-form': (context) => const LoginForm(),
        '/categories': (context) => Categories(),
        '/order': (context) => const Order(),
      },
    );
  }
}
