import 'package:flutter/material.dart';
import 'package:techtruck_v11/model/orden_servicio.dart';

class OrdenServicioDetalles extends StatelessWidget {
  final OrdenServicio ordenServicio;

  OrdenServicioDetalles(this.ordenServicio);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Orden de servicio ##")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Cliente: ${ordenServicio.cliente}"),
              Text("Unidad: ${ordenServicio.unidad}"),
              Text("Conductor: ${ordenServicio.conductor}"),
            ],
          ),
        ),
      ),
    );
  }
}
