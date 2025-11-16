
import 'package:meditrack/models/med.dart';

class MedResponse {
  
  MedResponse();

  bool isLoading = false;
  String errorMsg = "";
  List<Med> list = [];

  MedResponse copyWith({ bool? isLoadingArg, String? errorMsgArg, List<Med>? listArg }) {
    MedResponse newResponse = MedResponse();

    newResponse.isLoading =  isLoadingArg ?? isLoading;
    newResponse.errorMsg =  errorMsgArg ?? errorMsg;
    newResponse.list =  listArg ?? list;

    return newResponse;
  }

}