import 'package:stjewellery/Utils/utils.dart';

import 'package:stjewellery/screens/Config/ApiConfig.dart';
import 'package:stjewellery/screens/Config/DioInstance.dart';
import 'package:dio/dio.dart';

class Logoutservice {
  static Future<void> logoutservice() async {
    try {
      var url = ApiEndPoints.logout;
      // var user = await getSavedObject("@user");
      // UserModel _user = UserModel.fromJson(user);
      FormData formData = FormData.fromMap({
        // 'agentId': await getSavedObject("userid")
        //await getSavedObject("userid"),
      });
      Response response = await ApiService.postData(url, formData);
      print(response.data);
      //  Agentcustomermodel requests = Agentcustomermodel.fromJson(response.data);
      //  return requests;
    } catch (e) {
      showErrorMessage(e);
      print(e.toString());
      throw e;
    }
  }

  static Future<void> deleteService() async {
    try {
      var b;
      var url = ApiEndPoints.deleteService;
      // var user = await getSavedObject("@user");R
      // UserModel _user = UserModel.fromJson(user);
      FormData formData = FormData.fromMap({
        // 'agentId': await getSavedObject("userid")
        //await getSavedObject("userid"),
      });
      Response response = await ApiService.getData(url, b);
      print(response.data);
      //  Agentcustomermodel requests = Agentcustomermodel.fromJson(response.data);
      //  return requests;
    } catch (e) {
      showErrorMessage(e);
      print(e.toString());
      throw e;
    }
  }
}
