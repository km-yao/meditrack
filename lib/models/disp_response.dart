

import 'package:meditrack/models/disponibilita.dart';

class DispResponse {
  DispResponse();

  bool isLoading = false;
  String errorMsg = "";
  List<Disponibilita> list = [];

  DispResponse copyWith({ bool? isLoadingArg, String? errorMsgArg, List<Disponibilita>? listArg }) {
    DispResponse newResponse = DispResponse();

    newResponse.isLoading =  isLoadingArg ?? isLoading;
    newResponse.errorMsg =  errorMsgArg ?? errorMsg;
    newResponse.list =  listArg ?? list;

    return newResponse;
  }


}