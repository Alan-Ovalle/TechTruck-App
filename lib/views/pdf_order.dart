import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:techtruck_v11/api/pdf_orden_api.dart';
// import 'package:techtruck_v11/model/orden_servicio.dart';

class PdfOrder extends StatelessWidget {
  final Map<String, dynamic> orderToPrint;
  const PdfOrder({
    Key? key,
    required this.orderToPrint,
  }) : super(key: key);

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
            // "${orderToPrint["id"]}_${orderToPrint["clienteNombre"]}.pdf",
            "Orden xxx1.pdf",
        maxPageWidth: 700,
        build: (format) => PdfOrdenApi.generate(orderToPrint),
      ),
    );
  }
}
