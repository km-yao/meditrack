import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:meditrack/models/med.dart';

class ApiDb {

  ApiDb() {
    WidgetsFlutterBinding.ensureInitialized();
    _initDatabase();
  }
  
  final String dbName = "meditrack.db";
  late final dynamic database;

  void _initDatabase() async {
    database = openDatabase(
      dbName,
      version: 2,
      onCreate: (db, version) async {
        // create tables if they don't exist
        await db.execute(
          "CREATE TABLE IF NOT EXISTS meds(" 
            "id INTEGER primary key,"
            "nome TEXT,"
            "compresse INTEGER,"
            "dosaggio TEXT,"
            "prelievo TEXT,"
            "scadenza TEXT"
          ");"
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        await db.execute(
          "CREATE TABLE IF NOT EXISTS meds(" 
            "id INTEGER primary key,"
            "nome TEXT,"
            "compresse INTEGER,"
            "dosaggio TEXT,"
            "prelievo TEXT,"
            "scadenza TEXT"
          ");"
        );
      },
    );
  }

  Future<List<Med>> getAllMeds() async {
    final db = await database;

    final List<Map<String, Object?>> medsMap = await db.query('meds');

    return [
      for (final {
        'id': id as int, 
        'nome': nome as String, 
        'compresse': compresse as int, 
        'dosaggio': dosaggio as String,
        'prelievo': prelievo as String,
        'scadenza': scadenza as String
        } in medsMap)
      Med(id: id, nome: nome, compresse: compresse, dosaggio: dosaggio, prelievo: DateTime.parse(prelievo), scadenza: DateTime.parse(scadenza) )
    ];
  }

  Future<Med> getMed(int id) async {
    final db = await database;

    final List<Map<String, Object?>> maps = await db.query('meds', where: 'id = ?', whereArgs: [id], limit: 1);

    if (maps.isEmpty) {
      throw Exception('Med not found: $id');
    }

    final row = maps.first;

    return Med(
      id: row['id'] as int,
      nome: row['nome'] as String,
      compresse: row['compresse'] as int,
      dosaggio: row['dosaggio'] as String,
      prelievo: DateTime.parse(row['prelievo'] as String),
      scadenza: DateTime.parse(row['scadenza'] as String)
    );
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


  Future<void> updateMed(Med med) async {
    final db = await database;

    await db.update(
      'meds',
      med.toMap(),
      where: 'id = ?',
      whereArgs: [med.id],
    );
  }
}