import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:food_ordering_app/order_screen.dart';

void main() async {
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Ordering App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const OrderScreen(),
    );
  }
}
