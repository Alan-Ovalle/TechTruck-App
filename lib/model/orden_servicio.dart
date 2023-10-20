import 'package:techtruck_v11/model/datos_cliente.dart';
import 'package:techtruck_v11/model/datos_unidad.dart';

class OrdenServicio {
  final DatosCliente? cliente;
  final DatosUnidad? unidad;
  final OrdenServicioInfo? detallesOrden;
  final List<OrdenServicioItem?> trabajoRealizado;

  const OrdenServicio({
    required this.unidad,
    required this.cliente,
    required this.detallesOrden,
    required this.trabajoRealizado,
  });
}

class OrdenServicioInfo {
  final String? folio;
  final String? fechaLlegada;
  final String? fechaSalida;
  final String? tecnicoAsignado;
  final String? numeroCaso;
  final String? diagnostico;

  const OrdenServicioInfo({
    required this.folio,
    required this.fechaLlegada,
    required this.fechaSalida,
    required this.tecnicoAsignado,
    required this.numeroCaso,
    required this.diagnostico,
  });
}

class OrdenServicioItem {
  final String? descripcion;
  final double? costo;

  const OrdenServicioItem({
    required this.descripcion,
    required this.costo,
  });
}

List<OrdenServicio> listOrderEjemplo = [
  const OrdenServicio(
    unidad: DatosUnidad(
      numeroEconomico: "12",
      marca: "Volvo",
      modelo: "Mack 1",
      motor: "Cummins",
      placas: "123-ASD-12",
      kilometros: "75896",
      horasMotor: "36412",
      tipo: "Tratco",
      serieMotor: "789456123",
      year: "2013",
      vin: "QQWERTYUIOP123456789",
    ),
    cliente: DatosCliente(
      nombre: "Juan Perez",
      contacto: "656-7894563",
      comentario: "Le falta poder en las subidas",
    ),
    detallesOrden: OrdenServicioInfo(
      folio: "00012",
      fechaLlegada: "16/Oct/2023",
      fechaSalida: "",
      tecnicoAsignado: "Juan Perez",
      numeroCaso: "123456",
      diagnostico: "Falta de potencia",
    ),
    trabajoRealizado: [
      OrdenServicioItem(
        descripcion: "Mantenimiento de motor",
        costo: 9500,
      ),
      OrdenServicioItem(
        descripcion: "Cambio de aceite",
        costo: 4200,
      ),
    ],
  )
];
