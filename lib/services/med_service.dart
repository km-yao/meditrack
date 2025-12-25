import 'package:meditrack/models/api_db.dart';
import 'package:meditrack/models/med.dart';

class MedService {

  MedService();

  Future<List<Med>> getAll() async {
    try {
      List<Med> list = [];
      
      final response = await ApiDb().getAllMeds();
      if (response != []) { list = response; }
      
      return list;
    } catch (e) {
      throw Exception("MEDSERVICE.getALL : $e");
    }
  }

  Future<Med> insert(Med med) async {
    try {
      await ApiDb().insertMed(med);
      return med;
    } catch (e) {
      throw Exception("MEDSERVICE.insert : $e");
    }
  }

  Future<void> deleteAll() async {
    try {
      await ApiDb().deleteAllMeds();
    } catch (e) {
      throw Exception("MEDSERVICE.deleteALL : $e");
    }
  }

  Future<void> delete(int id) async {
    try {
      await ApiDb().deleteMed(id);
    } catch (e) {
      throw Exception("MEDSERVICE.delete : $e");
    }
  }

  Future<void> update(Med med) async {
    try {
      await ApiDb().updateMed(med);
    } catch (e) {
      throw Exception("MEDSERVICE.update : $e");
    }
  }

}