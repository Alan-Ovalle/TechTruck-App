// ignore_for_file: unused_import, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:techtruck_v11/widgets/db_helper.dart';
import 'package:techtruck_v11/widgets/formulario_orden.dart';
import 'package:techtruck_v11/widgets/helper_widgets.dart';
// import 'package:techtruck_v11/design/palette.dart';

class OrderDetails extends StatefulWidget {
  final Map<String, dynamic> singleData;
  const OrderDetails({
    super.key,
    required this.singleData,
  });

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  bool thisOrderExist = false;

  Widget checkDataExist(int? id) {
    if (id == null) {
      thisOrderExist = false;
      return const Text("Nueva Orden");
    } else {
      thisOrderExist = true;
      return const Text("Detalles de Orden");
    }
  }

  String formatFolio(String? n) {
    if (n != null && n.length < 4) {
      return n.padLeft(6, '0');
    } else {
      return n!;
    }
  }

  Widget checkFolioExist() {
    if (thisOrderExist) {
      return RichText(
        text: TextSpan(
          children: [
            const TextSpan(
              text: "Folio: ",
              style: TextStyle(
                // fontSize: 22,
                // fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            TextSpan(
              text: formatFolio(widget.singleData["id"].toString()),
              style: TextStyle(
                // fontSize: 22,
                // fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: checkDataExist(widget.singleData["id"]),
        // backgroundColor: Colors.grey[800],
        actions: [
          checkFolioExist(),
          addHorizontalSpace(16),
        ],
      ),
      body: FormularioOrden(
        dataLocal: widget.singleData,
      ),
    );
  }
}
