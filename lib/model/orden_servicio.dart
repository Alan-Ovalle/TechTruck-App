import 'package:flutter/material.dart';

class OrdenServicio {
  String cliente;
  String unidad;
  String conductor;

  OrdenServicio({
    required this.cliente,
    required this.unidad,
    required this.conductor,
  });
}

List<OrdenServicio> orderList = [
  OrdenServicio(
    cliente: "Raul",
    unidad: "69",
    conductor: "Jose",
  ),
  OrdenServicio(
    cliente: "Coprofesa",
    unidad: "13",
    conductor: "Jose",
  ),
  OrdenServicio(
    cliente: "Urbanissa",
    unidad: "59",
    conductor: "Jose",
  ),
  OrdenServicio(
    cliente: "PASA",
    unidad: "22",
    conductor: "Jose",
  ),
  OrdenServicio(
    cliente: "Volvo",
    unidad: "78 B",
    conductor: "Jose",
  ),
  OrdenServicio(
    cliente: "Siete",
    unidad: "15-A",
    conductor: "Jose",
  ),
  OrdenServicio(
    cliente: "Dynamo Fletes",
    unidad: "D-17",
    conductor: "Jose",
  ),
];
