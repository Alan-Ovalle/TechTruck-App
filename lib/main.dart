import 'package:flutter/material.dart';
import 'package:techtruck_v11/views/all_orders.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future main() async {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TechTruck App',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Hamlin',
          visualDensity: VisualDensity.adaptivePlatformDensity),
      debugShowCheckedModeBanner: false,
      home: const AllOrders(),
    );
  }
}
