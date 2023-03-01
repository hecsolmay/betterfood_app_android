import 'package:betterfood_app_android/dtos/providers/categoryprovider.dart';
import 'package:betterfood_app_android/dtos/providers/mesa_provider.dart';
import 'package:betterfood_app_android/dtos/providers/mesero_provider.dart';
import 'package:betterfood_app_android/dtos/providers/products_provider.dart';
import 'package:betterfood_app_android/pages/login_mesa.dart';
import 'package:betterfood_app_android/pages/login_mesero.dart';
import 'package:flutter/material.dart';
import 'package:betterfood_app_android/pages/screens.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => ProductsProvider()),
        ChangeNotifierProvider(create: (_) => WaiterProvider()),
        ChangeNotifierProvider(create: (_) => TableProvider()),
      ],  
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red)),
        initialRoute: '/login',
        routes: {
          '/login': (context) => const Login(),
          '/home': (context) => const Home(),
          '/loginmesero': (context) => const LoginMesero(),
          '/loginmesa': (context) => const LoginMesa(),
          '/categories': (context) => const Categories(),
          '/order': (context) => const Order(),
        },
      ),
    );
  }
}
