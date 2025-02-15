// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:techtruck_v11/views/all_orders.dart';
import 'package:techtruck_v11/widgets/db_helper.dart';
import 'package:techtruck_v11/widgets/helper_widgets.dart';
// import 'package:techtruck_v11/design/palette.dart';

class NewOrder extends StatefulWidget {
  final Map<String, dynamic> singleData;
  final int? idOrder;
  final bool? isReadOnly;

  const NewOrder({
    super.key,
    required this.singleData,
    required this.idOrder,
    required this.isReadOnly,
  });

  @override
  State<NewOrder> createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
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
      return Row(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 8, right: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: "Folio: ",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: formatFolio(widget.singleData["id"].toString()),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
          addHorizontalSpace(15),
          Container(
            constraints: BoxConstraints(
              minWidth: 170,
            ),
            padding: const EdgeInsets.only(left: 8, right: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                width: 2,
                color: Colors.white,
              ),
              color: colorEstatus(widget.singleData["estatus"]),
            ),
            child: Text(
              widget.singleData["estatus"],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: checkDataExist(widget.idOrder),
        backgroundColor: Colors.blue.shade900,
        foregroundColor: Colors.white,
        shadowColor: Colors.black,
        elevation: 2,
        actions: [
          checkFolioExist(),
          addHorizontalSpace(16),
        ],
      ),
      body: TemporalFomulario(
        dataLocal: widget.singleData,
        id: widget.idOrder,
        isReadOnly: widget.isReadOnly,
      ),
    );
  }
}

class TemporalFomulario extends StatefulWidget {
  final Map<String, dynamic> dataLocal;
  final int? id;
  final bool? isReadOnly;
  const TemporalFomulario({
    super.key,
    required this.dataLocal,
    required this.id,
    required this.isReadOnly,
  });
  @override
  TemporalFomularioState createState() {
    return TemporalFomularioState();
  }
}

class TemporalFomularioState extends State<TemporalFomulario> {
  final _formularioKey = GlobalKey<FormState>();
  final estatus = "Pendiente";
  final clienteNombreController = TextEditingController();
  final clienteContactoController = TextEditingController();
  final unidadNumEco = TextEditingController();
  final unidadKilometros = TextEditingController();
  final unidadMarca = TextEditingController();
  final unidadModelo = TextEditingController();
  final unidadHorasMotor = TextEditingController();
  final unidadTipo = TextEditingController();
  final unidadMotor = TextEditingController();
  final unidadSerie = TextEditingController();
  final unidadPlacas = TextEditingController();
  final unidadYear = TextEditingController();
  final unidadVin = TextEditingController();
  final fechaLlegada = TextEditingController();
  final fechaSalida = TextEditingController();
  final tecnicoAsignado = TextEditingController();
  final numeroCaso = TextEditingController();
  final clienteComentario = TextEditingController();
  final diagnosticoController = TextEditingController();
  final trabajoRealizado = TextEditingController();
  final costosController = TextEditingController();

  @override
  dispose() {
    clienteNombreController.dispose();
    clienteContactoController.dispose();
    unidadNumEco.dispose();
    unidadKilometros.dispose();
    unidadMarca.dispose();
    unidadModelo.dispose();
    unidadHorasMotor.dispose();
    unidadTipo.dispose();
    unidadMotor.dispose();
    unidadSerie.dispose();
    unidadPlacas.dispose();
    unidadYear.dispose();
    unidadVin.dispose();
    fechaLlegada.dispose();
    fechaSalida.dispose();
    tecnicoAsignado.dispose();
    numeroCaso.dispose();
    clienteComentario.dispose();
    diagnosticoController.dispose();
    trabajoRealizado.dispose();
    costosController.dispose();

    super.dispose();
  }

