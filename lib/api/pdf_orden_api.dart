// ignore_for_file: unused_local_variable

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
    final inventario =
        await imageFromAssetBundle('assets/images/inventario.png');

    pdf.addPage(MultiPage(
      pageTheme: const PageTheme(
        pageFormat: PdfPageFormat.letter,
        // buildBackground: fondo == null
        //     ? null
        //     : (context) => FullPage(
        //         ignoreMargins: true,
        //         child: Image(
        //           fondo,
        //           fit: BoxFit.cover,
        //         )),
        margin: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      ),
      build: (context) => [
        buildHeader(orderData["id"].toString(), logoHeader),
        SizedBox(height: 4 * PdfPageFormat.point),
        buildClienteUnidad(orderData, context),
        SizedBox(height: 4 * PdfPageFormat.point),
        buildFechaTecnico(context),
        SizedBox(height: 6 * PdfPageFormat.point),
        buildClienteComentario(context),
        SizedBox(height: 10 * PdfPageFormat.point),
        buildDiagnostico(context),
        SizedBox(height: 10 * PdfPageFormat.point),
        buildTrabajoRealizado(context),
        SizedBox(height: 8 * PdfPageFormat.point),
        buildInventario(context, inventario),
        SizedBox(height: 6 * PdfPageFormat.point),
        buildFirmaRecibio(context),
      ],
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
                        style: const TextStyle(
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

  static buildCellTable(String title, Context context) {
    return TableHelper.fromTextArray(
      context: context,
      data: <List<String>>[
        <String>[title]
      ],
      cellPadding: const EdgeInsets.all(1),
    );
  }

  static buildCellToTheLeft(String title, Context context) {
    return TableHelper.fromTextArray(
      context: context,
      headerAlignment: Alignment.centerLeft,
      data: <List<String>>[
        <String>[title]
      ],
      cellPadding: const EdgeInsets.fromLTRB(4, 1, 1, 1),
    );
  }

  static buildCellToTheRight(String title, Context context) {
    return TableHelper.fromTextArray(
      context: context,
      headerAlignment: Alignment.centerRight,
      data: <List<String>>[
        <String>[title]
      ],
      cellPadding: const EdgeInsets.fromLTRB(1, 1, 4, 1),
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

  static buildClienteUnidad(Map<String, dynamic> orderData, Context context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 11,
          child: Column(
            children: [
              buildCellTable("Datos del Cliente", context),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Expanded(flex: 1, child: buildCellTable("Nombre:", context)),
                Expanded(flex: 5, child: buildCellToTheLeft(".", context))
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Expanded(flex: 1, child: buildCellTable(".", context)),
                Expanded(flex: 5, child: buildCellToTheLeft(".", context))
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Expanded(flex: 1, child: buildCellTable(".", context)),
                Expanded(flex: 5, child: buildCellToTheLeft(".", context))
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Expanded(flex: 1, child: buildCellTable(".", context)),
                Expanded(flex: 5, child: buildCellToTheLeft(".", context))
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Expanded(flex: 1, child: buildCellTable("Contacto:", context)),
                Expanded(flex: 5, child: buildCellToTheLeft(".", context))
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Expanded(flex: 1, child: buildCellTable(".", context)),
                Expanded(flex: 5, child: buildCellToTheLeft(".", context))
              ])
            ],
          ),
        ),
        Expanded(
            flex: 9,
            child: Column(
              children: [
                buildCellTable("Datos de la Unidad", context),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  flex: 4,
                                  child: buildCellTable("No. Econ.", context)),
                              Expanded(
                                  flex: 5,
                                  child: buildCellToTheLeft(".", context))
                            ]),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: buildCellTable("Kms.", context)),
                              Expanded(
                                  flex: 5,
                                  child: buildCellToTheLeft(".", context))
                            ]),
                      )
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  flex: 4,
                                  child: buildCellTable("Marca", context)),
                              Expanded(
                                  flex: 5,
                                  child: buildCellToTheLeft(".", context))
                            ]),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: buildCellTable("Horas", context)),
                              Expanded(
                                  flex: 5,
                                  child: buildCellToTheLeft(".", context))
                            ]),
                      )
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  flex: 4,
                                  child: buildCellTable("Modelo", context)),
                              Expanded(
                                  flex: 5,
                                  child: buildCellToTheLeft(".", context))
                            ]),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: buildCellTable("Tipo", context)),
                              Expanded(
                                  flex: 5,
                                  child: buildCellToTheLeft(".", context))
                            ]),
                      )
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  flex: 4,
                                  child: buildCellTable("Motor", context)),
                              Expanded(
                                  flex: 5,
                                  child: buildCellToTheLeft(".", context))
                            ]),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: buildCellTable("Serie", context)),
                              Expanded(
                                  flex: 5,
                                  child: buildCellToTheLeft(".", context))
                            ]),
                      )
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  flex: 4,
                                  child: buildCellTable("Placas", context)),
                              Expanded(
                                  flex: 5,
                                  child: buildCellToTheLeft(".", context))
                            ]),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: buildCellTable("Año", context)),
                              Expanded(
                                  flex: 5,
                                  child: buildCellToTheLeft(".", context))
                            ]),
                      )
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 4, child: buildCellTable("V.I.N.", context)),
                      Expanded(
                          flex: 14, child: buildCellToTheLeft(".", context))
                    ]),
              ],
            )),
      ],
    );
  }

  static buildFechaTecnico(Context context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
        width: 40,
        child: buildCellTable("Fecha", context),
      ),
      Container(
        width: 65,
        child: buildCellTable(".", context),
      ),
      Container(
        width: 40,
        child: buildCellTable("Salida", context),
      ),
      Container(
        width: 65,
        child: buildCellTable(".", context),
      ),
      Container(
        width: 110,
        child: buildCellTable("Tecnico Asignado", context),
      ),
      Container(
        width: 125,
        child: buildCellToTheLeft(".", context),
      ),
      Container(
        width: 50,
        child: buildCellTable("# Caso", context),
      ),
      Expanded(
        child: Container(
          width: 40,
          child: buildCellToTheLeft(".", context),
        ),
      )
    ]);
  }

  static buildClienteComentario(Context context) {
    return Column(
      children: [
        buildCellToTheLeft("Comentarios del Cliente", context),
        buildCellToTheLeft(".", context),
        buildCellToTheLeft(".", context),
        buildCellToTheLeft(".", context),
      ],
    );
  }

  static buildDiagnostico(Context context) {
    return Column(
      children: [
        buildCellToTheLeft("Diagnostico", context),
        buildCellToTheLeft(".", context),
        buildCellToTheLeft(".", context),
      ],
    );
  }

  static buildTrabajoRealizado(Context context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 20,
          child: Column(
            children: [
              buildCellToTheLeft("Trabajos Realizados/Refacciones", context),
              buildCellToTheLeft(".", context),
              buildCellToTheLeft(".", context),
              buildCellToTheLeft(".", context),
              buildCellToTheLeft(".", context),
              buildCellToTheLeft(".", context),
              buildCellToTheLeft(".", context),
              buildCellToTheLeft(".", context),
              buildCellToTheLeft(".", context),
              buildCellToTheLeft(".", context),
              buildCellToTheLeft(".", context),
              buildCellToTheLeft(".", context),
              buildCellToTheLeft(".", context),
              buildCellToTheLeft(".", context),
              buildCellToTheLeft(".", context),
              buildCellToTheLeft(".", context),
              buildCellToTheLeft(".", context),
            ],
          ),
        ),
        SizedBox(width: 15),
        Expanded(
            flex: 11,
            child: Column(
              children: [
                buildCellToTheRight("Costos", context),
                Row(children: [
                  Container(
                    width: 110,
                    child: buildCellToTheRight(".", context),
                  ),
                  Expanded(
                    flex: 1,
                    child: buildCellToTheLeft(".", context),
                  )
                ]),
                Row(children: [
                  Container(
                    width: 110,
                    child: buildCellToTheRight(".", context),
                  ),
                  Expanded(
                    flex: 1,
                    child: buildCellToTheLeft(".", context),
                  )
                ]),
                Row(children: [
                  Container(
                    width: 110,
                    child: buildCellToTheRight(".", context),
                  ),
                  Expanded(
                    flex: 1,
                    child: buildCellToTheLeft(".", context),
                  )
                ]),
                Row(children: [
                  Container(
                    width: 110,
                    child: buildCellToTheRight(".", context),
                  ),
                  Expanded(
                    flex: 1,
                    child: buildCellToTheLeft(".", context),
                  )
                ]),
                Row(children: [
                  Container(
                    width: 110,
                    child: buildCellToTheRight(".", context),
                  ),
                  Expanded(
                    flex: 1,
                    child: buildCellToTheLeft(".", context),
                  )
                ]),
                Row(children: [
                  Container(
                    width: 110,
                    child: buildCellToTheRight(".", context),
                  ),
                  Expanded(
                    flex: 1,
                    child: buildCellToTheLeft(".", context),
                  )
                ]),
                Row(children: [
                  Container(
                    width: 110,
                    child: buildCellToTheRight(".", context),
                  ),
                  Expanded(
                    flex: 1,
                    child: buildCellToTheLeft(".", context),
                  )
                ]),
                Row(children: [
                  Container(
                    width: 110,
                    child: buildCellToTheRight(".", context),
                  ),
                  Expanded(
                    flex: 1,
                    child: buildCellToTheLeft(".", context),
                  )
                ]),
                Row(children: [
                  Container(
                    width: 110,
                    child: buildCellToTheRight(".", context),
                  ),
                  Expanded(
                    flex: 1,
                    child: buildCellToTheLeft(".", context),
                  )
                ]),
                Row(children: [
                  Container(
                    width: 110,
                    child: buildCellToTheRight(".", context),
                  ),
                  Expanded(
                    flex: 1,
                    child: buildCellToTheLeft(".", context),
                  )
                ]),
                Row(children: [
                  Container(
                    width: 110,
                    child: buildCellToTheRight(".", context),
                  ),
                  Expanded(
                    flex: 1,
                    child: buildCellToTheLeft(".", context),
                  )
                ]),
                Row(children: [
                  Container(
                    width: 110,
                    child: buildCellToTheRight(".", context),
                  ),
                  Expanded(
                    flex: 1,
                    child: buildCellToTheLeft(".", context),
                  )
                ]),
                Row(children: [
                  Container(
                    width: 110,
                    child: buildCellToTheRight(".", context),
                  ),
                  Expanded(
                    flex: 1,
                    child: buildCellToTheLeft(".", context),
                  )
                ]),
                Row(children: [
                  Container(
                    width: 110,
                    child: buildCellToTheRight(".", context),
                  ),
                  Expanded(
                    flex: 1,
                    child: buildCellToTheLeft(".", context),
                  )
                ]),
                Row(children: [
                  Container(
                    width: 110,
                    child: buildCellToTheRight(".", context),
                  ),
                  Expanded(
                    flex: 1,
                    child: buildCellToTheLeft(".", context),
                  )
                ]),
                Row(children: [
                  Container(
                    width: 110,
                    child: buildCellToTheRight(".", context),
                  ),
                  Expanded(
                    flex: 1,
                    child: buildCellToTheLeft(".", context),
                  )
                ]),
              ],
            )),
      ],
    );
  }

  static buildInventario(Context context, ImageProvider image) {
    return Column(
      children: [
        buildCellToTheLeft("Inventario", context),
        SizedBox(height: 6 * PdfPageFormat.point),
        Container(
          width: double.infinity,
          height: 160,
          // color: PdfColors.red,
          child: Image(
            image,
            fit: BoxFit.fitHeight,
          ),
        )
      ],
    );
  }

  static buildFirmaRecibio(Context context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Column(
            children: [
              buildCellToTheLeft(
                  "RECIBIO LA UNIDAD     (Firma, nombre y fecha)", context),
              TableHelper.fromTextArray(
                context: context,
                cellHeight: 30,
                data: <List<String>>[
                  <String>["."]
                ],
                cellPadding: EdgeInsets.zero,
              ),
            ],
          ),
        ),
        SizedBox(width: 5),
        Expanded(
            flex: 1,
            child: Column(
              children: [
                buildCellToTheLeft(
                    "CLIENTE     (Firma, nombre y fecha)", context),
                TableHelper.fromTextArray(
                  context: context,
                  cellHeight: 30,
                  data: <List<String>>[
                    <String>["."]
                  ],
                  cellPadding: EdgeInsets.zero,
                ),
              ],
            )),
      ],
    );
  }
}
