// // ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, use_build_context_synchronously

// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:techtruck_v11/widgets/db_helper.dart';
// import 'package:techtruck_v11/widgets/helper_widgets.dart';

// class FormularioOrden extends StatefulWidget {
//   final Map<String, dynamic> dataLocal;

//   FormularioOrden({
//     super.key,
//     required this.dataLocal,
//   });

//   @override
//   State<FormularioOrden> createState() => _FormularioOrdenState();
// }

// class _FormularioOrdenState extends State<FormularioOrden> {
//   final _formularioKey = GlobalKey<FormBuilderState>();
//   final estatus = "Pendiente";
//   final clienteNombreController = TextEditingController();
//   final clienteContactoController = TextEditingController();
//   final unidadNumEco = TextEditingController();
//   final unidadKilometros = TextEditingController();
//   final unidadMarca = TextEditingController();
//   final unidadModelo = TextEditingController();
//   final unidadHorasMotor = TextEditingController();
//   final unidadTipo = TextEditingController();
//   final unidadMotor = TextEditingController();
//   final unidadSerie = TextEditingController();
//   final unidadPlacas = TextEditingController();
//   final unidadYear = TextEditingController();
//   final unidadVin = TextEditingController();
//   final fechaLlegada = TextEditingController();
//   final fechaSalida = TextEditingController();
//   final tecnicoAsignado = TextEditingController();
//   final numeroCaso = TextEditingController();
//   final clienteComentario = TextEditingController();
//   final diagnosticoController = TextEditingController();
//   final trabajoRealizado = TextEditingController();
//   final costosController = TextEditingController();

//   @override
//   dispose() {
//     clienteNombreController.dispose();
//     clienteContactoController.dispose();
//     unidadNumEco.dispose();
//     unidadKilometros.dispose();
//     unidadMarca.dispose();
//     unidadModelo.dispose();
//     unidadHorasMotor.dispose();
//     unidadTipo.dispose();
//     unidadMotor.dispose();
//     unidadSerie.dispose();
//     unidadPlacas.dispose();
//     unidadYear.dispose();
//     unidadVin.dispose();
//     fechaLlegada.dispose();
//     fechaSalida.dispose();
//     tecnicoAsignado.dispose();
//     numeroCaso.dispose();
//     clienteComentario.dispose();
//     diagnosticoController.dispose();
//     trabajoRealizado.dispose();
//     costosController.dispose();

//     super.dispose();
//   }

//   void fillData() {
//     clienteNombreController.text = widget.dataLocal["clienteNombre"];
//     clienteContactoController.text = widget.dataLocal["clienteContacto"];
//     unidadNumEco.text = widget.dataLocal["unidadNumEco"];
//     unidadKilometros.text = widget.dataLocal["unidadKilometros"];
//     unidadMarca.text = widget.dataLocal["unidadMarca"];
//     unidadModelo.text = widget.dataLocal["unidadModelo"];
//     unidadHorasMotor.text = widget.dataLocal["unidadHorasMotor"];
//     unidadTipo.text = widget.dataLocal["unidadTipo"];
//     unidadMotor.text = widget.dataLocal["unidadMotor"];
//     unidadSerie.text = widget.dataLocal["unidadSerie"];
//     unidadPlacas.text = widget.dataLocal["unidadPlacas"];
//     unidadYear.text = widget.dataLocal["unidadYear"];
//     unidadVin.text = widget.dataLocal["unidadVin"];
//     fechaLlegada.text = widget.dataLocal["fechaLlegada"];
//     fechaSalida.text = widget.dataLocal["fechaSalida"];
//     tecnicoAsignado.text = widget.dataLocal["tecnicoAsignado"];
//     numeroCaso.text = widget.dataLocal["numeroCaso"];
//     clienteComentario.text = widget.dataLocal["clienteComentario"];
//     diagnosticoController.text = widget.dataLocal["diagnostico"];
//     trabajoRealizado.text = widget.dataLocal["trabajoRealizado"];
//     costosController.text = widget.dataLocal["costo"];
//   }

//   @override
//   void initState() {
//     super.initState();
//     _checkData();
//   }

//   void _checkData() {
//     if (widget.dataLocal["id"] != null) {
//       fillData();
//     } else {
//       cleanControllers();
//     }
//   }