  void fillData() {
    clienteNombreController.text = widget.dataLocal["clienteNombre"];
    clienteContactoController.text = widget.dataLocal["clienteContacto"];
    unidadNumEco.text = widget.dataLocal["unidadNumEco"];
    unidadKilometros.text = widget.dataLocal["unidadKilometros"];
    unidadMarca.text = widget.dataLocal["unidadMarca"];
    unidadModelo.text = widget.dataLocal["unidadModelo"];
    unidadHorasMotor.text = widget.dataLocal["unidadHorasMotor"];
    unidadTipo.text = widget.dataLocal["unidadTipo"];
    unidadMotor.text = widget.dataLocal["unidadMotor"];
    unidadSerie.text = widget.dataLocal["unidadSerie"];
    unidadPlacas.text = widget.dataLocal["unidadPlacas"];
    unidadYear.text = widget.dataLocal["unidadYear"];
    unidadVin.text = widget.dataLocal["unidadVin"];
    fechaLlegada.text = widget.dataLocal["fechaLlegada"];
    fechaSalida.text = widget.dataLocal["fechaSalida"];
    tecnicoAsignado.text = widget.dataLocal["tecnicoAsignado"];
    numeroCaso.text = widget.dataLocal["numeroCaso"];
    clienteComentario.text = widget.dataLocal["clienteComentario"];
    diagnosticoController.text = widget.dataLocal["diagnostico"];
    trabajoRealizado.text = widget.dataLocal["trabajoRealizado"];
    costosController.text = widget.dataLocal["costo"];
  }

  @override
  void initState() {
    super.initState();
    _checkData();
  }

  void _checkData() {
    if (widget.id != null) {
      fillData();
    } else {
      cleanControllers();
    }
  }

  void cleanControllers() {
    clienteNombreController.clear();
    clienteContactoController.clear();
    unidadNumEco.clear();
    unidadKilometros.clear();
    unidadMarca.clear();
    unidadModelo.clear();
    unidadHorasMotor.clear();
    unidadTipo.clear();
    unidadMotor.clear();
    unidadSerie.clear();
    unidadPlacas.clear();
    unidadYear.clear();
    unidadVin.clear();
    fechaLlegada.clear();
    fechaSalida.clear();
    tecnicoAsignado.clear();
    numeroCaso.clear();
    clienteComentario.clear();
    diagnosticoController.clear();
    trabajoRealizado.clear();
    costosController.clear();
  }

