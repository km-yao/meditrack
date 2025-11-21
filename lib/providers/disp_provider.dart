

import 'package:flutter_riverpod/legacy.dart';
import 'package:meditrack/models/disp_response.dart';
import 'package:meditrack/models/disponibilita.dart';
import 'package:meditrack/providers/services_provider.dart';
import 'package:meditrack/services/disp_service.dart';

class DispNotifier  extends StateNotifier<DispResponse> {

  late DispService service;

  DispNotifier(this.service) : super(DispResponse()) {
    getAll();
  }

  void getAll() async {
    try {
      state = state.copyWith(isLoadingArg: true);
      List<Disponibilita> list = await service.getAll();
      state = state.copyWith(listArg: list);
    } catch (e) {
      state = state.copyWith(errorMsgArg: "Errore lettura disponibilità: $e\n");
    } finally {
      state = state.copyWith(isLoadingArg: false);
    }
  }

  Future<void> insert(Disponibilita disponibilita) async{
    try {
      state = state.copyWith(isLoadingArg: true);
      await service.insert(disponibilita);
      state = state.copyWith(listArg: [...state.list, disponibilita]);
    } catch (e) {
      state = state.copyWith(errorMsgArg: "Errore inserimento disponibilità: $e\n");
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
      state = state.copyWith(errorMsgArg: "Errore cancellazione disponibilità: $e\n");
    } finally {
      state = state.copyWith(isLoadingArg: false);
    }
  }

  Future<Disponibilita> getDisponibilita(int id) async {
    try {
      state = state.copyWith(isLoadingArg: true);
      Disponibilita disponibilita = await service.getDisponibilita(id);
      return disponibilita;
    } catch (e) {
      state = state.copyWith(errorMsgArg: "Errore lettura disponibilità: $e\n");
      rethrow;
    } finally {
      state = state.copyWith(isLoadingArg: false);
    }
  }

}

final dispProvider = StateNotifierProvider<DispNotifier, DispResponse> (
  (ref) => DispNotifier(ref.read(dispServiceProvider))
);