// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:techtruck_v11/views/new_order.dart';
import 'package:techtruck_v11/views/order_details.dart';
import 'package:techtruck_v11/views/pdf_order.dart';
import 'package:techtruck_v11/widgets/db_helper.dart';
import 'package:techtruck_v11/widgets/helper_widgets.dart';

class AllOrders extends StatefulWidget {
  const AllOrders({super.key});

  @override
  State<AllOrders> createState() => _AllOrdersState();
}

class _AllOrdersState extends State<AllOrders> {
  List<Map<String, dynamic>> _allData = [];
  bool _isLoading = true;

  List<String> estadosOrden = [
    "Pendiente",
    "En proceso",
    "Finalizado",
    "Cancelado"
  ];

  List<String> estadosOrdenFiltro = [];
  late String estatus = estadosOrden[0];
  final TextEditingController _clienteNombreController =
      TextEditingController();
  final TextEditingController _clienteContactoController =
      TextEditingController();
  final TextEditingController _unidadNumEco = TextEditingController();
  final TextEditingController _unidadKilometros = TextEditingController();
  final TextEditingController _unidadMarca = TextEditingController();
  final TextEditingController _unidadModelo = TextEditingController();
  final TextEditingController _unidadHorasMotor = TextEditingController();
  final TextEditingController _unidadTipo = TextEditingController();
  final TextEditingController _unidadMotor = TextEditingController();
  final TextEditingController _unidadSerie = TextEditingController();
  final TextEditingController _unidadPlacas = TextEditingController();
  final TextEditingController _unidadYear = TextEditingController();
  final TextEditingController _unidadVin = TextEditingController();
  final TextEditingController _fechaLlegada = TextEditingController();
  final TextEditingController _fechaSalida = TextEditingController();
  final TextEditingController _tecnicoAsignado = TextEditingController();
  final TextEditingController _numeroCaso = TextEditingController();
  final TextEditingController _clienteComentario = TextEditingController();
  final TextEditingController _diagnosticoController = TextEditingController();
  final TextEditingController _trabajoRealizado = TextEditingController();
  final TextEditingController _costosController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  void _refreshData() async {
    final data = await SQLHelper.getAllData();
    setState(() {
      _allData = data;
      _isLoading = false;
    });
    cleanControllers();
  }

  void cleanControllers() {
    _clienteNombreController.clear();
    _clienteContactoController.clear();
    _unidadNumEco.clear();
    _unidadKilometros.clear();
    _unidadMarca.clear();
    _unidadModelo.clear();
    _unidadHorasMotor.clear();
    _unidadTipo.clear();
    _unidadMotor.clear();
    _unidadSerie.clear();
    _unidadPlacas.clear();
    _unidadYear.clear();
    _unidadVin.clear();
    _fechaLlegada.clear();
    _fechaSalida.clear();
    _tecnicoAsignado.clear();
    _numeroCaso.clear();
    _clienteComentario.clear();
    _diagnosticoController.clear();
    _trabajoRealizado.clear();
    _costosController.clear();
  }

