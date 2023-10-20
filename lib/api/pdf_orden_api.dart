import 'dart:typed_data';
import 'package:flutter/material.dart' as material;
import 'package:printing/printing.dart';
import 'package:techtruck_v11/model/datos_cliente.dart';
import 'package:techtruck_v11/model/orden_servicio.dart';
import 'package:techtruck_v11/model/datos_unidad.dart';
import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class PdfOrdenApi {
  static Future<Uint8List> generate(Map<String, dynamic> orderData) async {
    final pdf = Document();
    final fondo = await imageFromAssetBundle('assets/images/ordenOpacidad.png');
    final logoHeader =
        await imageFromAssetBundle('assets/images/logoHeader.png');

    pdf.addPage(MultiPage(
      pageTheme: PageTheme(
        pageFormat: PdfPageFormat.letter,
        buildBackground: fondo == null
            ? null
            : (context) => FullPage(
                ignoreMargins: true,
                child: Image(
                  fondo,
                  fit: BoxFit.cover,
                )),
        margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      ),
      // margin: const EdgeInsets.all(15),
      build: (context) => [
        buildHeader(orderData["id"].toString(), logoHeader),
        SizedBox(height: 4 * PdfPageFormat.point),
        // Container(width: double.infinity, height: 10, color: PdfColors.red)
        buildCienteUnidad(orderData, context),

        // buildTitle(invoice),
        // buildInvoice(invoice),
        // Divider(),
        // buildTotal(invoice),
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     SizedBox(height: 1 * PdfPageFormat.cm),
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         buildExampleText(
        //           orderData["clienteNombre"],
        //           orderData["clienteContacto"],
        //         ),
        //         buildExampleText(
        //           orderData["id"].toString(),
        //           orderData["clienteComentarios"],
        //         ),
        //       ],
        //     ),
        //     SizedBox(height: 1 * PdfPageFormat.cm),
        //   ],
        // )
      ],
      // footer: (context) => buildFooter(invoice),
    ));

    // return PdfApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
    return pdf.save();
  }

  static String _formatFolio(String? s) {
    if (s != null && s.length < 4) {
      return s.padLeft(6, '0');
    } else {
      return s!;
    }
  }

  static Widget buildHeader(String? folioId, ImageProvider image) {
    return Container(
      height: 65,
      // color: PdfColors.yellow,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              children: [
                SizedBox(height: 3 * PdfPageFormat.point),
                Image(
                  image,
                  fit: BoxFit.fitWidth,
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(children: [
              Text(
                "Nicolás Javier Ovalle Mendoza",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "R.F.C. OAMN701206CX6",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 8,
                ),
              ),
              Text(
                "C.U.R.P. OAMN701206HCHVNC07",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 8,
                ),
              ),
              Text(
                "C. REAL DE JERONIMO N° 8975 | C.P. 32543",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 8,
                ),
              ),
              Text(
                "FRACC. REAL DEL SOL | CD. JUAREZ, CHIH.",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 8,
                ),
              ),
              SizedBox(height: 5 * PdfPageFormat.point),
              Text(
                "ORDEN DE SERVICIO DE TALLER",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]),
          ),
          Expanded(
              child: Stack(children: [
            Positioned(
                right: 25,
                bottom: 12,
                child: Container(
                  // color: PdfColors.grey,
                  width: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // mainAxisSize: MainAxisSize.max,
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("FOLIO ",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          )),
                      Text(
                        _formatFolio(folioId!),
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 18,
                          color: PdfColors.red,
                        ),
                      ),
                    ],
                  ),
                ))
          ])),
        ],
      ),
    );
  }

  static buildTableTitle(String title, Context context) {
    return TableHelper.fromTextArray(
      context: context,
      data: <List<String>>[
        <String>[title]
      ],
      cellPadding: EdgeInsets.all(2),
    );
  }

  static buildCienteUnidad(Map<String, dynamic> orderData, Context context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 11,
          child: buildTableTitle("Datos del Cliente", context),
        ),
        Expanded(
          flex: 9,
          child: buildTableTitle("Datos de la Unidad", context),
        ),
      ],
    );
  }

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

  static Widget buildExampleText(String? text1, String? text2) {
    text1 ??= 'Texto';
    text2 ??= 'Comentario';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text1.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 1 * PdfPageFormat.mm),
        Text(text2.toString()),
      ],
    );
  }

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
      crossAxisAlignment: CrossAxisAlignment.end,
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
