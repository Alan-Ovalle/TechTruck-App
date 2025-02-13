// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:techtruck_v11/widgets/db_helper.dart';
import 'package:techtruck_v11/widgets/demo_orden.dart';

const _defaultColor = Color(0xFF34568B);

const String _passwordDev = "0413";

// class AppScaffold extends StatelessWidget {
//   final String title;
//   final Widget child;
//   final double topPadding;

//   const AppScaffold({
//     Key? key,
//     required this.title,
//     required this.child,
//     this.topPadding = 0,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//       ),
//       body: Padding(
//         padding: EdgeInsets.only(top: topPadding),
//         child: child,
//       ),
//     );
//   }
// }

class Tile extends StatelessWidget {
  const Tile({
    super.key,
    required this.index,
    this.extent,
    this.backgroundColor,
    this.bottomSpace,
  });

  final int index;
  final double? extent;
  final double? bottomSpace;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final child = Container(
      color: backgroundColor ?? _defaultColor,
      height: extent,
      child: Center(
        child: CircleAvatar(
          minRadius: 20,
          maxRadius: 20,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          child: Text('$index', style: const TextStyle(fontSize: 20)),
        ),
      ),
    );

    if (bottomSpace == null) {
      return child;
    }

    return Column(
      children: [
        Expanded(child: child),
        Container(
          height: bottomSpace,
          color: Colors.green,
        )
      ],
    );
  }
}

class ImageTile extends StatelessWidget {
  const ImageTile({
    super.key,
    required this.index,
    required this.width,
    required this.height,
  });

  final int index;
  final int width;
  final int height;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      'https://picsum.photos/$width/$height?random=$index',
      width: width.toDouble(),
      height: height.toDouble(),
      fit: BoxFit.cover,
    );
  }
}

class InteractiveTile extends StatefulWidget {
  const InteractiveTile({
    super.key,
    required this.index,
    this.extent,
    this.bottomSpace,
  });

  final int index;
  final double? extent;
  final double? bottomSpace;

  @override
  _InteractiveTileState createState() {
    return _InteractiveTileState();
  }
}

class _InteractiveTileState extends State<InteractiveTile> {
  Color color = _defaultColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (color == _defaultColor) {
            color = Colors.red;
          } else {
            color = _defaultColor;
          }
        });
      },
      child: Tile(
        index: widget.index,
        extent: widget.extent,
        backgroundColor: color,
        bottomSpace: widget.bottomSpace,
      ),
    );
  }
}

Widget addVerticalSpace(double height) {
  return SizedBox(
    height: height,
  );
}

Widget addHorizontalSpace(double width) {
  return SizedBox(
    width: width,
  );
}

TextField expandFieldTile(
  Map<TextEditingController, Map<String, int>> controllerList,
  bool? isReadOnly,
) {
  return TextField(
    readOnly: isReadOnly!,
    controller: controllerList.keys.first,
    // maxLines: 6,
    // minLines: controllerList.values.last.values.first,
    maxLines: 1,
    minLines: 1,
    // expands: true,

    keyboardType: TextInputType.text,
    textInputAction: TextInputAction.next,
    style: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    decoration: InputDecoration(
      isDense: true,
      contentPadding: const EdgeInsets.all(20),
      border: const OutlineInputBorder(),
      labelText: controllerList.values.first.keys.first,
    ),
  );
}

Widget expandMultiLineFieldTile(
    bool? isReadOnly,
    int? renglonBox,
    int renglonString,
    int primeraLinea,
    int spanLinea,
    Map<TextEditingController, Map<String, int>> controllerList) {
  return CustomPaint(
    foregroundPainter: PagePainter(
      primeraLinea: primeraLinea,
      spanLinea: spanLinea,
    ),
    child: TextField(
      readOnly: isReadOnly!,
      controller: controllerList.keys.first,
      textAlignVertical: TextAlignVertical.top,
      maxLines: renglonBox,
      minLines: renglonBox,
      inputFormatters: [
        TextInputFormatter.withFunction((oldValue, newValue) {
          int newLines = newValue.text.split('\n').length;
          if (newLines > renglonString) {
            return oldValue;
          } else {
            return newValue;
          }
        }),
      ],
      textAlign: TextAlign.justify,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.all(10),
        border: const OutlineInputBorder(),
        labelText: controllerList.values.first.keys.first,
      ),
    ),
  );
}

