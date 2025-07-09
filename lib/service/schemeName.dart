import 'dart:developer';
import 'package:stjewellery/utils/utils.dart';

import 'package:stjewellery/screens/Config/ApiConfig.dart';
import 'package:stjewellery/screens/Config/DioInstance.dart';
import 'package:dio/dio.dart';

import '../model/SaveSchemeModel.dart';

class SaveSchemeName {
  static Future<SaveSchemeModel> postService(Map data) async {
    try {
      var url = ApiEndPoints.renameschemname;
      // var user = await getSavedObject("@user");
      // UserModel _user = UserModel.fromJson(user);
      FormData formData = FormData.fromMap({
        'subscriptionId': data['subscriptionId'],
        'UserId': data['UserId'],
        'user_scheme_name': data['user_scheme_name'],
      });
      Response response = await ApiService.postData(url, formData);
      print(response.data);
      log(response.data.toString());

      SaveSchemeModel requests = SaveSchemeModel.fromJson(response.data);
      return requests;
    } catch (e) {
      showErrorMessage(e);
      print(e.toString());
      throw e;
    }
  }
}