//   void cleanControllers() {
//     clienteNombreController.clear();
//     clienteContactoController.clear();
//     unidadNumEco.clear();
//     unidadKilometros.clear();
//     unidadMarca.clear();
//     unidadModelo.clear();
//     unidadHorasMotor.clear();
//     unidadTipo.clear();
//     unidadMotor.clear();
//     unidadSerie.clear();
//     unidadPlacas.clear();
//     unidadYear.clear();
//     unidadVin.clear();
//     fechaLlegada.clear();
//     fechaSalida.clear();
//     tecnicoAsignado.clear();
//     numeroCaso.clear();
//     clienteComentario.clear();
//     diagnosticoController.clear();
//     trabajoRealizado.clear();
//     costosController.clear();
//   }

//   Future<void> _addData() async {
//     bool areAllFieldsFilled = clienteNombreController.text.isNotEmpty ||
//         clienteContactoController.text.isNotEmpty ||
//         unidadNumEco.text.isNotEmpty ||
//         unidadKilometros.text.isNotEmpty ||
//         unidadMarca.text.isNotEmpty ||
//         unidadModelo.text.isNotEmpty ||
//         unidadHorasMotor.text.isNotEmpty ||
//         unidadTipo.text.isNotEmpty ||
//         unidadMotor.text.isNotEmpty ||
//         unidadSerie.text.isNotEmpty ||
//         unidadPlacas.text.isNotEmpty ||
//         unidadYear.text.isNotEmpty ||
//         unidadVin.text.isNotEmpty ||
//         fechaLlegada.text.isNotEmpty ||
//         fechaSalida.text.isNotEmpty ||
//         tecnicoAsignado.text.isNotEmpty ||
//         numeroCaso.text.isNotEmpty ||
//         clienteComentario.text.isNotEmpty ||
//         diagnosticoController.text.isNotEmpty ||
//         trabajoRealizado.text.isNotEmpty ||
//         costosController.text.isNotEmpty;
//     if (!areAllFieldsFilled) {
//       ScaffoldMessenger.of(context).hideCurrentSnackBar();
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           backgroundColor: Colors.redAccent,
//           content: Text("Favor de llenar todos los campos"),
//         ),
//       );
//       return;
//     } else {
//       await SQLHelper.createData(
//         estatus,
//         clienteNombreController.text,
//         clienteContactoController.text,
//         unidadNumEco.text,
//         unidadKilometros.text,
//         unidadMarca.text,
//         unidadModelo.text,
//         unidadHorasMotor.text,
//         unidadTipo.text,
//         unidadMotor.text,
//         unidadSerie.text,
//         unidadPlacas.text,
//         unidadYear.text,
//         unidadVin.text,
//         fechaLlegada.text,
//         fechaSalida.text,
//         tecnicoAsignado.text,
//         numeroCaso.text,
//         clienteComentario.text,
//         diagnosticoController.text,
//         trabajoRealizado.text,
//         costosController.text,
//       );
//       cleanControllers();
//       Navigator.pop(context);
//     }
//   }

