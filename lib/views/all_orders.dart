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
      _name.text,
      _unit.text,
      _driver.text,
      _diagnostic.text,
    );
    _refreshData();
  }

  Future<void> _updateData(int id) async {
    await SQLHelper.updateData(
      id,
      _name.text,
      _unit.text,
      _driver.text,
      _diagnostic.text,
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

  final TextEditingController _name = TextEditingController();
  final TextEditingController _unit = TextEditingController();
  final TextEditingController _driver = TextEditingController();
  final TextEditingController _diagnostic = TextEditingController();

  void showBottomSheet(int? id) async {
    if (id != null) {
      print("ID $id");
      final existingData =
          _allData.firstWhere((element) => element["id"] == id);
      _name.text = existingData["cliente"];
      _unit.text = existingData["unidad"];
      _driver.text = existingData["conductor"];
      _diagnostic.text = existingData["diagnostico"];
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
                    controller: _name,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Nombre del cliente",
                    ),
                  ),
                  addVerticalSpace(10),
                  TextField(
                    controller: _unit,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "No. Economico",
                    ),
                  ),
                  addVerticalSpace(10),
                  TextField(
                    controller: _driver,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Nombre del conductor",
                    ),
                  ),
                  addVerticalSpace(10),
                  TextField(
                    controller: _diagnostic,
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
                        _name.clear();
                        _unit.clear();
                        _driver.clear();
                        _diagnostic.clear();

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
                      child: Text(parseString(_allData[index]["cliente"]))),
                  subtitle: Text(parseString(_allData[index]["unidad"])),
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
