// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE data(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
        estatus TEXT,
        clienteNombre TEXT,
        clienteContacto TEXT, 
        unidadNumEco TEXT,
        unidadKilometros TEXT,
        unidadMarca TEXT, 
        unidadModelo TEXT,
        unidadHorasMotor TEXT,
        unidadTipo TEXT,
        unidadMotor TEXT,
        unidadSerie TEXT,
        unidadPlacas TEXT,
        unidadYear TEXT,
        unidadVin TEXT,
        fechaLlegada TEXT,
        fechaSalida TEXT,
        tecnicoAsignado TEXT,
        numeroCaso TEXT,
        clienteComentario TEXT,
        diagnostico TEXT,
        trabajoRealizado TEXT,
        costo TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP)""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase("database_name.db", version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<int> createData(
    String? estatus,
    String? clienteNombre,
    String? clienteContacto,
    String? unidadNumEco,
    String? unidadKilometros,
    String? unidadMarca,
    String? unidadModelo,
    String? unidadHorasMotor,
    String? unidadTipo,
    String? unidadMotor,
    String? unidadSerie,
    String? unidadPlacas,
    String? unidadYear,
    String? unidadVin,
    String? fechaLlegada,
    String? fechaSalida,
    String? tecnicoAsignado,
    String? numeroCaso,
    String? clienteComentario,
    String? diagnostico,
    String? trabajoRealizado,
    String? costo,
  ) async {
    final db = await SQLHelper.db();
    final data = {
      'estatus': estatus,
      'clienteNombre': clienteNombre,
      'clienteContacto': clienteContacto,
      'unidadNumEco': unidadNumEco,
      'unidadKilometros': unidadKilometros,
      'unidadMarca ': unidadMarca,
      'unidadModelo': unidadModelo,
      'unidadHorasMotor': unidadHorasMotor,
      'unidadTipo': unidadTipo,
      'unidadMotor': unidadMotor,
      'unidadSerie': unidadSerie,
      'unidadPlacas': unidadPlacas,
      'unidadYear': unidadYear,
      'unidadVin': unidadVin,
      'fechaLlegada': fechaLlegada,
      'fechaSalida': fechaSalida,
      'tecnicoAsignado': tecnicoAsignado,
      'numeroCaso': numeroCaso,
      'clienteComentario': clienteComentario,
      'diagnostico': diagnostico,
      'trabajoRealizado': trabajoRealizado,
      'costo': costo,
    };
    final id = await db.insert('data', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);

    return id;
  }

  static Future<List<Map<String, dynamic>>> getAllData() async {
    final database = await SQLHelper.db();
    return database.query('data', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getSingleData(int id) async {
    final db = await SQLHelper.db();
    return db.query('data', where: 'id = ?', whereArgs: [id], limit: 1);
  }

  static Future<int> updateData(
    int id,
    String? estatus,
    String? clienteNombre,
    String? clienteContacto,
    String? unidadNumEco,
    String? unidadKilometros,
    String? unidadMarca,
    String? unidadModelo,
    String? unidadHorasMotor,
    String? unidadTipo,
    String? unidadMotor,
    String? unidadSerie,
    String? unidadPlacas,
    String? unidadYear,
    String? unidadVin,
    String? fechaLlegada,
    String? fechaSalida,
    String? tecnicoAsignado,
    String? numeroCaso,
    String? clienteComentario,
    String? diagnostico,
    String? trabajoRealizado,
    String? costo,
  ) async {
    final db = await SQLHelper.db();
    final data = {
      'estatus': estatus,
      'clienteNombre': clienteNombre,
      'clienteContacto': clienteContacto,
      'unidadNumEco': unidadNumEco,
      'unidadKilometros': unidadKilometros,
      'unidadMarca ': unidadMarca,
      'unidadModelo': unidadModelo,
      'unidadHorasMotor': unidadHorasMotor,
      'unidadTipo': unidadTipo,
      'unidadMotor': unidadMotor,
      'unidadSerie': unidadSerie,
      'unidadPlacas': unidadPlacas,
      'unidadYear': unidadYear,
      'unidadVin': unidadVin,
      'fechaLlegada': fechaLlegada,
      'fechaSalida': fechaSalida,
      'tecnicoAsignado': tecnicoAsignado,
      'numeroCaso': numeroCaso,
      'clienteComentario': clienteComentario,
      'diagnostico': diagnostico,
      'trabajoRealizado': trabajoRealizado,
      'costo': costo,
      'createdAt': DateTime.now().toString()
    };
    final result =
        await db.update('data', data, where: 'id = ?', whereArgs: [id]);
    return result;
  }

  static Future<void> deleteData(int id, BuildContext context) async {
    final db = await SQLHelper.db();
    try {
      await db.delete('data', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(e.toString()),
        ),
      );
    }
  }
}
