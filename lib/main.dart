import 'package:betterfood_app_android/dtos/providers/categoryprovider.dart';
import 'package:flutter/material.dart';
import 'package:betterfood_app_android/pages/screens.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
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

