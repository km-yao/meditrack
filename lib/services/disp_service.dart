

import 'package:meditrack/models/api_db.dart';
import 'package:meditrack/models/disponibilita.dart';

class DispService {

  DispService();

  Future<List<Disponibilita>> getAll() async {
    try {
      List<Disponibilita> list = [];
      
      final response = await ApiDb().getAllDisponibilita();
      if (response != []) { list = response; }
      
      return list;
    } catch (e) {
      throw Exception("DISPSERVICE.getALL : $e");
    }
  }

  Future<Disponibilita> getDisponibilita(int id) async {
    try {
      final disponibilita = await ApiDb().getDisponibilita(id);
      return disponibilita;
    } catch (e) {
      throw Exception("DISPSERVICE.getDISPONIBILITA : $e");
    }
  }

  Future<void> insert(Disponibilita disponibilita) async {
    try {
      await ApiDb().insertDisponibilita(disponibilita);
    } catch (e) {
      throw Exception("DISPSERVICE.insert : $e");
    }
  }

  Future<void> deleteAll() async {
    try {
      await ApiDb().deleteAllDisponibilita();
    } catch (e) {
      throw Exception("DISPSERVICE.deleteALL : $e");
    }
  }

}