import 'package:flutter/material.dart';
import 'package:techtruck_v11/views/new_order.dart';
import 'package:techtruck_v11/views/all_orders.dart';

class Inicio extends StatelessWidget {
  const Inicio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("INICIO"),
        centerTitle: true,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NewOrder()),
                );
              },
              child: const Text(
                'Crear orden',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AllOrders()),
                );
              },
              child: const Text(
                'Lista de ordenes',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
