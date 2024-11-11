import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:techtruck_v11/model/datos_cliente.dart';
import 'package:techtruck_v11/model/datos_unidad.dart';
import 'package:techtruck_v11/model/orden_servicio.dart';
import 'package:techtruck_v11/widgets/db_helper.dart';

Future<void> demoOrders(
  int numOrders,
  VoidCallback funcion,
) async {
  List<OrdenServicio> ordenesDemo = [];

  var i = 0;
  while (i < numOrders) {
    // ordenesDemo.add(crearOrdenFalsa());
    await SQLHelper.createData(
      "Pendiente",
      _addDemoNombre(),
      _addDemoTelefono(),
      _addDemoNumEco(),
      _addKilometros(),
      _addMarca(),
      _addModelo(),
      _addHorasMotor(),
      _addTipo(),
      _addMotor(),
      _addSerieMotor(),
      _addPlacas(),
      _addYear(),
      _addVIN(),
      _addFechaLlegada(),
      // "",
      "",
      _addTecnico(),
      "",
      _addComentario(),
      "",
      "",
      "",
    );

    funcion();

    i++;
  }
}

OrdenServicio crearOrdenFalsa() {
  OrdenServicio tempOrden = OrdenServicio(
    cliente: DatosCliente(
      nombre: _addDemoNombre(),
      contacto: _addDemoTelefono(),
      comentario: _addComentario(),
    ),
    unidad: DatosUnidad(
      numeroEconomico: _addDemoNumEco(),
      marca: _addMarca(),
      modelo: _addModelo(),
      motor: _addMotor(),
      placas: _addPlacas(),
      kilometros: _addKilometros(),
      horasMotor: _addHorasMotor(),
      tipo: _addTipo(),
      serieMotor: _addSerieMotor(),
      year: _addYear(),
      vin: _addVIN(),
    ),
    detallesOrden: OrdenServicioInfo(
      folio: "999999",
      fechaLlegada: _addFechaLlegada(),
      fechaSalida: "",
      tecnicoAsignado: _addTecnico(),
      numeroCaso: "",
      diagnostico: "",
    ),
    trabajoRealizado: [
      OrdenServicioItem(
        descripcion: "",
        costo: "",
      )
    ],
  );
  return tempOrden;
}

List<String> listNombres = [
  'Ana',
  'Juan',
  'Luis',
  'Carlos',
  'Marta',
  'Pedro',
  'Sofía',
  'José',
  'Carmen',
  'Miguel',
  'Laura',
  'Daniel',
  'Lucía',
  'Jorge',
  'Paula',
  'María',
  'Antonio',
  'Raquel',
  'David',
  'Sandra',
  'Sara',
  'Pablo',
  'Andrea',
  'Manuel',
  'Silvia',
  'Cristina',
  'Javier',
  'Teresa',
  'Roberto',
  'Patricia',
  'Elena',
  'Francisco',
  'Irene',
  'Rafael',
  'Nuria',
  'Alejandro',
  'Beatriz',
  'Guillermo',
  'Claudia',
  'Alberto',
  'Olga',
  'Fernando',
  'Julia',
  'Gonzalo',
  'Isabel',
  'Santiago',
  'Rocío',
  'Iván',
  'Natalia',
  'Álvaro'
];
List<String> listApellidos = [
  'García',
  'Martínez',
  'Rodríguez',
  'López',
  'Sánchez',
  'Pérez',
  'Gómez',
  'Martín',
  'Jiménez',
  'Ruiz',
  'Hernández',
  'Díaz',
  'Moreno',
  'Álvarez',
  'Muñoz',
  'Romero',
  'Alonso',
  'Gutiérrez',
  'Navarro',
  'Torres',
  'Domínguez',
  'Vázquez',
  'Ramos',
  'Gil',
  'Ramírez',
  'Serrano',
  'Blanco',
  'Molina',
  'Morales',
  'Suárez',
  'Ortega',
  'Delgado',
  'Castro',
  'Ortiz',
  'Rubio',
  'Marín',
  'Sanz',
  'Nuñez',
  'Iglesias',
  'Medina',
  'Garrido',
  'Cortés',
  'Castillo',
  'Santos',
  'Lozano',
  'Guerrero',
  'Cano',
  'Prieto',
  'Méndez',
  'Cruz'
];