  Future<void> _addData() async {
    bool areAllFieldsFilled = clienteNombreController.text.isNotEmpty ||
        clienteContactoController.text.isNotEmpty ||
        unidadNumEco.text.isNotEmpty ||
        unidadKilometros.text.isNotEmpty ||
        unidadMarca.text.isNotEmpty ||
        unidadModelo.text.isNotEmpty ||
        unidadHorasMotor.text.isNotEmpty ||
        unidadTipo.text.isNotEmpty ||
        unidadMotor.text.isNotEmpty ||
        unidadSerie.text.isNotEmpty ||
        unidadPlacas.text.isNotEmpty ||
        unidadYear.text.isNotEmpty ||
        unidadVin.text.isNotEmpty ||
        fechaLlegada.text.isNotEmpty ||
        fechaSalida.text.isNotEmpty ||
        tecnicoAsignado.text.isNotEmpty ||
        numeroCaso.text.isNotEmpty ||
        clienteComentario.text.isNotEmpty ||
        diagnosticoController.text.isNotEmpty ||
        trabajoRealizado.text.isNotEmpty ||
        costosController.text.isNotEmpty;
    if (!areAllFieldsFilled) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text("Favor de llenar todos los campos"),
        ),
      );
      return;
    } else {
      await SQLHelper.createData(
        estatus,
        clienteNombreController.text,
        clienteContactoController.text,
        unidadNumEco.text,
        unidadKilometros.text,
        unidadMarca.text,
        unidadModelo.text,
        unidadHorasMotor.text,
        unidadTipo.text,
        unidadMotor.text,
        unidadSerie.text,
        unidadPlacas.text,
        unidadYear.text,
        unidadVin.text,
        fechaLlegada.text,
        fechaSalida.text,
        tecnicoAsignado.text,
        numeroCaso.text,
        clienteComentario.text,
        diagnosticoController.text,
        trabajoRealizado.text,
        costosController.text,
      );
    }
    cleanControllers();
    Navigator.pop(context);
  }

  Future<void> _updateData(int id) async {
    await SQLHelper.updateData(
      id,
      estatus,
      clienteNombreController.text,
      clienteContactoController.text,
      unidadNumEco.text,
      unidadKilometros.text,
      unidadMarca.text,
      unidadModelo.text,
      unidadHorasMotor.text,
      unidadTipo.text,
      unidadMotor.text,
      unidadSerie.text,
      unidadPlacas.text,
      unidadYear.text,
      unidadVin.text,
      fechaLlegada.text,
      fechaSalida.text,
      tecnicoAsignado.text,
      numeroCaso.text,
      clienteComentario.text,
      diagnosticoController.text,
      trabajoRealizado.text,
      costosController.text,
    );
    cleanControllers();
    Navigator.pop(context);
  }

  final ScrollController scrollControllerTwo = ScrollController();

  @override
  Widget build(BuildContext context) {
    debugPrint(
        "ESTAMOS EN NEW ORDER ############################################################");
    return Expanded(
      child: Scrollbar(
        controller: scrollControllerTwo,
        thumbVisibility: true,
        trackVisibility: true,
        thickness: 12,
        radius: const Radius.circular(2),
        child: ListView(
          controller: scrollControllerTwo,
          padding: const EdgeInsets.only(right: 15),
          // shrinkWrap: true,
          // physics: const ClampingScrollPhysics(),
          children: [
            Form(
              key: _formularioKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: StaggeredGrid.count(
                  crossAxisCount: 12,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 8,
                  children: [
                    StaggeredGridTile.count(
                      crossAxisCellCount: 6,
                      mainAxisCellCount: .5,
                      child: tituloTile("Datos del cliente"),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 6,
                      mainAxisCellCount: .5,
                      child: tituloTile("Datos de la unidad"),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 6,
                      mainAxisCellCount: 1,
                      child: expandMultiLineFieldTile(
                        widget.isReadOnly,
                        3,
                        3,
                        34,
                        34,
                        {
                          clienteNombreController: {"Nombre del cliente": 3},
                        },
                      ),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 3,
                      mainAxisCellCount: .5,
                      child: expandFieldTile(
                        {
                          unidadNumEco: {"No. Economico": 1},
                        },
                        widget.isReadOnly,
                      ),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 3,
                      mainAxisCellCount: .5,
                      child: expandFieldTile(
                        {
                          unidadKilometros: {"Kilometros": 1},
                        },
                        widget.isReadOnly,
                      ),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 3,
                      mainAxisCellCount: .5,
                      child: expandFieldTile(
                        {
                          unidadMarca: {"Marca": 1},
                        },
                        widget.isReadOnly,
                      ),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 3,
                      mainAxisCellCount: .5,
                      child: expandFieldTile(
                        {
                          unidadHorasMotor: {"Horas del motor": 1},
                        },
                        widget.isReadOnly,
                      ),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 6,
                      mainAxisCellCount: 1,
                      child: expandMultiLineFieldTile(
                        widget.isReadOnly,
                        3,
                        3,
                        34,
                        34,
                        {
                          clienteContactoController: {
                            "Contacto del cliente": 3
                          },
                        },
                      ),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 3,
                      mainAxisCellCount: .5,
                      child: expandFieldTile(
                        {
                          unidadModelo: {"Modelo": 1},
                        },
                        widget.isReadOnly,
                      ),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 3,
                      mainAxisCellCount: .5,
                      child: expandFieldTile(
                        {
                          unidadTipo: {"Tipo": 1},
                        },
                        widget.isReadOnly,
                      ),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 3,
                      mainAxisCellCount: .5,
                      child: expandFieldTile(
                        {
                          unidadMotor: {"Motor": 1},
                        },
                        widget.isReadOnly,
                      ),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 3,
                      mainAxisCellCount: .5,
                      child: expandFieldTile(
                        {
                          unidadSerie: {"Serie del motor": 1},
                        },
                        widget.isReadOnly,
                      ),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 2,
                      mainAxisCellCount: .5,
                      child: dateFieldTile(
                        {
                          fechaLlegada: {"Fecha llegada": 1},
                        },
                        context,
                        widget.isReadOnly,
                      ),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 4,
                      mainAxisCellCount: .5,
                      child: expandFieldTile(
                        {
                          tecnicoAsignado: {"Tecnico asignado": 1},
                        },
                        widget.isReadOnly,
                      ),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 3,
                      mainAxisCellCount: .5,
                      child: expandFieldTile(
                        {
                          unidadPlacas: {"Placas": 1},
                        },
                        widget.isReadOnly,
                      ),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 3,
                      mainAxisCellCount: .5,
                      child: expandFieldTile(
                        {
                          unidadYear: {"Año": 1},
                        },
                        widget.isReadOnly,
                      ),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 2,
                      mainAxisCellCount: .5,
                      child: dateFieldTile(
                        {
                          fechaSalida: {"Fecha salida": 1},
                        },
                        context,
                        widget.isReadOnly,
                      ),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 4,
                      mainAxisCellCount: .5,
                      child: expandFieldTile(
                        {
                          numeroCaso: {"No. Caso": 1},
                        },
                        widget.isReadOnly,
                      ),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 6,
                      mainAxisCellCount: .5,
                      child: expandFieldTile(
                        {
                          unidadVin: {"V.I.N.": 1},
                        },
                        widget.isReadOnly,
                      ),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 6,
                      mainAxisCellCount: .5,
                      child: tituloTile("Comentarios del Cliente"),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 6,
                      mainAxisCellCount: .5,
                      child: tituloTile("Diagnostico"),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 6,
                      mainAxisCellCount: 1,
                      child: expandMultiLineFieldTile(
                        widget.isReadOnly,
                        3,
                        3,
                        34,
                        34,
                        {
                          clienteComentario: {"Comentarios del Cliente": 3},
                        },
                      ),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 6,
                      mainAxisCellCount: 1,
                      child: expandMultiLineFieldTile(
                        widget.isReadOnly,
                        3,
                        3,
                        34,
                        34,
                        {
                          diagnosticoController: {"Diagnostico": 3},
                        },
                      ),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 9,
                      mainAxisCellCount: .5,
                      child: tituloTile("Trabajos realizados / Refacciones"),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 3,
                      mainAxisCellCount: .5,
                      child: tituloTile("Costos"),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 9,
                      mainAxisCellCount: 1.49,
                      child: expandMultiLineFieldTile(
                        widget.isReadOnly,
                        5,
                        16,
                        35,
                        30,
                        {
                          trabajoRealizado: {
                            "Trabajos realizados / Refacciones": 3
                          },
                        },
                      ),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 3,
                      mainAxisCellCount: 1.49,
                      child: expandMultiLineFieldTile(
                        widget.isReadOnly,
                        5,
                        16,
                        35,
                        30,
                        {
                          costosController: {"Costos": 3},
                        },
                      ),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 12,
                      mainAxisCellCount: .5,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (widget.isReadOnly == true) {
                            Navigator.pop(context);
                          } else {
                            if (widget.id == null) {
                              await _addData();
                            } else if (widget.id != null) {
                              await _updateData(widget.id!);
                            }
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                            Colors.blue,
                          ),
                        ),
                        child: Text(
                          widget.isReadOnly == true
                              ? "Regresar"
                              : widget.id == null
                                  ? "Agregar orden"
                                  : "Actualizar",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

colorEstatus(orden) {
  switch (orden) {
    case "Pendiente":
      return Colors.orange;
    case "En proceso":
      return Colors.indigoAccent;
    case "Finalizado":
      return Colors.green;
    case "Cancelado":
      return Colors.redAccent;
    default:
      return Colors.black;
  }
}
