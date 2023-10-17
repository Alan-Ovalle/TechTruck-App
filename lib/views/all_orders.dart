// ignore_for_file: use_build_context_synchronously

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:techtruck_v11/views/new_order.dart';
import 'package:techtruck_v11/widgets/db_helper.dart';
import 'package:techtruck_v11/widgets/helper_widgets.dart';

class AllOrders extends StatefulWidget {
  const AllOrders({Key? key}) : super(key: key);

  @override
  State<AllOrders> createState() => _AllOrdersState();
}

class _AllOrdersState extends State<AllOrders> {
  List<Map<String, dynamic>> _allData = [];
  bool _isLoading = true;

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
  final TextEditingController _unidadAno = TextEditingController();
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
    _unidadAno.clear();
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
        _unidadAno.text.isNotEmpty ||
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
        _unidadAno.text,
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
      _unidadAno.text,
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

  void showNewOrder(int? id) {
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
    );

    _refreshData();
  }

  void showBottomSheet(int? id) async {
    Map<String, dynamic> existingData = {};
    if (id != null) {
      existingData = _allData.firstWhere((element) => element["id"] == id);
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
      _unidadAno.text = existingData["unidadAno"];
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
                    controller: _diagnosticoController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Diagnostico",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ordenes de servicio"),
        centerTitle: true,
        actions: [
          ElevatedButton(
            onPressed: () {
              showNewOrder(null);
            },
            child: const Text("Nueva orden"),
          ),
          addHorizontalSpace(15),
          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(Icons.search),
          // ),
          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(Icons.filter_alt),
          // ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _allData.length,
              itemBuilder: (context, index) => Card(
                child: ListTile(
                  leading: Text(
                    "${_allData[index]["id"]}",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  minLeadingWidth: 20,
                  title: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child:
                          Text(parseString(_allData[index]["clienteNombre"]))),
                  subtitle: Text(parseString(_allData[index]["unidadNumEco"])),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.print),
                        color: Colors.blueGrey,
                      ),
                      IconButton(
                        onPressed: () {
                          showNewOrder(_allData[index]["id"]);
                        },
                        icon: const Icon(Icons.edit),
                        color: Colors.blue,
                      ),
                      IconButton(
                        onPressed: () {
                          _deleteData(_allData[index]["id"]);
                        },
                        icon: const Icon(Icons.delete_forever),
                        color: Colors.redAccent,
                      ),
                    ],
                  ),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showBottomSheet(null),
        child: const Icon(Icons.add),
      ),
    );
  }

  String parseString(String? value) {
    if (value == null) {
      return "Valor Nulo";
    }
    return value.toString();
  }
}