class PagePainter extends CustomPainter {
  const PagePainter({
    required this.primeraLinea,
    required this.spanLinea,
  });

  final int primeraLinea, spanLinea;

  @override
  void paint(Canvas canvas, Size size) {
    final paintLine = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 1;

    for (var x = primeraLinea; x <= size.height; x += spanLinea) {
      canvas.drawLine(
          Offset(0, x.toDouble()), Offset(size.width, x.toDouble()), paintLine);
    }
  }

  @override
  bool shouldRepaint(PagePainter oldDelegate) {
    return false;
  }
}

TextField dateFieldTile(
  Map<TextEditingController, Map<String, int>> controllerList,
  BuildContext context,
  bool? isReadOnly,
) {
  return TextField(
    readOnly: isReadOnly!,
    controller: controllerList.keys.first,
    maxLines: 1,
    minLines: null,
    expands: false,
    keyboardType: TextInputType.multiline,
    style: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    decoration: InputDecoration(
      prefixIcon: const Icon(Icons.calendar_today),
      iconColor: Colors.grey.shade400,
      isDense: true,
      contentPadding: const EdgeInsets.all(16),
      border: const OutlineInputBorder(),
      hintText: controllerList.values.first.keys.first,
    ),
    onTap: () async {
      DateTime? fechaSeleccion = await showDatePicker(
          context: context,
          locale: const Locale('es', 'MX'),
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
          cancelText: "Cancelar",
          confirmText: "Aceptar",
          errorFormatText: "Formato de fecha incorrecto",
          barrierDismissible: true,
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.fallback().copyWith(
                colorScheme: ColorScheme.fromSwatch(
                  primarySwatch: Colors.blue,
                  accentColor: Colors.blueAccent,
                  // backgroundColor: Colors.red,
                  cardColor: const Color.fromARGB(255, 228, 234, 239),
                  errorColor: Colors.red,
                  brightness: Brightness.light,
                ),
              ),
              child: child!,
            );
          });

      if (fechaSeleccion != null) {
        controllerList.keys.first.text =
            DateFormat("dd/MMM/yy").format(fechaSeleccion);
      }
    },
  );
}

Widget tituloTile(String titulo) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      // color: Palette.dark,
      color: Colors.blue.shade500,
      // color: Colors.black54,

      borderRadius: BorderRadius.circular(5),
    ),
    child: Center(
      child: Text(titulo,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          )),
    ),
  );
}

Widget customCambiarEstadoDialog(
  BuildContext context,
  String? id,
  String? mensaje,
  Function accion,
  Color color,
) {
  return AlertDialog(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: "Folio: ",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: id!,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    content: mensaje != "Eliminar"
        ? Text(
            '¿Desea marcar esta orden como "$mensaje"?',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          )
        : const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '¿Desea eliminar permanentemente todas las ordenes?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Esta accion no se puede deshacer.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
    actionsAlignment: MainAxisAlignment.spaceEvenly,
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context, false),
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.grey.shade600,
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          minimumSize: const Size(120, 40),
        ),
        child: const Text('Regresar'),
      ),
      TextButton(
        onPressed: () {
          accion();
        },
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: color,
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          minimumSize: const Size(120, 40),
        ),
        child: const Text('Aceptar'),
      ),
    ],
  );
}

Widget dialogDev() {
  return AlertDialog(
    title: Text("No no no no"),
    content: Text("Wrong."),
  );
}

