import 'dart:typed_data';
// import 'package:flutter/material.dart' as material;
import 'package:printing/printing.dart';
import 'package:techtruck_v11/model/datos_cliente.dart';
import 'package:techtruck_v11/model/orden_servicio.dart';
import 'package:techtruck_v11/model/datos_unidad.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:intl/intl.dart' as intl;

class PdfOrdenApi {
  static Future<Uint8List> generate(Map<String, dynamic> orderData) async {
    final pdf = Document();
    // final fondo = await imageFromAssetBundle('assets/images/ordenOpacidad.png');
    final logoHeader =
        await imageFromAssetBundle('assets/images/logoHeader.png');
    final inventario =
        await imageFromAssetBundle('assets/images/inventario.png');

    pdf.addPage(MultiPage(
      pageTheme: const PageTheme(
        pageFormat: PdfPageFormat.letter,
        margin: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      ),
      build: (context) => [
        buildHeader(orderData["id"].toString(), logoHeader),
        SizedBox(height: 2 * PdfPageFormat.point),
        buildClienteUnidad(orderData, context),
        SizedBox(height: 6 * PdfPageFormat.point),
        buildFechaTecnico(orderData, context),
        SizedBox(height: 6 * PdfPageFormat.point),
        buildComentario(orderData, context),
        SizedBox(height: 6 * PdfPageFormat.point),
        buildDiagnostico(orderData, context),
        SizedBox(height: 6 * PdfPageFormat.point),
        buildTrabajoCostos(orderData, context),
        SizedBox(height: 6 * PdfPageFormat.point),
        buildInventario(context, inventario),
        SizedBox(height: 6 * PdfPageFormat.point),
        buildFirmaRecibio(context),
      ],
    ));

    // return PdfApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
    return pdf.save();
  }