String _addDemoNombre() {
  var demoNombre = listNombres[Random().nextInt(listNombres.length)];
  var demoApellido = listApellidos[Random().nextInt(listApellidos.length)];
  return "$demoNombre $demoApellido";
}

List<String> listTelefonos = [
  '(656) 123-4567',
  '(614) 234-5678',
  '+1 (915) 345-6789',
  '(656) 456-7890',
  '(614) 567-8901',
  '+1 (915) 678-9012',
  '(656) 789-0123',
  '(614) 890-1234',
  '+1 (915) 901-2345',
  '(656) 012-3456',
  '(614) 123-4567',
  '+1 (915) 234-5678',
  '(656) 345-6789',
  '(614) 456-7890',
  '+1 (915) 567-8901',
  '(656) 678-9012',
  '(614) 789-0123',
  '+1 (915) 890-1234',
  '(656) 901-2345',
  '(614) 012-3456',
  '+1 (915) 123-4567',
  '(656) 234-5678',
  '(614) 345-6789',
  '+1 (915) 456-7890',
  '(656) 567-8901',
  '(614) 678-9012',
  '+1 (915) 789-0123',
  '(656) 890-1234',
  '(614) 901-2345',
  '+1 (915) 012-3456',
  '(656) 123-4567',
  '(614) 234-5678',
  '+1 (915) 345-6789',
  '(656) 456-7890',
  '(614) 567-8901',
  '+1 (915) 678-9012',
  '(656) 789-0123',
  '(614) 890-1234',
  '+1 (915) 901-2345',
  '(656) 012-3456',
  '(614) 123-4567',
  '+1 (915) 234-5678',
  '(656) 345-6789',
  '(614) 456-7890',
  '+1 (915) 567-8901',
  '(656) 678-9012',
  '(614) 789-0123',
  '+1 (915) 890-1234',
  '(656) 901-2345',
  '(614) 012-3456'
];

String _addDemoTelefono() {
  var demoTelefono = listTelefonos[Random().nextInt(listTelefonos.length)];
  return demoTelefono;
}

List<String> listNumeros = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];

List<String> listAlfabeto = [
  'a',
  'b',
  'c',
  'd',
  'e',
  'f',
  'g',
  'h',
  'i',
  'j',
  'k',
  'l',
  'm',
  'n',
  'o',
  'p',
  'q',
  'r',
  's',
  't',
  'u',
  'v',
  'w',
  'x',
  'y',
  'z'
];

int random0or1() {
  return Random().nextInt(2);
}

String _addDemoNumEco() {
  int demoNumEco = Random().nextInt(500) + 1;
  bool agregarChar = false;
  String randomChar = "";

  if (random0or1() == 0) {
    agregarChar = true;
    randomChar =
        listAlfabeto[Random().nextInt(listAlfabeto.length)].toUpperCase();
  }

  if (agregarChar) {
    return "${randomChar.toUpperCase()}-${demoNumEco.toString()}";
  } else {
    return demoNumEco.toString();
  }
}

List<String> listMarcas = [
  'Volvo',
  'Freightliner',
  'Peterbilt',
  'Kenworth',
  'Mack',
  'International',
];

String _addMarca() {
  var demoMarca = listMarcas[Random().nextInt(listMarcas.length)];
  return demoMarca;
}

List<String> listModelos = [
  // Volvo
  'Volvo FH16', 'Volvo VNL', 'Volvo VNR', 'Volvo FMX', 'Volvo FM',

  // Freightliner
  'Freightliner Cascadia', 'Freightliner M2 106', 'Freightliner Coronado',
  'Freightliner Business Class M2', 'Freightliner 122SD',

  // International
  'International Lonestar', 'International ProStar', 'International LT Series',
  'International HV Series', 'International Durastar',

  // Mack
  'Mack Anthem', 'Mack Granite', 'Mack Pinnacle', 'Mack TerraPro', 'Mack LR',

  // Kenworth
  'Kenworth T680', 'Kenworth W900', 'Kenworth T880', 'Kenworth T370',
  'Kenworth K270',

  // Peterbilt
  'Peterbilt 579', 'Peterbilt 389', 'Peterbilt 567', 'Peterbilt 367',
  'Peterbilt 337'
];