Widget customAgregarOrdenDemoDialog(
  BuildContext context,
  Function accion,
  VoidCallback funcion,
  bool demoTest,
  VoidCallback deleteFuncion,
) {
  TextEditingController controlador = TextEditingController();
  TextEditingController controladorDev = TextEditingController();

  return AlertDialog(
    title: Center(
      child: Text(
        "Agregar ordenes de demostración:",
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    ),
    backgroundColor: Colors.blue.shade900,
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          // height: 35,
          width: 330,
          child: TextField(
            controller: controladorDev,
            onChanged: (context) {
              // debugPrint(controladorDev.text.toString());
              // debugPrint("Contraseña es: $_passwordDev");
              // debugPrint(
              //     "Son iguales? : ${controladorDev.text.toString() == _passwordDev}");
            },
            keyboardType: TextInputType.number,
            obscureText: true,
            decoration: InputDecoration(
                fillColor: Colors.white,
                border: const OutlineInputBorder(),
                filled: true,
                // floatingLabelStyle: TextStyle(
                //     color: Colors.blue.shade900, fontWeight: FontWeight.bold),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Color.fromRGBO(13, 71, 161, 1),
                )),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: (Colors.blue[900])!,
                  ),
                ),
                hintText: "Contraseña",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                )),
          ),
        ),
        addVerticalSpace(15),
        Container(
          padding: EdgeInsets.fromLTRB(15, 5, 15, 10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(7)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Elija una opción:',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),

              addVerticalSpace(20),
              SizedBox(
                width: 300,
                child: TextButton(
                  onPressed: () async {
                    if (controladorDev.text.toString() == _passwordDev) {
                      Navigator.pop(context, false);
                      demoOrders(150, funcion, true);
                    } else {
                      final result = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return dialogDev();
                        },
                      );
                      if (result == null || !result) {
                        return;
                      }
                    }
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue.shade900,
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    minimumSize: const Size(150, 40),
                  ),
                  child: const Text('Agregar ordenes para pruebas'),
                ),
              ),
              addVerticalSpace(20),
              SizedBox(
                width: 300,
                child: TextButton(
                  onPressed: () async {
                    if (controladorDev.text.toString() == _passwordDev) {
                      Navigator.pop(context, false);
                      accion();
                    } else {
                      final result = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return dialogDev();
                        },
                      );
                      if (result == null || !result) {
                        return;
                      }
                    }
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blueAccent,
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    minimumSize: const Size(120, 40),
                  ),
                  child: const Text('Agregar orden vacia'),
                ),
              ),
              addVerticalSpace(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    // height: 35,
                    width: 100,
                    child: TextField(
                      controller: controlador,
                      onChanged: (context) {},
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Color.fromRGBO(13, 71, 161, 1),
                        )),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: (Colors.blue[900])!,
                          ),
                        ),
                        // hintText: "5",
                      ),
                    ),
                  ),
                  addHorizontalSpace(25),
                  TextButton(
                    onPressed: () async {
                      if (controladorDev.text.toString() == _passwordDev) {
                        Navigator.pop(context, false);
                        if (controlador.text.isNotEmpty) {
                          int numOrdenes = int.parse(controlador.text);
                          //Enviar a funcion de creacion de ordenes de demostracion
                          demoOrders(numOrdenes, funcion, false);
                        }
                      } else {
                        final result = await showDialog<bool>(
                          context: context,
                          builder: (context) {
                            return dialogDev();
                          },
                        );
                        if (result == null || !result) {
                          return;
                        }
                      }
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green,
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      minimumSize: const Size(120, 40),
                    ),
                    child: const Text('Agregar cantidad'),
                  ),
                ],
              ),
              addVerticalSpace(20),
              SizedBox(
                width: 300,
                child: TextButton(
                  onPressed: () async {
                    if (controladorDev.text.toString() == _passwordDev) {
                      final result = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return customCambiarEstadoDialog(
                            context,
                            "TODOS",
                            "Eliminar",
                            () async {
                              SQLHelper.deleteTableData(context);
                              Navigator.pop(context, true);
                              Navigator.pop(context, true);
                              deleteFuncion();
                            },
                            Colors.red,
                          );
                        },
                      );
                      if (result == null || !result) {
                        return;
                      }
                    } else {
                      final result = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return dialogDev();
                        },
                        barrierDismissible: false,
                      );
                      if (result == null || !result) {
                        return;
                      }
                    }
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.redAccent,
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    minimumSize: const Size(150, 40),
                  ),
                  child: const Text('Eliminar todas las ordenes'),
                ),
              ),
              // addVerticalSpace(20),
            ],
          ),
        ),
      ],
    ),
    actionsAlignment: MainAxisAlignment.spaceEvenly,
    actions: [
      SizedBox(
        width: 320,
        child: TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.lightBlue.shade700,
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            minimumSize: const Size(120, 40),
          ),
          child: const Text('Regresar'),
        ),
      ),
    ],
  );
}

