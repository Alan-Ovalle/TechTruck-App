import 'package:flutter/material.dart';
import 'package:techtruck_v11/views/all_orders.dart';
import 'package:techtruck_v11/views/pdf_order.dart';
import 'package:techtruck_v11/widgets/helper_widgets.dart';

class BuscarOrden extends StatefulWidget {
  final List<Map<String, dynamic>> allData;
  const BuscarOrden({
    super.key,
    required this.allData,
  });

  @override
  State<BuscarOrden> createState() => _BuscarOrdenState();
}

class _BuscarOrdenState extends State<BuscarOrden> {
  final ScrollController scrollControllerThree = ScrollController();
  late String estatus = "Pendiente";
  final _busquedaController = TextEditingController();
  List<Map<String, dynamic>> _allOrdersData = [];
  List<Map<String, dynamic>> _filteredOrdenes = [];

  @override
  void initState() {
    super.initState();
    // Fetching the data from firestore
    setState(() {
      _allOrdersData = widget.allData;
      _filteredOrdenes = _allOrdersData;
    });
  }

  @override
  void dispose() {
    _busquedaController.dispose();
    super.dispose();
  }

  static String _formatFolio(String? s) {
    if (s != null && s.length < 6) {
      return s.padLeft(6, '0');
    } else {
      return s!;
    }
  }

  List<PopupMenuItem> listaPopItem(Map<String, dynamic> orden) {
    List<PopupMenuItem> lista;

    lista = [
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
              // estatus = estadosOrden[0];
              return customAlertDialog(
                  context, _formatFolio("${orden["id"]}"), estatus, () async {
                // _upadateEstatus(orden["id"], estatus, Colors.orange);
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
              // estatus = estadosOrden[1];
              return customAlertDialog(
                context,
                _formatFolio("${orden["id"]}"),
                estatus,
                () async {
                  // _upadateEstatus(orden["id"], estatus, Colors.indigo);
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
              // estatus = estadosOrden[2];
              return customAlertDialog(
                context,
                _formatFolio("${orden["id"]}"),
                estatus,
                () async {
                  // _upadateEstatus(orden["id"], estatus, Colors.green);
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
              // estatus = estadosOrden[3];
              return customAlertDialog(
                context,
                _formatFolio("${orden["id"]}"),
                estatus,
                () async {
                  // _upadateEstatus(orden["id"], estatus, Colors.red);
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
          );
          // .then((res) => _refreshData());
        },
      ),
    ];

    switch (orden["estatus"]) {
      case "Pendiente":
        lista.removeWhere((item) =>
            (((item.child as Row?)!.children[1] as Padding?)!.child as Text?)!
                .data ==
            "Pendiente");
        lista.removeWhere((item) =>
            (((item.child as Row?)!.children[1] as Padding?)!.child as Text?)!
                .data ==
            "Finalizado");

        break;
      case "En proceso":
        lista.removeWhere((item) =>
            (((item.child as Row?)!.children[1] as Padding?)!.child as Text?)!
                .data ==
            "En proceso");
        lista.removeWhere((item) =>
            (((item.child as Row?)!.children[1] as Padding?)!.child as Text?)!
                .data ==
            "Cancelar orden");

        break;
      case "Finalizado":
        lista.removeRange(0, 3);
        lista.removeAt(0);
        break;
      case "Cancelado":
        lista.removeRange(1, 4);

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
                  // _formatFolio
                  ("${orden["id"]}"),
                  "Eliminar",
                  () async {
                    // _deleteData(orden["id"]);
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

  void _filtrarListaSegunTexto(String searchText) async {
    if (searchText.isEmpty) {
      setState(() {
        _filteredOrdenes = _allOrdersData;
      });
      return;
    }

    setState(() {
      _filteredOrdenes = _allOrdersData.where((orden) {
        return orden["id"].toString().toLowerCase().contains(searchText.toLowerCase()) ||
            orden["estatus"]
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase()) ||
            orden["clienteNombre"]
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase()) ||
            orden["clienteContacto"]
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase()) ||
            orden["unidadNumEco"]
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase()) ||
            orden["unidadKilometros"]
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase()) ||
            orden["unidadMarca"]
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase()) ||
            orden["unidadModelo"]
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase()) ||
            orden["unidadHorasMotor"]
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase()) ||
            orden["unidadTipo"]
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase()) ||
            orden["unidadMotor"]
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase()) ||
            orden["unidadSerie"]
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase()) ||
            orden["unidadPlacas"]
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase()) ||
            orden["unidadYear"]
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase()) ||
            orden["unidadVin"]
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase()) ||
            orden["fechaLlegada"]
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase()) ||
            orden["fechaSalida"]
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase()) ||
            orden["tecnicoAsignado"]
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase()) ||
            orden["numeroCaso"]
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase()) ||
            orden["clienteComentario"]
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase()) ||
            orden["diagnostico"]
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase()) ||
            orden["trabajoRealizado"]
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase()) ||
            orden["costo"]
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase()) ||
            orden["createdAt"]
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase());

        // return orden.entries.contains(searchText.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Busqueda"),
        backgroundColor: Colors.blue.shade900,
        foregroundColor: Colors.white,
        shadowColor: Colors.black,
        elevation: 2,
        actions: [
          Container(
            // color: Colors.white,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            width: 550,
            // height: 50,
            child: TextField(
              controller: _busquedaController,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: Theme.of(context).primaryColorDark,
                ),
                suffixIcon: IconButton(
                    icon: Icon(
                      Icons.clear_rounded,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      _busquedaController.text = "";
                      _filtrarListaSegunTexto("");
                      // _filterLogListBySearchText("");
                    }),
                hintText: "Escribir Aqui",
                border: InputBorder.none,
              ),
              onChanged: (text) {
                _filtrarListaSegunTexto(text);
                print(
                    'First text field: ${_busquedaController.text} (${_busquedaController.text.characters.length})');
              },
              onSubmitted: (value) => _filtrarListaSegunTexto(value),
            ),
          ),
          addHorizontalSpace(25)
        ],
      ),
      body: Expanded(
        child: Scrollbar(
            controller: scrollControllerThree,
            child: ListView.builder(
              // reverse: ordenAscendete,
              controller: scrollControllerThree,
              padding: const EdgeInsets.only(right: 15),
              itemCount: _filteredOrdenes.length,
              itemBuilder: (context, index) {
                final orden = _filteredOrdenes.elementAt(index);
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
                            // _formatFolio
                            ("${orden["id"]}"),
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
                      // showFullOrder(orden["id"]);
                    },
                    trailing: PopupMenuButton(
                      tooltip: ("Opciones"),
                      itemBuilder: (context) => listaPopItem(orden),
                    ),
                  ),
                );
              },
            )),
      ),
    );
  }
}

String parseString(String? value) {
  if (value == null) {
    return "Valor Nulo";
  } else if (value == "") {
    return "_________";
  }
  return value.toString();
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
