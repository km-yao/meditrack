import 'package:flutter/material.dart';
import 'package:meditrack/models/disponibilita.dart';
import 'package:sqflite/sqflite.dart';
import 'package:meditrack/models/med.dart';

class ApiDb {

  ApiDb() {
    WidgetsFlutterBinding.ensureInitialized();
    _initDatabase();
  }
  
  final String dbName = "meditrackdb.db";
  late final dynamic database;

  void _initDatabase() async {
    database = openDatabase(
      dbName,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE meds(" 
            "id INTEGER primary key,"
            "nome TEXT,"
            "compresse INTEGER,"
            "dosaggio TEXT"
          ");"
          "CREATE TABLE disponibilita("
            "id INTEGER primary key,"
            "prelievo TEXT,"
            "scandenza TEXT"
          ");"
        );
      },
      version: 1
    );
  }

  Future<List<Med>> getAllMeds() async {
    final db = await database;

    final List<Map<String, Object?>> medsMap = await db.query('meds');

    return [
      for (final {'id': id as int, 'nome': nome as String, 'compresse': compresse as int, 'dosaggio': dosaggio as String} in medsMap)
      Med(id: id, nome: nome, compresse: compresse, dosaggio: dosaggio)
    ];
  }

  Future<Med> getMed(int id) async {
    final db = await database;

    final Med med = db.query('meds', columns: ['id'], where: 'id = $id');

    return med;
  }

  Future<void> insertMed(Med med) async {
    final db = await database;

    await db.insert(
      'meds',
      med.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteMed(int id) async {
    final db = await database;

    await db.delete(
      'meds',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteAllMeds() async {
    final db = await database;

    await db.delete('meds');
  }

  Future<List<Disponibilita>> getAllDisponibilita() async {
    final db = await database;

    final List<Map<String, Object?>> disponibilitaMap = await db.query('disponibilita');

    return [
      for (final {'id': id as int, 'prelievo': prelievo as String, 'scadenza': scadenza as String} in disponibilitaMap)
      Disponibilita(id: id, prelievo: DateTime.parse(prelievo), scadenza: DateTime.parse(scadenza))
    ];
  }

  Future<Disponibilita> getDisponibilita(int id) async {
    final db = await database;

    final Disponibilita disponibilita = db.query('disponibilita', columns: ['id'], where: 'id = $id');

    return disponibilita;
  }

  Future<void> insertDisponibilita(Disponibilita disponibilita) async {
    final db = await database;

    await db.insert(
      'disponibilita',
      disponibilita.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteDisponibilita(int id) async {
    final db = await database;

    await db.delete(
      'disponibilita',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteAllDisponibilita() async {
    final db = await database;

    await db.delete('disponibilita');
  }

  Future<void> updateDisponibilita(Disponibilita disponibilita) async {
    final db = await database;

    await db.update(
      'disponibilita',
      disponibilita.toMap(),
      where: 'id = ?',
      whereArgs: [disponibilita.id],
    );
  }
}