Widget colorSizedBox(double? h, double? w, Color? c, Widget d) {
  return SizedBox(
    height: h,
    width: w,
    child: Container(
      color: c,
      child: d,
    ),
  );
}

Widget newOrderCard(
  String folio,
  Color colorEstatus,
  String textoEstatus,
  String textoCliente,
  String textoComentario,
  String textoFecha,
  String textoNumEco,
  String textoMarca,
  String textoTipo,
  Function onTapFuncion,
  Widget popupButton,
) {
  return Card(
    color: Colors.grey.shade800,
    elevation: 4,
    clipBehavior: Clip.hardEdge,
    margin: const EdgeInsets.fromLTRB(10, 5, 25, 5),
    shape: RoundedRectangleBorder(
        side: BorderSide(
          width: 3,
          color: Colors.grey.shade800,
        ),
        borderRadius: BorderRadius.all(Radius.circular(10))),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 160,
          height: 90,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 4),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade700,
                    ),
                    child: Text(
                      folio,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    )),
              ),
              Divider(
                height: 2,
                thickness: 2,
                color: Colors.grey.shade800,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,

                  // margin: EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade200,
                  ),
                  child: Center(
                    child: Text(
                      textoFecha,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Divider(
                height: 2,
                thickness: 2,
                color: Colors.grey.shade800,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(bottom: 2, top: 2),
                  decoration: BoxDecoration(
                    color: colorEstatus,
                  ),
                  child: Text(
                    textoEstatus,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        VerticalDivider(
          width: 4,
        ),
        Expanded(
          child: Container(
            color: Colors.blue.shade700,
            width: 120,
            height: 90,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(top: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Container(
                            color: Colors.grey.shade800,
                            width: 130,
                            height: double.infinity,
                            child: Text(
                              "Cliente: ",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Text(
                            "  $textoCliente",

                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            // textAlign: TextAlign.center,
                          ),
                        ],
                      )),
                ),
                Divider(
                  height: 2,
                  thickness: 2,
                  color: Colors.grey.shade800,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    width: double.infinity,

                    // margin: EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade200,
                    ),
                    child: Text(
                      textoFecha,
                      // textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Divider(
                  height: 2,
                  thickness: 2,
                  color: Colors.grey.shade800,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(bottom: 2, top: 5),
                    decoration: BoxDecoration(
                      color: colorEstatus,
                    ),
                    child: Text(
                      textoEstatus,
                      // textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(color: Colors.cyanAccent, child: popupButton),
      ],
    ),
  );
}

Widget oldOrderCard(
  String folio,
  Color colorEstatus,
  String textoEstatus,
  String textoCliente,
  String textoComentario,
  String textoFecha,
  String textoNumEco,
  String textoMarca,
  String textoTipo,
  Function onTapFuncion,
  Widget popupButton,
) {
  return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        horizontalTitleGap: 25,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Text(
                folio,
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
                  color: colorEstatus,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    width: 1.5,
                  ),
                ),
                width: 85,
                child: Center(
                  child: Text(
                    textoEstatus,
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
                        text: textoCliente,
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
                          text: textoComentario,
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
                        text: textoFecha,
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
                        text: textoNumEco,
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
                        text: textoMarca,
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
                        text: textoTipo,
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
          onTapFuncion();
        },
        trailing: popupButton,
      ));
}
