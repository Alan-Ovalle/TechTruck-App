import 'package:flutter/material.dart';
import 'package:techtruck_v11/views/orden_details.dart';
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

  void _refreshData() async {
    final data = await SQLHelper.getAllData();
    setState(() {
      _allData = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _addData() async {
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
    _refreshData();
  }

  Future<void> _updateData(int id) async {
    await SQLHelper.updateData(
      id,
      // _name.text,
      // _unit.text,
      // _driver.text,
      // _diagnostic.text,
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
    await SQLHelper.deleteData(id);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text("Orden eliminada"),
      ),
    );

    _refreshData();
  }

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

  void showBottomSheet(int? id) async {
    if (id != null) {
      print("ID $id");
      final existingData =
          _allData.firstWhere((element) => element["id"] == id);
      // _name.text = existingData["cliente"];
      // _unit.text = existingData["unidad"];
      // _driver.text = existingData["conductor"];
      // _diagnostic.text = existingData["diagnostico"];
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
                        // _name.clear();
                        // _unit.clear();
                        // _driver.clear();
                        // _diagnostic.clear();
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

                        Navigator.pop(context);
                        print("Data Added.");
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Text(
                          id == null ? "Agregar" : "Actualizar",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
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
        title: const Text("Todas las ordenes"),
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
                    // "${index + 1}",
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
                        icon: Icon(Icons.print),
                        color: Colors.blueGrey,
                      ),
                      IconButton(
                        onPressed: () {
                          showBottomSheet(_allData[index]["id"]);
                        },
                        icon: Icon(Icons.edit),
                        color: Colors.blue,
                      ),
                      IconButton(
                        onPressed: () {
                          _deleteData(_allData[index]["id"]);
                        },
                        icon: Icon(Icons.delete_forever),
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
