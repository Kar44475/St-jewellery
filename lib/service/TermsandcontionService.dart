import 'package:dio/dio.dart';

import 'package:stjewellery/Utils/utils.dart';
import '../model/TermsNConditionModel.dart';
import '../screens/Config/ApiConfig.dart';
import '../screens/Config/DioInstance.dart';

class TermsService {
  // static Future<TermsNConditionModel> getTerms() async {
  //   try {
  //     var id = await getSavedObject('schemeAmountId');
  //     var url = "termsAndCondition/" + id.toString();
  //     Map data;
  //     // var user = await getSavedObject("@user");
  //     // UserModel _user = UserModel.fromJson(user);
  //     // FormData formData = FormData.fromMap(
  //     //   data,
  //     // );
  //     print(ApiConfigs.API_URL + url);
  //     Response response = await Dio().get(ApiConfigs.API_URL + url);
  //     print(response.data);
  //     TermsNConditionModel requests =
  //         TermsNConditionModel.fromJson(response.data);
  //
  //     return requests;
  //   } catch (e) {
  //     print(e.toString());
  //     throw e;
  //   }
  // }

  static Future<TermsNConditionModel> getTerms() async {
    try {
      int id = await getSavedObject('schemeAmountId');
      print("~~~~~~~~~~~schemeAmountId~~~~~~~~~~~~");
      print(id);

      var url = ApiEndPoints.termsCondition + "/" + id.toString();
      // Map? data;
      // var user = await getSavedObject("@user");
      // UserModel _user = UserModel.fromJson(user);
      // FormData formData = FormData.fromMap(
      //   data,
      // );
      // print(url);
      // Response response = await ApiService.getData(url, data);
      // TermsNConditionModel requests =
      //     TermsNConditionModel.fromJson(response.data);
      // return requests;

      Response response = await dioInstance.get(url);
      print(response.data);
      TermsNConditionModel requests = TermsNConditionModel.fromJson(
        response.data,
      );
      print(response.data);
      return requests;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
