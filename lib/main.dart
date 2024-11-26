import 'package:atmi_eccom/screens/shopping_cart_screen.dart';
import 'package:flutter/material.dart';
import 'screens/product_screen.dart';
import 'screens/offer_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        fontFamily: 'Roboto',
      ),
      initialRoute: '/offers',
      routes: {
        '/offers': (context) => const OfferScreen(),
        '/products': (context) => const ProductScreen(),
        '/cart': (context) => ShoppingCartScreen( cartItem: ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?,
      ),
      },
    );
  }
}