String _addModelo() {
  return listModelos[Random().nextInt(listModelos.length)];
}

List<String> listMotor = [
  // Volvo
  'Volvo D13', 'Volvo D16', 'Volvo D11', 'Volvo D13TC', 'Volvo GH11',

  // Freightliner
  'Detroit DD13', 'Detroit DD15', 'Detroit DD16', 'Caterpillar C15',
  'Cummins ISX15',

  // International
  'Navistar N13', 'MaxxForce 13', 'MaxxForce DT', 'International VT 365',
  'International HT 570',

  // Mack
  'Mack MP8', 'Mack MP10', 'Mack E7', 'Mack MP7', 'Mack D13',

  // Kenworth
  'PACCAR MX-13', 'PACCAR MX-11', 'Cummins ISX15', 'Cummins ISX12',
  'Caterpillar C15',

  // Peterbilt
  'PACCAR MX-13', 'PACCAR MX-11', 'Cummins ISX15', 'Cummins ISX12',
  'Caterpillar C15'
];

String _addMotor() {
  return listMotor[Random().nextInt(listMotor.length)];
}

String _addPlacas() {
  String demoPlaca = "";
  if (random0or1() == 0) {
    demoPlaca =
        "$demoPlaca${listAlfabeto[Random().nextInt(listAlfabeto.length)].toUpperCase()}";
  } else {
    demoPlaca =
        "$demoPlaca${listNumeros[Random().nextInt(listNumeros.length)]}";
  }
  if (random0or1() == 0) {
    demoPlaca =
        "$demoPlaca${listAlfabeto[Random().nextInt(listAlfabeto.length)].toUpperCase()}";
  } else {
    demoPlaca =
        "$demoPlaca${listNumeros[Random().nextInt(listNumeros.length)]}";
  }
  if (random0or1() == 0) {
    demoPlaca =
        "$demoPlaca${listAlfabeto[Random().nextInt(listAlfabeto.length)].toUpperCase()}";
  } else {
    demoPlaca =
        "$demoPlaca${listNumeros[Random().nextInt(listNumeros.length)]}";
  }
  demoPlaca = "$demoPlaca-";
  if (random0or1() == 0) {
    demoPlaca =
        "$demoPlaca${listAlfabeto[Random().nextInt(listAlfabeto.length)].toUpperCase()}";
  } else {
    demoPlaca =
        "$demoPlaca${listNumeros[Random().nextInt(listNumeros.length)]}";
  }
  if (random0or1() == 0) {
    demoPlaca =
        "$demoPlaca${listAlfabeto[Random().nextInt(listAlfabeto.length)].toUpperCase()}";
  } else {
    demoPlaca =
        "$demoPlaca${listNumeros[Random().nextInt(listNumeros.length)]}";
  }
  if (random0or1() == 0) {
    demoPlaca =
        "$demoPlaca${listAlfabeto[Random().nextInt(listAlfabeto.length)].toUpperCase()}";
  } else {
    demoPlaca =
        "$demoPlaca${listNumeros[Random().nextInt(listNumeros.length)]}";
  }
  if (random0or1() == 0) {
    demoPlaca =
        "$demoPlaca${listAlfabeto[Random().nextInt(listAlfabeto.length)].toUpperCase()}";
  } else {
    demoPlaca =
        "$demoPlaca${listNumeros[Random().nextInt(listNumeros.length)]}";
  }
  return demoPlaca;
}

String _addKilometros() {
  int km = Random().nextInt(625000) + 25000;
  return km.toString();
}

String _addHorasMotor() {
  int km = Random().nextInt(925000) + 35000;
  return km.toString();
}

List<String> listTipo = [
  'Tracto',
  'Plataforma',
  'Cisterna',
  'Frigorífico',
  'Caja cerrada',
  'Articulado',
  'Contenedor',
  'Reparto',
  'Carga liviana',
  'Madrina'
];

