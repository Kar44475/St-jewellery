import 'package:dio/dio.dart';
import 'package:stjewellery/Utils/utils.dart';
import 'package:stjewellery/model/Nextpaymentcustomerlistmodel.dart';
import 'package:stjewellery/model/agent_list_model.dart';
import 'package:stjewellery/screens/Config/ApiConfig.dart';
import 'package:stjewellery/screens/Config/DioInstance.dart';

class Customerlistservice {
  static Future<Agentcustomermodel> getCustomerlist() async {
    try {
      var url = ApiEndPoints.agentCustomerList;
      // var user = await getSavedObject("@user");
      // UserModel _user = UserModel.fromJson(user);
      FormData formData = FormData.fromMap({
        'agentId': await getSavedObject("userid"),
        //await getSavedObject("userid"),
      });
      print(formData.fields);
      Response response = await ApiService.postData(url, formData);
      print(response.data);
      Agentcustomermodel requests = Agentcustomermodel.fromJson(response.data);
      return requests;
    } catch (e) {
      showErrorMessage(e);
      print(e.toString());
      throw e;
    }
  }

  static Future<Nextpaymentcustomerlistmodel> getCustomernextpaymnetlist(
    Map data,
  ) async {
    try {
      var url = ApiEndPoints.agentCustomerListLive;
      // var user = await getSavedObject("@user");
      // UserModel _user = UserModel.fromJson(user);
      FormData formData = FormData.fromMap({
        'agentId': await getSavedObject("userid"), "limit": data["limit"],
        "page": data["page"],

        //await getSavedObject("userid"),
      });
      print(formData.fields);
      Response response = await ApiService.postData(url, formData);
      Nextpaymentcustomerlistmodel requests =
          Nextpaymentcustomerlistmodel.fromJson(response.data);
      return requests;
    } catch (e) {
      showErrorMessage(e);
      print(e.toString());
      throw e;
    }
  }
}
