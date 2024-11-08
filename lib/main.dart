import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:techtruck_v11/views/all_orders.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:techtruck_v11/widgets/my_custom_scroller.dart';

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
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        // Locale('en', 'US'),
        Locale('es', 'MX'),
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Tahoma',
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scrollbarTheme: const ScrollbarThemeData().copyWith(
          thumbColor:
              WidgetStateProperty.all(const Color.fromARGB(255, 126, 126, 126)),
          thumbVisibility: WidgetStateProperty.all<bool>(true),
          trackVisibility: WidgetStateProperty.all<bool>(true),
          thickness: WidgetStateProperty.all<double>(12),
          radius: const Radius.circular(3),
        ),
      ),
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollerBehavior(),
      home: const AllOrders(),
    );
  }
}
