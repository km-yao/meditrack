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

}