  static String _formatFolio(String? s) {
    if (s != null && s.length < 6) {
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

  static buildCellCenter(String title, bool isBold, Context context) {
    TextStyle style = const TextStyle(
      fontSize: 9,
      color: PdfColors.black,
    );
    TextStyle newStyle;
    if (title == "." || title == " " || title.isEmpty) {
      title = ".";
      newStyle = style.copyWith(color: PdfColors.white);
    } else if (isBold) {
      newStyle = style.copyWith(fontWeight: FontWeight.bold, fontSize: 9);
    } else {
      newStyle = style.copyWith(color: PdfColors.black);
    }
    return TableHelper.fromTextArray(
      context: context,
      headerAlignment: Alignment.center,
      headerStyle: newStyle,
      headerPadding: const EdgeInsets.fromLTRB(1, 1, 1, 1),
      cellHeight: 13,
      data: <List<String>>[
        <String>[title]
      ],
    );
  }

  static buildCellToTheLeft(String title, bool isBold, Context context) {
    TextStyle style = const TextStyle(
      fontSize: 9,
      color: PdfColors.black,
    );
    TextStyle newStyle;
    if (title == "." || title == " " || title.isEmpty) {
      title = ".";
      newStyle = style.copyWith(color: PdfColors.white);
    } else if (isBold) {
      newStyle = style.copyWith(fontWeight: FontWeight.bold, fontSize: 9);
    } else {
      newStyle = style.copyWith(color: PdfColors.black);
    }
    return TableHelper.fromTextArray(
      context: context,
      headerAlignment: Alignment.centerLeft,
      headerStyle: newStyle,
      headerDirection: TextDirection.ltr,
      headerPadding: const EdgeInsets.fromLTRB(4, 1, 1, 1),
      cellHeight: 13,
      data: <List<String>>[
        <String>[title]
      ],
    );
  }

  static buildCellToTheRight(String title, bool isBold, Context context) {
    TextStyle style = const TextStyle(
      fontSize: 9,
      color: PdfColors.black,
    );
    TextStyle newStyle;
    if (title == "." || title == " " || title.isEmpty) {
      title = ".";
      newStyle = style.copyWith(color: PdfColors.white);
    } else if (isBold) {
      newStyle = style.copyWith(fontWeight: FontWeight.bold, fontSize: 9);
    } else {
      newStyle = style.copyWith(color: PdfColors.black);
    }
    return TableHelper.fromTextArray(
      context: context,
      headerAlignment: Alignment.centerRight,
      headerStyle: newStyle,
      headerDirection: TextDirection.rtl,
      cellPadding: const EdgeInsets.fromLTRB(1, 1, 4, 1),
      cellHeight: 13,
      data: <List<String>>[
        <String>[title]
      ],
    );
  }

  static Widget buildDatosCliente(DatosCliente cliente, Context context) {
    return Expanded(
      flex: 11,
      child: Column(
        children: [
          buildCellCenter("Datos del Cliente", true, context),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(flex: 1, child: buildCellCenter("Nombre:", true, context)),
            Expanded(
                flex: 5,
                child: buildCellToTheLeft("${cliente.nombre}", false, context))
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(flex: 1, child: buildCellCenter(".", true, context)),
            Expanded(flex: 5, child: buildCellToTheLeft(".", false, context))
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(flex: 1, child: buildCellCenter(".", true, context)),
            Expanded(flex: 5, child: buildCellToTheLeft(".", false, context))
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
                flex: 1, child: buildCellCenter("Contacto:", true, context)),
            Expanded(
                flex: 5,
                child:
                    buildCellToTheLeft("${cliente.contacto}", false, context))
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(flex: 1, child: buildCellCenter(".", true, context)),
            Expanded(flex: 5, child: buildCellToTheLeft(".", false, context))
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(flex: 1, child: buildCellCenter(".", true, context)),
            Expanded(flex: 5, child: buildCellToTheLeft(".", false, context))
          ]),
        ],
      ),
    );
  }

  static Widget buildDatosUnidad(DatosUnidad unidad, Context context) {
    return Expanded(
        flex: 9,
        child: Column(
          children: [
            buildCellCenter("Datos de la Unidad", true, context),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Expanded(
                flex: 1,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 4,
                          child: buildCellCenter("No. Econ.", true, context)),
                      Expanded(
                          flex: 5,
                          child: buildCellToTheLeft(
                              "${unidad.numeroEconomico}", false, context))
                    ]),
              ),
              Expanded(
                flex: 1,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 2,
                          child: buildCellCenter("Kms.", true, context)),
                      Expanded(
                          flex: 5,
                          child: buildCellToTheLeft(
                              "${unidad.kilometros}", false, context))
                    ]),
              )
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Expanded(
                flex: 1,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 4,
                          child: buildCellCenter("Marca", true, context)),
                      Expanded(
                          flex: 5,
                          child: buildCellToTheLeft(
                              "${unidad.marca}", false, context))
                    ]),
              ),
              Expanded(
                flex: 1,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 2,
                          child: buildCellCenter("Horas", true, context)),
                      Expanded(
                          flex: 5,
                          child: buildCellToTheLeft(
                              "${unidad.horasMotor}", false, context))
                    ]),
              )
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Expanded(
                flex: 1,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 4,
                          child: buildCellCenter("Modelo", true, context)),
                      Expanded(
                          flex: 5,
                          child: buildCellToTheLeft(
                              "${unidad.modelo}", false, context))
                    ]),
              ),
              Expanded(
                flex: 1,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 2,
                          child: buildCellCenter("Tipo", true, context)),
                      Expanded(
                          flex: 5,
                          child: buildCellToTheLeft(
                              "${unidad.tipo}", false, context))
                    ]),
              )
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Expanded(
                flex: 1,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 4,
                          child: buildCellCenter("Motor", true, context)),
                      Expanded(
                          flex: 5,
                          child: buildCellToTheLeft(
                              "${unidad.motor}", false, context))
                    ]),
              ),
              Expanded(
                flex: 1,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 2,
                          child: buildCellCenter("Serie", true, context)),
                      Expanded(
                          flex: 5,
                          child: buildCellToTheLeft(
                              "${unidad.serieMotor}", false, context))
                    ]),
              )
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Expanded(
                flex: 1,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 4,
                          child: buildCellCenter("Placas", true, context)),
                      Expanded(
                          flex: 5,
                          child: buildCellToTheLeft(
                              "${unidad.placas}", false, context))
                    ]),
              ),
              Expanded(
                flex: 1,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 2,
                          child: buildCellCenter("Año", true, context)),
                      Expanded(
                          flex: 5,
                          child: buildCellToTheLeft(
                              "${unidad.year}", false, context))
                    ]),
              )
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Expanded(
                  flex: 4, child: buildCellCenter("V.I.N.", true, context)),
              Expanded(
                  flex: 14,
                  child: buildCellToTheLeft("${unidad.vin}", false, context))
            ]),
          ],
        ));
  }

  static buildClienteUnidad(Map<String, dynamic> orderData, Context context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildDatosCliente(
          DatosCliente(
            nombre: orderData["clienteNombre"],
            contacto: orderData["clienteContacto"],
            comentario: orderData["clienteComentario"],
          ),
          context,
        ),
        buildDatosUnidad(
            DatosUnidad(
              numeroEconomico: orderData["unidadNumEco"],
              marca: orderData["unidadMarca"],
              modelo: orderData["unidadModelo"],
              motor: orderData["unidadMotor"],
              placas: orderData["unidadPlacas"],
              kilometros: orderData["unidadKilometros"],
              horasMotor: orderData["unidadHorasMotor"],
              tipo: orderData["unidadTipo"],
              serieMotor: orderData["unidadSerie"],
              year: orderData["unidadYear"],
              vin: orderData["unidadVin"],
            ),
            context),
      ],
    );
  }

  static Widget buildDatosFechaTecnico(
      OrdenServicioInfo ordenServicio, Context context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
        width: 40,
        child: buildCellCenter("Fecha", true, context),
      ),
      Container(
        width: 65,
        child: buildCellCenter("${ordenServicio.fechaLlegada}", false, context),
      ),
      Container(
        width: 40,
        child: buildCellCenter("Salida", true, context),
      ),
      Container(
        width: 65,
        child: buildCellCenter("${ordenServicio.fechaSalida}", false, context),
      ),
      Container(
        width: 107,
        child: buildCellCenter("Tecnico Asignado", true, context),
      ),
      Container(
          width: 125,
          child: buildCellToTheLeft(
              "${ordenServicio.tecnicoAsignado}", false, context)),
      Container(
        width: 50,
        child: buildCellCenter("# Caso", true, context),
      ),
      Expanded(
        child: Container(
            child: buildCellToTheLeft(
                "${ordenServicio.numeroCaso}", false, context)),
      )
    ]);
  }

  static buildFechaTecnico(Map<String, dynamic> orderData, Context context) {
    return buildDatosFechaTecnico(
        OrdenServicioInfo(
          folio: orderData["id"].toString(),
          fechaLlegada: orderData["fechaLlegada"],
          fechaSalida: orderData["fechaSalida"],
          tecnicoAsignado: orderData["tecnicoAsignado"],
          numeroCaso: orderData["numeroCaso"],
          diagnostico: orderData["diagnostico"],
        ),
        context);
  }

  static Widget buildClienteComentario(DatosCliente cliente, Context context) {
    return Column(
      children: [
        buildCellToTheLeft("Comentarios del Cliente", true, context),
        buildCellToTheLeft("${cliente.comentario}", false, context),
        buildCellToTheLeft(".", false, context),
        buildCellToTheLeft(".", false, context),
      ],
    );
  }

  static buildComentario(Map<String, dynamic> orderData, Context context) {
    return Column(
      children: [
        buildClienteComentario(
            DatosCliente(
              nombre: null,
              contacto: null,
              comentario: orderData["clienteComentario"],
            ),
            context)
      ],
    );
  }

  static Widget buildClienteDiagnostico(
      OrdenServicioInfo ordenServicio, Context context) {
    return Column(
      children: [
        buildCellToTheLeft("Diagnostico", true, context),
        buildCellToTheLeft("${ordenServicio.diagnostico}", false, context),
        buildCellToTheLeft(".", false, context),
        buildCellToTheLeft(".", false, context),
      ],
    );
  }

  static buildDiagnostico(Map<String, dynamic> orderData, Context context) {
    return Column(
      children: [
        buildClienteDiagnostico(
            OrdenServicioInfo(
              folio: null,
              fechaLlegada: null,
              fechaSalida: null,
              tecnicoAsignado: null,
              numeroCaso: null,
              diagnostico: orderData["diagnostico"],
            ),
            context)
      ],
    );
  }

  static Widget buildTrabajoRealizado(
    List<String> trabajos,
    List<String> costos,
    Context context,
  ) {
    var listaTrabajos =
        trabajos.map((e) => buildCellToTheLeft(e, false, context)).toList();

    for (var i = listaTrabajos.length; i < 13; i++) {
      listaTrabajos.add(buildCellToTheLeft(".", false, context));
    }

    final formatCurrency = intl.NumberFormat.simpleCurrency();

    var listaCostos = costos.map(
      (e) {
        return Row(
          children: [
            Container(
              width: 110,
              child: buildCellToTheRight(".", false, context),
            ),
            Expanded(
              flex: 1,
              child: buildCellToTheLeft(
                  formatCurrency.format(int.parse(e)), false, context),
            )
          ],
        );
      },
    ).toList();

    for (var i = listaCostos.length; i < 13; i++) {
      listaCostos.add(
        Row(
          children: [
            Container(
              width: 110,
              child: buildCellToTheRight(".", false, context),
            ),
            Expanded(
              flex: 1,
              child: buildCellToTheLeft(".", false, context),
            )
          ],
        ),
      );
    }

    var totalCosto = costos.fold<int>(
      0,
      (previousValue, element) => previousValue + int.parse(element),
    );

    listaCostos.add(
      Row(
        children: [
          Container(
            width: 110,
            child: buildCellToTheRight("Total", true, context),
          ),
          Expanded(
            flex: 1,
            child: buildCellToTheLeft(
                formatCurrency.format(totalCosto), false, context),
            // child: buildCellToTheLeft("", false, context),
          )
        ],
      ),
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            flex: 20,
            child: Column(
              children: [
                buildCellToTheLeft(
                    "Trabajos Realizados / Refacciones", true, context),
                ...listaTrabajos,
              ],
            )),
        SizedBox(width: 15),
        Expanded(
            flex: 11,
            child: Column(
              children: [
                buildCellToTheRight("Costos", true, context),
                ...listaCostos,
              ],
            )),
      ],
    );
  }

  static buildTrabajoCostos(Map<String, dynamic> orderData, Context context) {
    List<String>? listaTrabajos = orderData["trabajoRealizado"]?.split("\n");
    List<String>? listaCostos = orderData["costo"]?.split("\n");

    if (listaTrabajos == null || listaTrabajos.isEmpty) {
      listaTrabajos = ["."];
    }

    if (listaCostos == null ||
        listaCostos.isEmpty ||
        listaCostos.firstWhere((element) => element == "") == "") {
      listaCostos = ["0"];
    }
    return buildTrabajoRealizado(listaTrabajos, listaCostos, context);
  }

  static buildInventario(Context context, ImageProvider image) {
    return Column(
      children: [
        buildCellToTheLeft("Inventario", true, context),
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
              TableHelper.fromTextArray(
                context: context,
                headerAlignment: Alignment.center,
                headerStyle: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
                headerCount: 1,
                headerDirection: TextDirection.ltr,
                headerPadding: const EdgeInsets.fromLTRB(4, 1, 1, 1),
                data: <List<String>>[
                  <String>[
                    "RECIBIO LA UNIDAD                                  (Firma, nombre y fecha)"
                  ]
                ],
              ),
              TableHelper.fromTextArray(
                context: context,
                headerStyle: const TextStyle(
                  fontSize: 9,
                  color: PdfColors.white,
                ),
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
                TableHelper.fromTextArray(
                  context: context,
                  headerAlignment: Alignment.center,
                  headerStyle: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                  headerCount: 1,
                  headerDirection: TextDirection.ltr,
                  headerPadding: const EdgeInsets.fromLTRB(4, 1, 1, 1),
                  data: <List<String>>[
                    <String>[
                      "CLIENTE                                                       (Firma, nombre y fecha)"
                    ]
                  ],
                ),
                TableHelper.fromTextArray(
                  context: context,
                  headerStyle: const TextStyle(
                    fontSize: 9,
                    color: PdfColors.white,
                  ),
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
