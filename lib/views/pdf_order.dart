import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:printing/printing.dart';
import 'package:techtruck_v11/api/pdf_invoice_api.dart';
import 'package:techtruck_v11/model/invoice.dart';
import 'package:techtruck_v11/api/pdf_api.dart';

class PdfOrder extends StatelessWidget {
  final Invoice invoice;
  const PdfOrder({Key? key, required this.invoice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PDF Order"),
      ),
      body: PdfPreview(
        build: (format) => PdfInvoiceApi.generate(invoice),
      ),
    );
  }
}
