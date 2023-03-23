import 'package:betterfood_app_android/dtos/providers/categoryprovider.dart';
import 'package:betterfood_app_android/dtos/providers/customprovider.dart';
import 'package:betterfood_app_android/dtos/providers/order_provider.dart';
import 'package:betterfood_app_android/dtos/providers/products_provider.dart';
import 'package:betterfood_app_android/dtos/providers/register_provider.dart';
import 'package:betterfood_app_android/dtos/response/mesa_response.dart';
import 'package:betterfood_app_android/dtos/response/mesero_response.dart';
import 'package:betterfood_app_android/pages/login_mesa.dart';
import 'package:betterfood_app_android/pages/login_mesero.dart';
import 'package:betterfood_app_android/pages/order_success.dart';
import 'package:betterfood_app_android/pages/screens.dart';
import 'package:betterfood_app_android/utils/shared_cache.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedCache = SharedCache();

  final waiterCache = await sharedCache.getWaiterFromCache();
  final tableCache = await sharedCache.getTableFromCache();
  runApp(MyApp(
    table: tableCache,
    waiter: waiterCache,
  ));
}

class MyApp extends StatelessWidget {
  final WaiterResponseDto? waiter;
  final TableResponseDto? table;
  const MyApp({super.key, this.waiter, this.table});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => ProductsProvider()),
        ChangeNotifierProvider(create: (_) => RegisterProvider()),
        ChangeNotifierProvider(create: (_) => OrdersProvider()),
        // ChangeNotifierProvider(create: (_) => TableProvider()),
        ChangeNotifierProvider(create: (_) => CustomIngredentsProvider()),
      ],
      builder: (context, child) {
        String initialRoute = '/login';

        if (waiter != null && table != null) {
          initialRoute = '/home';
          Provider.of<RegisterProvider>(context).waiterFromCache(waiter);
          Provider.of<RegisterProvider>(context).tableFromCache(table);
        }
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Material App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color.fromRGBO(185, 0, 0, 0.826),
            ),
          ),
          initialRoute: initialRoute,
          routes: {
            '/login': (context) => const Login(),
            '/home': (context) => const Home(),
            '/order': (context) => const Order(),
            '/orderResponse': (context) => const OrderResponse(),
            '/loginmesero': (context) => const LoginMesero(),
            '/loginmesa': (context) => const LoginMesa(),
            // '/categories': (context) => const Categories(),
          },
        );
      },
      // child: MaterialApp(
      //   debugShowCheckedModeBanner: false,
      //   title: 'Material App',
      //   theme: ThemeData(
      //     colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red),
      //     appBarTheme: const AppBarTheme(
      //       backgroundColor: Color.fromRGBO(185, 0, 0, 0.826),
      //     ),
      //   ),
      //   initialRoute: initialRoute,
      //   routes: {
      //     '/login': (context) => const Login(),
      //     '/home': (context) => const Home(),
      //     '/order': (context) => const Order(),
      //     '/orderResponse': (context) => const OrderResponse(),
      //     '/loginmesero': (context) => const LoginMesero(),
      //     '/loginmesa': (context) => const LoginMesa(),
      //     // '/categories': (context) => const Categories(),
      //   },
      // ),
    );
  }
}
