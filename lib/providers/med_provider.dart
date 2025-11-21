import 'package:flutter_riverpod/legacy.dart';
import 'package:meditrack/models/med.dart';
import 'package:meditrack/models/med_response.dart';
import 'package:meditrack/providers/services_provider.dart';
import 'package:meditrack/services/med_service.dart';

class MedNotifier extends StateNotifier<MedResponse> {

  late MedService service;

  MedNotifier(this.service) : super(MedResponse()) {
    getAll();
  }

  void getAll() async {
    try {
      state = state.copyWith(isLoadingArg: true);
      List<Med> list = await service.getAll();
      state = state.copyWith(listArg: list);
    } catch (e) {
      state = state.copyWith(errorMsgArg: "Errore lettura meds: $e\n");
    } finally {
      state = state.copyWith(isLoadingArg: false);
    }
  }

  Future<void> insert(Med med) async{
    try {
      state = state.copyWith(isLoadingArg: true);
      Med result = await service.insert(med);
      state = state.copyWith(listArg: [...state.list, result]);
    } catch (e) {
      state = state.copyWith(errorMsgArg: "Errore inserimento med: $e\n");
    } finally {
      state = state.copyWith(isLoadingArg: false);
    }
  }

  Future <void> deleteAll() async {
    try {
      state = state.copyWith(isLoadingArg: true);
      await service.deleteAll();
      state = state.copyWith(listArg: []);
    } catch (e) {
      state = state.copyWith(errorMsgArg: "Errore cancellazione meds: $e\n");
    } finally {
      state = state.copyWith(isLoadingArg: false);
    }
  }

}

final medProvider = StateNotifierProvider<MedNotifier, MedResponse> (
  (ref) => MedNotifier(ref.read(medServiceProvider))
);