String _addTipo() {
  return listTipo[Random().nextInt(listTipo.length)];
}

String _addSerieMotor() {
  return {Random().nextInt(90000000) + 10000000}
      .toString()
      .replaceAll('{', '')
      .replaceAll('}', '');
}

String _addYear() {
  return {Random().nextInt(35) + 1990}
      .toString()
      .replaceAll('{', '')
      .replaceAll('}', '');
}

String _addVIN() {
  var caracteresPermitidos = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';

  // Generar un VIN de 17 caracteres
  String vin = '';
  for (int i = 0; i < 17; i++) {
    vin += caracteresPermitidos[Random().nextInt(caracteresPermitidos.length)];
  }

  return vin;
}

String _addFechaLlegada() {
  Random random = Random();

  // Generar un año aleatorio entre 2018 y 2024
  int year = random.nextInt(7) + 2018;

  // Generar un mes aleatorio entre 1 y 12
  int mes = random.nextInt(12) + 1;

  // Generar un dia aleatorio dentro del rango de dias del mes generado
  int dia;
  if (mes == 2) {
    // Verificar si el año es bisiesto en febrero
    bool esBisiesto = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
    dia = random.nextInt(esBisiesto ? 29 : 28) + 1;
  } else if ([4, 6, 9, 11].contains(mes)) {
    // Para los meses de 30 días
    dia = random.nextInt(30) + 1;
  } else {
    // Para los meses de 31 días
    dia = random.nextInt(31) + 1;
  }
  var localeTemp = Locale('es', 'MX');

  return DateFormat(
    "dd/MMM/yy",
    localeTemp.toString(),
  ).format(DateTime(year, mes, dia));
}

List<String> listTecnicos = [
  'Mario',
  'David',
  'José',
  'Luis',
  'Ivan',
  'Juan',
  'Pedro',
  'Jorge',
  'Fernando',
  'Santiago'
];

String _addTecnico() {
  return listTecnicos[Random().nextInt(listTecnicos.length)];
}

List<String> listComentario = [
  'Problemas en el motor',
  'Fallos de encendido',
  'Pérdida de potencia',
  'Exceso de humo',
  'Fugas de aceite',
  'Fugas de combustible',
  'Frenos defectuosos',
  'Desgaste de las pastillas de freno',
  'Problemas con el sistema de frenos neumáticos',
  'Problemas con el sistema de frenos hidráulicos',
  'Fugas en el sistema de frenos',
  'Problemas en la transmisión',
  'Dificultad para cambiar de marcha',
  'Ruidos extraños al cambiar de marcha',
  'Deslizamiento de la transmisión',
  'Fugas de líquido (aceite, refrigerante, combustible)',
  'Fugas de aceite en el motor',
  'Fugas en las mangueras del sistema de refrigeración',
  'Neumáticos desgastados o dañados',
  'Desgaste irregular de los neumáticos',
  'Sistema eléctrico defectuoso',
  'Fallos en el sistema de arranque',
  'Mal funcionamiento de las baterías o alternadores',
  'Problemas con el sistema de suspensión',
  'Ruido al conducir, especialmente en terrenos irregulares',
  'Sobrecalentamiento del motor',
  'Fallo en el termostato o radiador',
  'Obstrucción en las mangueras de refrigeración',
  'Nivel bajo de líquido refrigerante',
  'Ruidos extraños o vibraciones al girar el volante',
  'Dificultad para girar el volante',
  'Fugas en el sistema hidráulico de dirección',
  'Problemas con el sistema de escape',
  'Fugas en el sistema de escape',
  'Filtro de catalizador obstruido',
  'Filtro de partículas obstruido',
  'Ruidos excesivos provenientes del escape',
  'Reemplazo de filtros',
  'Fallas en el sistema de climatización',
  'Aire acondicionado o calefacción que no funciona correctamente',
  'Alineación y balanceo',
  'Desgaste irregular o vibración en las ruedas debido a una mala alineación',
  'Cancelación de post tratamiento'
];

String _addComentario() {
  return listComentario[Random().nextInt(listComentario.length)];
}