  Future<void> _addData() async {
    bool areAllFieldsFilled = _clienteNombreController.text.isNotEmpty ||
        _clienteContactoController.text.isNotEmpty ||
        _unidadNumEco.text.isNotEmpty ||
        _unidadKilometros.text.isNotEmpty ||
        _unidadMarca.text.isNotEmpty ||
        _unidadModelo.text.isNotEmpty ||
        _unidadHorasMotor.text.isNotEmpty ||
        _unidadTipo.text.isNotEmpty ||
        _unidadMotor.text.isNotEmpty ||
        _unidadSerie.text.isNotEmpty ||
        _unidadPlacas.text.isNotEmpty ||
        _unidadYear.text.isNotEmpty ||
        _unidadVin.text.isNotEmpty ||
        _fechaLlegada.text.isNotEmpty ||
        _fechaSalida.text.isNotEmpty ||
        _tecnicoAsignado.text.isNotEmpty ||
        _numeroCaso.text.isNotEmpty ||
        _clienteComentario.text.isNotEmpty ||
        _diagnosticoController.text.isNotEmpty ||
        _trabajoRealizado.text.isNotEmpty ||
        _costosController.text.isNotEmpty;
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
        _clienteNombreController.text,
        _clienteContactoController.text,
        _unidadNumEco.text,
        _unidadKilometros.text,
        _unidadMarca.text,
        _unidadModelo.text,
        _unidadHorasMotor.text,
        _unidadTipo.text,
        _unidadMotor.text,
        _unidadSerie.text,
        _unidadPlacas.text,
        _unidadYear.text,
        _unidadVin.text,
        _fechaLlegada.text,
        _fechaSalida.text,
        _tecnicoAsignado.text,
        _numeroCaso.text,
        _clienteComentario.text,
        _diagnosticoController.text,
        _trabajoRealizado.text,
        _costosController.text,
      );
    }

    _refreshData();
  }

  Future<void> _updateData(int id) async {
    await SQLHelper.updateData(
      id,
      estatus,
      _clienteNombreController.text,
      _clienteContactoController.text,
      _unidadNumEco.text,
      _unidadKilometros.text,
      _unidadMarca.text,
      _unidadModelo.text,
      _unidadHorasMotor.text,
      _unidadTipo.text,
      _unidadMotor.text,
      _unidadSerie.text,
      _unidadPlacas.text,
      _unidadYear.text,
      _unidadVin.text,
      _fechaLlegada.text,
      _fechaSalida.text,
      _tecnicoAsignado.text,
      _numeroCaso.text,
      _clienteComentario.text,
      _diagnosticoController.text,
      _trabajoRealizado.text,
      _costosController.text,
    );
    _refreshData();
  }

  void _deleteData(int id) async {
    await SQLHelper.deleteData(id, context);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text("Orden eliminada"),
      ),
    );

    _refreshData();
  }

  void showFullOrder(int? id) {
    Map<String, dynamic> existingData = {};
    if (id != null) {
      existingData = _allData.firstWhere((element) => element["id"] == id);
    } else {
      cleanControllers();
    }

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => NewOrder(
                singleData: existingData,
                idOrder: id,
              )),
    ).then((res) => _refreshData());
  }

  void tempShowFullOrder(int? id) {
    Map<String, dynamic> existingData = {};
    if (id != null) {
      existingData = _allData.firstWhere((element) => element["id"] == id);
    } else {
      cleanControllers();
    }

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => OrderDetails(
                singleData: existingData,
              )),
    ).then((res) => _refreshData());
  }

  void convertOrderPdf(int? id) {
    Map<String, dynamic> existingData = {};
    if (id != null) {
      existingData = _allData.firstWhere((element) => element["id"] == id);
    } else {
      cleanControllers();
    }
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PdfOrder(
                orderToPrint: existingData,
              )),
    ).then((res) => _refreshData());
  }

  void showBottomSheet(int? id) async {
    Map<String, dynamic> existingData = {};
    if (id != null) {
      existingData = _allData.firstWhere((element) => element["id"] == id);
      estatus = existingData["estatus"];
      _clienteNombreController.text = existingData["clienteNombre"];
      _clienteContactoController.text = existingData["clienteContacto"];
      _unidadNumEco.text = existingData["unidadNumEco"];
      _unidadKilometros.text = existingData["unidadKilometros"];
      _unidadMarca.text = existingData["unidadMarca"];
      _unidadModelo.text = existingData["unidadModelo"];
      _unidadHorasMotor.text = existingData["unidadHorasMotor"];
      _unidadTipo.text = existingData["unidadTipo"];
      _unidadMotor.text = existingData["unidadMotor"];
      _unidadSerie.text = existingData["unidadSerie"];
      _unidadPlacas.text = existingData["unidadPlacas"];
      _unidadYear.text = existingData["unidadYear"];
      _unidadVin.text = existingData["unidadVin"];
      _fechaLlegada.text = existingData["fechaLlegada"];
      _fechaSalida.text = existingData["fechaSalida"];
      _tecnicoAsignado.text = existingData["tecnicoAsignado"];
      _numeroCaso.text = existingData["numeroCaso"];
      _clienteComentario.text = existingData["clienteComentario"];
      _diagnosticoController.text = existingData["diagnostico"];
      _trabajoRealizado.text = existingData["trabajoRealizado"];
      _costosController.text = existingData["costo"];
    } else {
      cleanControllers();
    }

    showModalBottomSheet(
        elevation: 5,
        isScrollControlled: true,
        context: context,
        builder: (_) => Container(
              padding: EdgeInsets.only(
                top: 30,
                left: 15,
                right: 15,
                bottom: MediaQuery.of(context).viewInsets.bottom + 50,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: _clienteNombreController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Nombre del cliente",
                    ),
                  ),
                  addVerticalSpace(10),
                  TextField(
                    controller: _unidadNumEco,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "No. Economico",
                    ),
                  ),
                  addVerticalSpace(10),
                  TextField(
                    controller: _clienteContactoController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Nombre del conductor",
                    ),
                  ),
                  addVerticalSpace(10),
                  TextField(
                    controller: _clienteComentario,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  addVerticalSpace(20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (id == null) {
                          await _addData();
                        }
                        if (id != null) {
                          await _updateData(id);
                        }
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Text(id == null ? "Agregar" : "Actualizar",
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            )),
                      ),
                    ),
                  )
                ],
              ),
            ));
  }

  static String _formatFolio(String? s) {
    if (s != null && s.length < 6) {
      return s.padLeft(6, '0');
    } else {
      return s!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filtroOrdenes = _allData.where((orden) {
      return estadosOrdenFiltro.isEmpty ||
          estadosOrdenFiltro.contains(orden["estatus"]);
    });
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text("Ordenes de servicio",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.white,
            )),
        backgroundColor: Colors.blue.shade600,
        centerTitle: true,
        actions: [
          ElevatedButton(
            onPressed: () {
              showFullOrder(null);
            },
            child: const Text("Nueva orden"),
          ),
          addHorizontalSpace(15),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: filtroOrdenes.length,
              itemBuilder: (context, index) {
                final orden = filtroOrdenes.elementAt(index);
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          _formatFolio("${orden["id"]}"),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        addVerticalSpace(4),
                        Text(
                          "${orden["estatus"]}",
                          style: TextStyle(
                            color: colorEstatus(orden["estatus"]),
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    minLeadingWidth: 80,
                    hoverColor: const Color(0xFFE9EBF7),
                    mouseCursor: SystemMouseCursors.click,
                    title: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          parseString(orden["clienteNombre"]),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )),
                    subtitle:
                        Text("No. Eco: ${parseString(orden["unidadNumEco"])}"),
                    onTap: () {
                      showFullOrder(orden["id"]);
                    },
                    trailing: PopupMenuButton(
                      tooltip: ("Opciones"),
                      itemBuilder: (context) => [
                        // PopupMenuItem(
                        //   child: ListTile(
                        //     leading: const Icon(Icons.edit),
                        //     title: const Text("Editar"),
                        //     onTap: () {
                        //       showFullOrder(orden["id"]);
                        //     },
                        //   ),
                        // ),
                        // PopupMenuItem(
                        //   child: ListTile(
                        //     leading: const Icon(Icons.remove_red_eye),
                        //     title: const Text("Ver detalles"),
                        //     onTap: () {
                        //       tempShowFullOrder(orden["id"]);
                        //     },
                        //   ),
                        // ),
                        PopupMenuItem(
                          child: const Row(
                            children: [
                              Icon(
                                Icons.check_box,
                                color: Colors.orange,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 12.0),
                                child: Text(
                                  "Pendiente",
                                ),
                              ),
                            ],
                          ),
                          onTap: () async {
                            final result = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(
                                    "Orden ${_formatFolio("${orden["id"]}")}"),
                                content: const Text(
                                    'Marcar esta orden como "Pendiente"?'),
                                actionsAlignment: MainAxisAlignment.spaceEvenly,
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: const Text('Cancelar'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      estatus = estadosOrden[0];
                                      _updateData(orden["id"]);
                                      Navigator.pop(context, true);
                                    },
                                    child: const Text('Aceptar'),
                                  ),
                                ],
                              ),
                            );

                            if (result == null || !result) {
                              return;
                            }
                          },
                        ),
                        // ),
                        PopupMenuItem(
                          child: const Row(
                            children: [
                              Icon(
                                Icons.check_box,
                                color: Colors.indigo,
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 12.0),
                                  child: Text("En proceso")),
                            ],
                          ),
                          onTap: () async {
                            final result = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(
                                    "Orden ${_formatFolio("${orden["id"]}")}"),
                                content: const Text(
                                    'Marcar esta orden como "En proceso" ?'),
                                actionsAlignment: MainAxisAlignment.spaceEvenly,
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: const Text('Cancelar'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      estatus = estadosOrden[1];
                                      _updateData(orden["id"]);
                                      Navigator.pop(context, true);
                                    },
                                    child: const Text('Aceptar'),
                                  ),
                                ],
                              ),
                            );

                            if (result == null || !result) {
                              return;
                            }
                          },
                        ),
                        PopupMenuItem(
                          child: const Row(
                            children: [
                              Icon(
                                Icons.check_box,
                                color: Colors.green,
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 12.0),
                                  child: Text("Finalizado")),
                            ],
                          ),
                          onTap: () async {
                            final result = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text(
                                    'Marcar esta orden como "Finalizada"?'),
                                // content: const Text(
                                //     'This action will permanently delete this data'),
                                actionsAlignment: MainAxisAlignment.spaceEvenly,

                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: const Text('Cancelar'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      estatus = estadosOrden[2];
                                      _updateData(orden["id"]);
                                      Navigator.pop(context, true);
                                    },
                                    child: const Text('Finalizar'),
                                  ),
                                ],
                              ),
                            );

                            if (result == null || !result) {
                              return;
                            }
                          },
                        ),
                        PopupMenuItem(
                          child: const Row(
                            children: [
                              Icon(
                                Icons.check_box,
                                color: Colors.red,
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 12.0),
                                  child: Text("Cancelar orden")),
                            ],
                          ),
                          onTap: () async {
                            final result = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(
                                    "Orden ${_formatFolio("${orden["id"]}")}"),
                                content:
                                    const Text('Desea cancelar esta orden?'),
                                actionsAlignment: MainAxisAlignment.spaceEvenly,
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: const Text('Cancelar'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      estatus = estadosOrden[3];
                                      _updateData(orden["id"]);
                                      Navigator.pop(context, true);
                                    },
                                    child: const Text('Finalizar'),
                                  ),
                                ],
                              ),
                            );

                            if (result == null || !result) {
                              return;
                            }
                          },
                        ),

                        PopupMenuItem(
                          child: const Row(
                            children: [
                              // const Icon(
                              //   Icons.picture_as_pdf,
                              //   color: Colors.blueGrey,
                              // ),
                              Icon(
                                Icons.print,
                                color: Colors.blueGrey,
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 12.0),
                                  child: Text("Generar PDF")),
                            ],
                          ),
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PdfOrder(
                                  orderToPrint: orden,
                                ),
                              ),
                            ).then((res) => _refreshData());
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showBottomSheet(null),
        child: const Icon(Icons.add),
      ),
      drawer: Drawer(
        width: 220,
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: const Text(
                    "Filtro de ordenes",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              const Divider(
                thickness: 2,
              ),
              addVerticalSpace(10),
              Column(
                children: buildChipFilter(context),
              ),
              const Divider(
                thickness: 2,
              ),
              Visibility(
                visible: estadosOrdenFiltro.isNotEmpty,
                child: FilterChip(
                  label: const Text("Limpiar filtros",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  selected: estadosOrdenFiltro.isEmpty,
                  onSelected: (bool selected) {
                    setState(
                      () {
                        if (selected) {
                          estadosOrdenFiltro.clear();
                          Navigator.pop(context);
                        }
                      },
                    );
                  },
                ),
              )
            ]),
      ),
    );
  }

  List<Widget> buildChipFilter(BuildContext context) {
    return estadosOrden.map(
      (estado) {
        return Column(
          children: [
            FilterChip(
              label: Text(estado,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: estadosOrdenFiltro.contains(estado)
                        ? Colors.white
                        : colorEstatus(estado),
                  )),
              checkmarkColor: Colors.white,
              selectedColor: colorEstatus(estado),
              selected: estadosOrdenFiltro.contains(estado),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(
                  color: Colors.black,
                  width: 1.5,
                ),
              ),
              onSelected: (bool selected) {
                setState(
                  () {
                    if (selected) {
                      estadosOrdenFiltro.add(estado);
                    } else {
                      estadosOrdenFiltro.remove(estado);
                    }
                  },
                );
              },
            ),
            addVerticalSpace(15),
          ],
        );
      },
    ).toList();
  }

  String parseString(String? value) {
    if (value == null) {
      return "Valor Nulo";
    }
    return value.toString();
  }
}

colorEstatus(orden) {
  switch (orden) {
    case "Pendiente":
      return Colors.black54;
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
