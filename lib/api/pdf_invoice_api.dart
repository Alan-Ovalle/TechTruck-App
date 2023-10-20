import 'dart:typed_data';
import 'package:techtruck_v11/model/datos_cliente.dart';
import 'package:techtruck_v11/model/orden_servicio.dart';
import 'package:techtruck_v11/model/datos_unidad.dart';
import 'package:techtruck_v11/utils.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class PdfInvoiceApi {
  static Future<Uint8List> generate(Map<String, dynamic> orderData) async {
    final pdf = Document();
    var texto1 = orderData["clienteNombre"];
    var texto2 = orderData["clienteContacto"];

    pdf.addPage(MultiPage(
      build: (context) => [
        // buildHeader(invoice),
        // SizedBox(height: 3 * PdfPageFormat.cm),
        // buildTitle(invoice),
        // buildInvoice(invoice),
        // Divider(),
        // buildTotal(invoice),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 1 * PdfPageFormat.cm),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildSupplierAddress(
                  texto1,
                  texto2,
                ),
                Container(
                  height: 50,
                  width: 50,
                  child: BarcodeWidget(
                    barcode: Barcode.qrCode(),
                    data: orderData["id"].toString(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 1 * PdfPageFormat.cm),
          ],
        )
      ],
      // footer: (context) => buildFooter(invoice),
    ));

    // return PdfApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
    return pdf.save();
  }

  static Widget buildHeader(OrdenServicio ordenLocal) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // buildSupplierAddress(invoice.supplier),
              Container(
                height: 50,
                width: 50,
                child: Text(ordenLocal.detallesOrden!.folio.toString()),
              ),
            ],
          ),
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildDatosCliente(ordenLocal.cliente!),
              buildDatosCliente(ordenLocal.cliente!),
              // buildDatosUnidad(ordenLocal.unidad!),
            ],
          ),
        ],
      );

  static Widget buildDatosCliente(DatosCliente cliente) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(cliente.nombre!, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(cliente.contacto!),
        ],
      );

  static Widget buildDatosUnidad(DatosUnidad unidad) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            unidad.numeroEconomico!,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(unidad.marca!),
          Text(unidad.modelo!),
          Text(unidad.motor!),
          Text(unidad.placas!),
          Text(unidad.kilometros!),
          Text(unidad.horasMotor!),
          Text(unidad.tipo!),
          Text(unidad.serieMotor!),
          Text(unidad.year!),
          Text(unidad.vin!),
        ],
      );

  static Widget buildSupplierAddress(
    String? text1,
    String? text2,
  ) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text1.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text(text2.toString()),
        ],
      );

  // static Widget buildTitle(Invoice invoice) => Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           'INVOICE',
  //           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  //         ),
  //         SizedBox(height: 0.8 * PdfPageFormat.cm),
  //         Text(invoice.info.description),
  //         SizedBox(height: 0.8 * PdfPageFormat.cm),
  //       ],
  //     );

  // static Widget buildInvoice(Invoice invoice) {
  //   final headers = [
  //     'Description',
  //     'Date',
  //     'Quantity',
  //     'Unit Price',
  //     'VAT',
  //     'Total'
  //   ];
  //   final data = invoice.items.map((item) {
  //     final total = item.unitPrice * item.quantity * (1 + item.vat);

  //     return [
  //       item.description,
  //       Utils.formatDate(item.date),
  //       '${item.quantity}',
  //       '\$ ${item.unitPrice}',
  //       '${item.vat} %',
  //       '\$ ${total.toStringAsFixed(2)}',
  //     ];
  //   }).toList();

  //   return Table.fromTextArray(
  //     headers: headers,
  //     data: data,
  //     border: null,
  //     headerStyle: TextStyle(fontWeight: FontWeight.bold),
  //     headerDecoration: BoxDecoration(color: PdfColors.grey300),
  //     cellHeight: 30,
  //     cellAlignments: {
  //       0: Alignment.centerLeft,
  //       1: Alignment.centerRight,
  //       2: Alignment.centerRight,
  //       3: Alignment.centerRight,
  //       4: Alignment.centerRight,
  //       5: Alignment.centerRight,
  //     },
  //   );
  // }

  // static Widget buildTotal(Invoice invoice) {
  //   final netTotal = invoice.items
  //       .map((item) => item.unitPrice * item.quantity)
  //       .reduce((item1, item2) => item1 + item2);
  //   final vatPercent = invoice.items.first.vat;
  //   final vat = netTotal * vatPercent;
  //   final total = netTotal + vat;

  //   return Container(
  //     alignment: Alignment.centerRight,
  //     child: Row(
  //       children: [
  //         Spacer(flex: 6),
  //         Expanded(
  //           flex: 4,
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               buildText(
  //                 title: 'Net total',
  //                 value: Utils.formatPrice(netTotal),
  //                 unite: true,
  //               ),
  //               buildText(
  //                 title: 'Vat ${vatPercent * 100} %',
  //                 value: Utils.formatPrice(vat),
  //                 unite: true,
  //               ),
  //               Divider(),
  //               buildText(
  //                 title: 'Total amount due',
  //                 titleStyle: TextStyle(
  //                   fontSize: 14,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //                 value: Utils.formatPrice(total),
  //                 unite: true,
  //               ),
  //               SizedBox(height: 2 * PdfPageFormat.mm),
  //               Container(height: 1, color: PdfColors.grey400),
  //               SizedBox(height: 0.5 * PdfPageFormat.mm),
  //               Container(height: 1, color: PdfColors.grey400),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // static Widget buildFooter(Invoice invoice) => Column(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         Divider(),
  //         SizedBox(height: 2 * PdfPageFormat.mm),
  //         buildSimpleText(title: 'Address', value: invoice.supplier.address),
  //         SizedBox(height: 1 * PdfPageFormat.mm),
  //         buildSimpleText(title: 'Paypal', value: invoice.supplier.paymentInfo),
  //       ],
  //     );

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}
