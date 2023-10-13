// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:techtruck_v11/widgets/helper_widgets.dart';
import 'package:techtruck_v11/design/palette.dart';

class NewOrder extends StatelessWidget {
  const NewOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Nueva orden")),
        body: const Center(
          child: FomularioOrden(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ));
  }
}

class FomularioOrden extends StatefulWidget {
  const FomularioOrden({super.key});
  @override
  FomularioOrdenState createState() {
    return FomularioOrdenState();
  }
}

class FomularioOrdenState extends State<FomularioOrden> {
  final _formularioKey = GlobalKey<FormState>();
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
  final unidadAno = TextEditingController();
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
    unidadAno.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          Form(
            // key: _formularioKey,
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
                      {
                        clienteNombreController: {"Nombre del cliente": 3},
                      },
                    ),
                  ),
                  // child: Tile(index: 1)),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 3,
                    mainAxisCellCount: .5,
                    child: expandFieldTile(
                      {
                        unidadNumEco: {"No. Economico": 1},
                      },
                    ),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 3,
                    mainAxisCellCount: .5,
                    child: expandFieldTile(
                      {
                        unidadKilometros: {"Kilometros": 1},
                      },
                    ),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 3,
                    mainAxisCellCount: .5,
                    child: expandFieldTile(
                      {
                        unidadMarca: {"Marca": 1},
                      },
                    ),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 3,
                    mainAxisCellCount: .5,
                    child: expandFieldTile(
                      {
                        unidadHorasMotor: {"Horas del motor": 1},
                      },
                    ),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 6,
                    mainAxisCellCount: 1,
                    child: expandMultiLineFieldTile(
                      {
                        clienteContactoController: {"Contacto del cliente": 3},
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
                    ),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 3,
                    mainAxisCellCount: .5,
                    child: expandFieldTile(
                      {
                        unidadTipo: {"Tipo": 1},
                      },
                    ),
                  ),

                  StaggeredGridTile.count(
                    crossAxisCellCount: 3,
                    mainAxisCellCount: .5,
                    child: expandFieldTile(
                      {
                        unidadMotor: {"Motor": 1},
                      },
                    ),
                  ),

                  StaggeredGridTile.count(
                    crossAxisCellCount: 3,
                    mainAxisCellCount: .5,
                    child: expandFieldTile(
                      {
                        unidadSerie: {"Serie del motor": 1},
                      },
                    ),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: .5,
                    child: dateFieldTile({
                      fechaLlegada: {"Fecha llegada": 1},
                    }, context),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 4,
                    mainAxisCellCount: .5,
                    child: expandFieldTile(
                      {
                        tecnicoAsignado: {"Tecnico asignado": 1},
                      },
                    ),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 3,
                    mainAxisCellCount: .5,
                    child: expandFieldTile(
                      {
                        unidadPlacas: {"Placas": 1},
                      },
                    ),
                  ),

                  StaggeredGridTile.count(
                    crossAxisCellCount: 3,
                    mainAxisCellCount: .5,
                    child: expandFieldTile(
                      {
                        unidadAno: {"Año": 1},
                      },
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
                    ),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 4,
                    mainAxisCellCount: .5,
                    child: expandFieldTile(
                      {
                        numeroCaso: {"No. Caso": 1},
                      },
                    ),
                  ),

                  StaggeredGridTile.count(
                    crossAxisCellCount: 6,
                    mainAxisCellCount: .5,
                    child: expandFieldTile(
                      {
                        unidadVin: {"V.I.N.": 1},
                      },
                    ),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 12,
                    mainAxisCellCount: .5,
                    child: tituloTile("Comentarios del Cliente"),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 12,
                    mainAxisCellCount: 1,
                    child: expandMultiLineFieldTile(
                      {
                        clienteComentario: {"Comentarios del Cliente": 3},
                      },
                    ),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 12,
                    mainAxisCellCount: .5,
                    child: tituloTile("Diagnostico"),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 12,
                    mainAxisCellCount: 1,
                    child: expandMultiLineFieldTile(
                      {
                        diagnosticoController: {"Diagnostico": 3},
                      },
                    ),
                  ),

                  StaggeredGridTile.count(
                    crossAxisCellCount: 7,
                    mainAxisCellCount: .5,
                    child: tituloTile("Trabajos realizados / Refacciones"),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 5,
                    mainAxisCellCount: .5,
                    child: tituloTile("Costos"),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 7,
                    mainAxisCellCount: 1.7,
                    child: expandMultiLineFieldTile(
                      {
                        trabajoRealizado: {
                          "Trabajos realizados / Refacciones": 3
                        },
                      },
                    ),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 5,
                    mainAxisCellCount: 1.7,
                    child: expandMultiLineFieldTile(
                      {
                        costosController: {"Costos": 3},
                      },
                    ),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 12,
                    mainAxisCellCount: .5,
                    child: ElevatedButton(
                      onPressed: () {
                        // showDialog(
                        //   context: context,
                        //   builder: (context) {
                        //     return AlertDialog(
                        //         // content: Text(primerController.text),
                        //         );
                        //   },
                        // );
                        // dispose();
                      },
                      child: const Text('Crear orden'),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