//   Future<void> _updateData(int id) async {
//     await SQLHelper.updateData(
//       id,
//       estatus,
//       clienteNombreController.text,
//       clienteContactoController.text,
//       unidadNumEco.text,
//       unidadKilometros.text,
//       unidadMarca.text,
//       unidadModelo.text,
//       unidadHorasMotor.text,
//       unidadTipo.text,
//       unidadMotor.text,
//       unidadSerie.text,
//       unidadPlacas.text,
//       unidadYear.text,
//       unidadVin.text,
//       fechaLlegada.text,
//       fechaSalida.text,
//       tecnicoAsignado.text,
//       numeroCaso.text,
//       clienteComentario.text,
//       diagnosticoController.text,
//       trabajoRealizado.text,
//       costosController.text,
//     );
//     cleanControllers();
//     Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     debugPrint(
//         "ESTAMOS EN FORMULARIO ############################################################");
//     return ListView(
//       children: [
//         FormBuilder(
//           key: _formularioKey,
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: StaggeredGrid.count(
//               crossAxisCount: 12,
//               mainAxisSpacing: 10,
//               crossAxisSpacing: 8,
//               children: [
//                 StaggeredGridTile.count(
//                   crossAxisCellCount: 6,
//                   mainAxisCellCount: .5,
//                   child: tituloTile("Datos del cliente"),
//                 ),
//                 StaggeredGridTile.count(
//                   crossAxisCellCount: 6,
//                   mainAxisCellCount: .5,
//                   child: tituloTile("Datos de la unidad"),
//                 ),
//                 StaggeredGridTile.count(
//                   crossAxisCellCount: 6,
//                   mainAxisCellCount: 1,
//                   // child: expandMultiLineFieldTile(
//                   //   {
//                   //     clienteNombreController: {"Nombre del cliente": 3},
//                   //   },
//                   // ),
//                   child: FormBuilderTextField(
//                     name: "nombreConductor",
//                     controller: clienteNombreController,
//                     decoration: InputDecoration(
//                       isDense: true,
//                       labelText: "Nombre del cliente",
//                       border: OutlineInputBorder(),
//                     ),
//                     style: TextStyle(
//                         // fontSize: 18,
//                         // fontWeight: FontWeight.bold,
//                         ),
//                     // cursorHeight: 22,
//                     maxLines: 3,

//                     // maxLength: 200,
//                     // selectionHeightStyle: BoxHeightStyle.tight,
//                     // selectionWidthStyle: BoxWidthStyle.tight,
//                     // keyboardType: TextInputType.multiline,
//                     // scrollPadding: EdgeInsets.all(20),
//                     // textAlign: TextAlign.start,
//                     // textAlignVertical: TextAlignVertical.top,
//                   ),
//                 ),
//                 // StaggeredGridTile.count(
//                 //   crossAxisCellCount: 3,
//                 //   mainAxisCellCount: .5,
//                 //   child: expandFieldTile(
//                 //     {
//                 //       unidadNumEco: {"No. Economico": 1},
//                 //     },
//                 //   ),
//                 // ),
//                 // StaggeredGridTile.count(
//                 //   crossAxisCellCount: 3,
//                 //   mainAxisCellCount: .5,
//                 //   child: expandFieldTile(
//                 //     {
//                 //       unidadKilometros: {"Kilometros": 1},
//                 //     },
//                 //   ),
//                 // ),
//                 // StaggeredGridTile.count(
//                 //   crossAxisCellCount: 3,
//                 //   mainAxisCellCount: .5,
//                 //   child: expandFieldTile(
//                 //     {
//                 //       unidadMarca: {"Marca": 1},
//                 //     },
//                 //   ),
//                 // ),
//                 // StaggeredGridTile.count(
//                 //   crossAxisCellCount: 3,
//                 //   mainAxisCellCount: .5,
//                 //   child: expandFieldTile(
//                 //     {
//                 //       unidadHorasMotor: {"Horas del motor": 1},
//                 //     },
//                 //   ),
//                 // ),
//                 // StaggeredGridTile.count(
//                 //   crossAxisCellCount: 6,
//                 //   mainAxisCellCount: 1,
//                 //   child: expandMultiLineFieldTile(
//                 //     {
//                 //       clienteContactoController: {"Contacto del cliente": 3},
//                 //     },
//                 //   ),
//                 // ),
//                 // StaggeredGridTile.count(
//                 //   crossAxisCellCount: 3,
//                 //   mainAxisCellCount: .5,
//                 //   child: expandFieldTile(
//                 //     {
//                 //       unidadModelo: {"Modelo": 1},
//                 //     },
//                 //   ),
//                 // ),
//                 // StaggeredGridTile.count(
//                 //   crossAxisCellCount: 3,
//                 //   mainAxisCellCount: .5,
//                 //   child: expandFieldTile(
//                 //     {
//                 //       unidadTipo: {"Tipo": 1},
//                 //     },
//                 //   ),
//                 // ),
//                 // StaggeredGridTile.count(
//                 //   crossAxisCellCount: 3,
//                 //   mainAxisCellCount: .5,
//                 //   child: expandFieldTile(
//                 //     {
//                 //       unidadMotor: {"Motor": 1},
//                 //     },
//                 //   ),
//                 // ),
//                 // StaggeredGridTile.count(
//                 //   crossAxisCellCount: 3,
//                 //   mainAxisCellCount: .5,
//                 //   child: expandFieldTile(
//                 //     {
//                 //       unidadSerie: {"Serie del motor": 1},
//                 //     },
//                 //   ),
//                 // ),
//                 // StaggeredGridTile.count(
//                 //   crossAxisCellCount: 2,
//                 //   mainAxisCellCount: .5,
//                 //   child: dateFieldTile({
//                 //     fechaLlegada: {"Fecha llegada": 1},
//                 //   }, context),
//                 // ),
//                 // StaggeredGridTile.count(
//                 //   crossAxisCellCount: 4,
//                 //   mainAxisCellCount: .5,
//                 //   child: expandFieldTile(
//                 //     {
//                 //       tecnicoAsignado: {"Tecnico asignado": 1},
//                 //     },
//                 //   ),
//                 // ),
//                 // StaggeredGridTile.count(
//                 //   crossAxisCellCount: 3,
//                 //   mainAxisCellCount: .5,
//                 //   child: expandFieldTile(
//                 //     {
//                 //       unidadPlacas: {"Placas": 1},
//                 //     },
//                 //   ),
//                 // ),
//                 // StaggeredGridTile.count(
//                 //   crossAxisCellCount: 3,
//                 //   mainAxisCellCount: .5,
//                 //   child: expandFieldTile(
//                 //     {
//                 //       unidadYear: {"Año": 1},
//                 //     },
//                 //   ),
//                 // ),
//                 // StaggeredGridTile.count(
//                 //   crossAxisCellCount: 2,
//                 //   mainAxisCellCount: .5,
//                 //   child: dateFieldTile(
//                 //     {
//                 //       fechaSalida: {"Fecha salida": 1},
//                 //     },
//                 //     context,
//                 //   ),
//                 // ),
//                 // StaggeredGridTile.count(
//                 //   crossAxisCellCount: 4,
//                 //   mainAxisCellCount: .5,
//                 //   child: expandFieldTile(
//                 //     {
//                 //       numeroCaso: {"No. Caso": 1},
//                 //     },
//                 //   ),
//                 // ),
//                 // StaggeredGridTile.count(
//                 //   crossAxisCellCount: 6,
//                 //   mainAxisCellCount: .5,
//                 //   child: expandFieldTile(
//                 //     {
//                 //       unidadVin: {"V.I.N.": 1},
//                 //     },
//                 //   ),
//                 // ),
//                 // StaggeredGridTile.count(
//                 //   crossAxisCellCount: 12,
//                 //   mainAxisCellCount: .5,
//                 //   child: tituloTile("Comentarios del Cliente"),
//                 // ),
//                 // StaggeredGridTile.count(
//                 //   crossAxisCellCount: 12,
//                 //   mainAxisCellCount: 1,
//                 //   child: expandMultiLineFieldTile(
//                 //     {
//                 //       clienteComentario: {"Comentarios del Cliente": 3},
//                 //     },
//                 //   ),
//                 // ),
//                 // StaggeredGridTile.count(
//                 //   crossAxisCellCount: 12,
//                 //   mainAxisCellCount: .5,
//                 //   child: tituloTile("Diagnostico"),
//                 // ),
//                 // StaggeredGridTile.count(
//                 //   crossAxisCellCount: 12,
//                 //   mainAxisCellCount: 1,
//                 //   child: expandMultiLineFieldTile(
//                 //     {
//                 //       diagnosticoController: {"Diagnostico": 3},
//                 //     },
//                 //   ),
//                 // ),
//                 // StaggeredGridTile.count(
//                 //   crossAxisCellCount: 7,
//                 //   mainAxisCellCount: .5,
//                 //   child: tituloTile("Trabajos realizados / Refacciones"),
//                 // ),
//                 // StaggeredGridTile.count(
//                 //   crossAxisCellCount: 5,
//                 //   mainAxisCellCount: .5,
//                 //   child: tituloTile("Costos"),
//                 // ),
//                 // StaggeredGridTile.count(
//                 //   crossAxisCellCount: 7,
//                 //   mainAxisCellCount: 1.7,
//                 //   child: expandMultiLineFieldTile(
//                 //     {
//                 //       trabajoRealizado: {
//                 //         "Trabajos realizados / Refacciones": 3
//                 //       },
//                 //     },
//                 //   ),
//                 // ),
//                 // StaggeredGridTile.count(
//                 //   crossAxisCellCount: 5,
//                 //   mainAxisCellCount: 1.7,
//                 //   child: expandMultiLineFieldTile(
//                 //     {
//                 //       costosController: {"Costos": 3},
//                 //     },
//                 //   ),
//                 // ),
//                 StaggeredGridTile.count(
//                   crossAxisCellCount: 12,
//                   mainAxisCellCount: .5,
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       if (widget.dataLocal["id"] == null) {
//                         await _addData();
//                       } else if (widget.dataLocal["id"] != null) {
//                         await _updateData(widget.dataLocal["id"]!);
//                       }
//                     },
//                     child: Text(widget.dataLocal["id"] == null
//                         ? "Agregar"
//                         : "Actualizar"),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
