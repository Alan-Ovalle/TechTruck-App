// ignore_for_file: use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  SharedPreferences? _prefs;

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
    checkPreferences();
    _refreshData();
  }

  checkPreferences() async {
    _prefs = await SharedPreferences.getInstance();
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

  Future<void> _addData(bool? nuevaOrden) async {
    if (nuevaOrden == true) {
      estatus = estadosOrden[0];
    }

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

  bool ordenAscendete = false;

  void _customSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(message),
      ),
    );
  }

  void _deleteData(int id) async {
    await SQLHelper.deleteData(id, context);
    _customSnackBar("Orden eliminada correctamente.", Colors.redAccent);

    _refreshData();
  }

  void _upadateEstatus(int id, String? estatus, Color color) async {
    await SQLHelper.updateEstatusField(id, estatus);
    _customSnackBar(
        "La orden ${id.toString()} fue marcada como ${estatus!} correctamente.",
        color);

    _refreshData();
  }

  void showFullOrder(int? id) {
    Map<String, dynamic> existingData = {};
    if (id != null) {
      existingData = _allData.firstWhere((element) => element["id"] == id);
    } else {
      cleanControllers();
      existingData["estatus"] = "Pendiente";
    }

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NewOrder(
                  singleData: existingData,
                  idOrder: id,
                  isReadOnly:
                      existingData["estatus"] == "Pendiente" ? false : true,
                ))).then((res) => _refreshData());
  }

  // void tempShowFullOrder(int? id) {
  //   Map<String, dynamic> existingData = {};
  //   if (id != null) {
  //     existingData = _allData.firstWhere((element) => element["id"] == id);
  //   } else {
  //     cleanControllers();
  //   }

  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //         builder: (context) => OrderDetails(
  //               singleData: existingData,
  //             )),
  //   ).then((res) => _refreshData());
  // }

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
      estatus = estadosOrden[0];
      cleanControllers();
    }

    showModalBottomSheet(
        // elevation: 5,
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
                      labelText: "Comentario del cliente",
                    ),
                  ),
                  addVerticalSpace(20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (id == null) {
                          await _addData(null);
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
                        child: Text(
                          id == null ? "Agregar" : "Actualizar",
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
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

  final ScrollController scrollControllerOne = ScrollController();

  List<PopupMenuItem> listaPopItem(Map<String, dynamic> orden) {
    List<PopupMenuItem> lista = [
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
            builder: (context) {
              estatus = estadosOrden[0];
              return customAlertDialog(
                  context, _formatFolio("${orden["id"]}"), estatus, () async {
                _upadateEstatus(orden["id"], estatus, Colors.orange);
                Navigator.pop(context, true);
              }, Colors.orange);
            },
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
            builder: (context) {
              estatus = estadosOrden[1];
              return customAlertDialog(
                context,
                _formatFolio("${orden["id"]}"),
                estatus,
                () async {
                  _upadateEstatus(orden["id"], estatus, Colors.indigo);
                  Navigator.pop(context, true);
                },
                Colors.indigo,
              );
            },
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
            builder: (context) {
              estatus = estadosOrden[2];
              return customAlertDialog(
                context,
                _formatFolio("${orden["id"]}"),
                estatus,
                () async {
                  _upadateEstatus(orden["id"], estatus, Colors.green);
                  Navigator.pop(context, true);
                },
                Colors.green,
              );
            },
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
            builder: (context) {
              estatus = estadosOrden[3];
              return customAlertDialog(
                context,
                _formatFolio("${orden["id"]}"),
                estatus,
                () async {
                  _upadateEstatus(orden["id"], estatus, Colors.red);
                  Navigator.pop(context, true);
                },
                Colors.red,
              );
            },
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
    ];

    switch (orden["estatus"]) {
      case "Pendiente":
        lista.remove(lista[0]);
        break;
      case "En proceso":
        lista.remove(lista[1]);
        break;
      case "Finalizado":
        lista.remove(lista[2]);
        break;
      case "Cancelado":
        lista.remove(lista[3]);

        break;
      default:
    }
    if (orden["estatus"] == "Cancelado") {
      lista.add(
        PopupMenuItem(
          child: const Row(
            children: [
              Icon(
                Icons.delete,
                color: Colors.redAccent,
              ),
              Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: Text(
                  "Eliminar",
                ),
              ),
            ],
          ),
          onTap: () async {
            final result = await showDialog<bool>(
              context: context,
              builder: (context) {
                return customAlertDialog(
                  context,
                  _formatFolio("${orden["id"]}"),
                  "Eliminar",
                  () async {
                    _deleteData(orden["id"]);
                    Navigator.pop(context, true);
                  },
                  Colors.red,
                );
              },
            );
            if (result == null || !result) {
              return;
            }
          },
        ),
      );
    }

    return lista;
  }

  @override
  Widget build(BuildContext context) {
    estadosOrdenFiltro = _prefs?.getStringList("estadosOrdenFiltro") ?? [];
    final filtroOrdenes = _allData.where((orden) {
      return estadosOrdenFiltro.isEmpty ||
          estadosOrdenFiltro.contains(orden["estatus"]);
    });
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: 'Filtrar ordenes',
            );
          },
        ),
        title: const Text(
          "Ordenes de servicio",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.white,
          ),
        ),
        // backgroundColor: Colors.black54,
        backgroundColor: Colors.blue.shade900,

        centerTitle: true,
        actions: [
          ElevatedButton(
            onPressed: () {
              showFullOrder(null);
            },
            onLongPress: () {
              _addData(true);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.blue.shade800,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: const Text(
              "Nueva orden",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          addHorizontalSpace(15),
          IconButton(
            onPressed: () => showBottomSheet(null),
            icon: const Icon(Icons.post_add_rounded),
            iconSize: 25,
            hoverColor: Colors.blue.shade800,
            tooltip: "Crear orden express",
            visualDensity: const VisualDensity(
              horizontal: 1,
              vertical: 1,
            ),
          ),
          addHorizontalSpace(10),
          IconButton(
            onPressed: () {
              ordenAscendete = !ordenAscendete;
              if (ordenAscendete) {
                scrollControllerOne.animateTo(
                  scrollControllerOne.position.maxScrollExtent,
                  duration: const Duration(seconds: 2),
                  curve: Curves.fastOutSlowIn,
                );
              } else {
                scrollControllerOne.animateTo(
                  scrollControllerOne.position.minScrollExtent,
                  duration: const Duration(seconds: 2),
                  curve: Curves.fastOutSlowIn,
                );
              }
              _refreshData();
            },
            icon: ordenAscendete == true
                ? const Icon(Icons.arrow_circle_up_rounded)
                : const Icon(Icons.arrow_circle_down_rounded),
            iconSize: 25,
            hoverColor: Colors.blue.shade800,
            tooltip: "Invertir orden de la lista",
            visualDensity: const VisualDensity(
              horizontal: 1,
              vertical: 1,
            ),
          ),
          addHorizontalSpace(15),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Scrollbar(
              controller: scrollControllerOne,
              child: ListView.builder(
                reverse: ordenAscendete,
                controller: scrollControllerOne,
                padding: const EdgeInsets.only(right: 15),
                itemCount: filtroOrdenes.length,
                itemBuilder: (context, index) {
                  final orden = filtroOrdenes.elementAt(index);
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: ListTile(
                      horizontalTitleGap: 25,
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Text(
                              _formatFolio("${orden["id"]}"),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          addVerticalSpace(2),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: colorEstatus(orden["estatus"]),
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  width: 1.5,
                                ),
                              ),
                              width: 85,
                              child: Center(
                                child: Text(
                                  "${orden["estatus"]}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      hoverColor: const Color(0xFFE9EBF7),
                      mouseCursor: SystemMouseCursors.click,
                      title: Row(
                        children: [
                          SizedBox(
                              width: 250,
                              height: 24,
                              child: RichText(
                                text: TextSpan(
                                  text: "Cliente: ",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: parseString(
                                        orden["clienteNombre"],
                                      ),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                        overflow: TextOverflow.fade,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          Flexible(
                            child: SizedBox(
                                width: 450,
                                height: 24,
                                child: RichText(
                                  text: TextSpan(
                                    text: "Comentario: ",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 18,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: parseString(
                                          orden["clienteComentario"],
                                        ),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ],
                      ),
                      subtitle: Row(
                        children: [
                          SizedBox(
                              width: 250,
                              child: RichText(
                                text: TextSpan(
                                  text: "Llegada: ",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: parseString(
                                        orden["fechaLlegada"],
                                      ),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          SizedBox(
                              width: 250,
                              child: RichText(
                                text: TextSpan(
                                  text: "No. Eco: ",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: parseString(
                                        orden["unidadNumEco"],
                                      ),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          SizedBox(
                              width: 250,
                              child: RichText(
                                text: TextSpan(
                                  text: "Marca: ",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: parseString(
                                        orden["unidadMarca"],
                                      ),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          SizedBox(
                              width: 250,
                              child: RichText(
                                text: TextSpan(
                                  text: "Tipo: ",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: parseString(
                                        orden["unidadTipo"],
                                      ),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                      onTap: () {
                        showFullOrder(orden["id"]);
                      },
                      trailing: PopupMenuButton(
                        tooltip: ("Opciones"),
                        itemBuilder: (context) => listaPopItem(orden),
                      ),
                    ),
                  );
                },
              ),
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
                        _prefs?.setStringList(
                          "estadosOrdenFiltro",
                          estadosOrdenFiltro,
                        );
                        Navigator.pop(context);
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
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
                    _prefs?.setStringList(
                      "estadosOrdenFiltro",
                      estadosOrdenFiltro,
                    );
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
    } else if (value == "") {
      return "_________";
    }
    return value.toString();
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
