import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:techtruck_v11/views/all_orders.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:techtruck_v11/widgets/myCustomScroller.dart';

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
      locale: const Locale('es', 'MX'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Tahoma',
          visualDensity: VisualDensity.adaptivePlatformDensity),
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollerBehavior(),
      home: const AllOrders(),
    );
  }
}
