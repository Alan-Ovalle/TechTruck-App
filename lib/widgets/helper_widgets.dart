// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const _defaultColor = Color(0xFF34568B);

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
    Key? key,
    required this.index,
    this.extent,
    this.backgroundColor,
    this.bottomSpace,
  }) : super(key: key);

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
    Key? key,
    required this.index,
    required this.width,
    required this.height,
  }) : super(key: key);

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
    Key? key,
    required this.index,
    this.extent,
    this.bottomSpace,
  }) : super(key: key);

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
    Map<TextEditingController, Map<String, int>> controllerList) {
  return TextField(
    controller: controllerList.keys.first,
    // maxLines: 6,
    // minLines: controllerList.values.last.values.first,
    maxLines: null,
    minLines: null,
    expands: true,
    keyboardType: TextInputType.text,
    textInputAction: TextInputAction.next,
    style: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    decoration: InputDecoration(
      isDense: true,
      contentPadding: const EdgeInsets.all(16),
      border: const OutlineInputBorder(),
      labelText: controllerList.values.first.keys.first,
    ),
  );
}

Widget expandMultiLineFieldTile(
    Map<TextEditingController, Map<String, int>> controllerList) {
  return CustomPaint(
    foregroundPainter: PagePainter(),
    child: TextField(
      controller: controllerList.keys.first,
      // maxLines: 6,
      // minLines: controllerList.values.last.values.first,
      textAlignVertical: TextAlignVertical.top,
      expands: true,
      maxLines: null,

      textAlign: TextAlign.justify,

      keyboardType: TextInputType.multiline,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.all(12),
        border: const OutlineInputBorder(),
        labelText: controllerList.values.first.keys.first,
      ),
    ),
  );
}

class PagePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintLine = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 1;

    for (var x = 34; x <= size.height; x += 34) {
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
    BuildContext context) {
  return TextField(
    controller: controllerList.keys.first,
    maxLines: null,
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
          initialDate: DateTime.now(),
          firstDate: DateTime(200),
          lastDate: DateTime(2100));

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
      borderRadius: BorderRadius.circular(5),
    ),
    child: Center(
      child: Text(titulo,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25,
            // fontWeight: FontWeight.bold,
          )),
    ),
  );
}
