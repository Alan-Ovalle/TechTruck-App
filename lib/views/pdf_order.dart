import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:techtruck_v11/api/pdf_orden_api.dart';
// import 'package:techtruck_v11/model/orden_servicio.dart';

class PdfOrder extends StatelessWidget {
  final Map<String, dynamic> orderToPrint;
  const PdfOrder({
    super.key,
    required this.orderToPrint,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PDF Order"),
      ),
      body: PdfPreview(
        canChangeOrientation: false,
        canChangePageFormat: false,
        pdfFileName:
            "Orden_de_trabajo_${orderToPrint["id"].toString().padLeft(6, '0')}_${orderToPrint["clienteNombre"]}.pdf",
        maxPageWidth: 700,
        build: (format) => PdfOrdenApi.generate(orderToPrint),
      ),
    );
  }
}
