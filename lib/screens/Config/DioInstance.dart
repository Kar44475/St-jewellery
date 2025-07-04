import 'dart:convert';
// import 'package:stjewellery/Util/Utils.dart';
import 'package:stjewellery/Utils/utils.dart';
import 'package:stjewellery/screens/Config/ApiConfig.dart';

import 'package:dio/dio.dart';

BaseOptions options = new BaseOptions(
  baseUrl: ApiConfigs.API_URL,

  // connectTimeout: 5000,
  // receiveTimeout: 3000,
);
Dio dioInstance = new Dio(options);

class ApiService {
  String? firebasetoken;
  static Future<Response> getData(String url, Map<String, dynamic> data) async {
    try {
      Map<String, dynamic> _data = data;
      // var user = await getSavedObject("@user");

      // if (user != null) {
      //   UserModel _user = UserModel.fromJson(user);
      //   _data = {...data, "sessionId": _user.sessionId};
      // }
      print(_data);
      //  dioInstance.options.headers['content-Type'] = 'application/json';
      dioInstance.options.headers["Authorization"] =
          "Bearer " + await getSavedObject("token");
      print("Bearer " + await getSavedObject("token"));

      /////
      Response response = await dioInstance.get(url, queryParameters: _data);
      print(response);
      return response;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  static Future<Response> postData(String url, dynamic data) async {
    try {
      // Loading.show(context);

      dioInstance.options.headers["Authorization"] =
          "Bearer " + await getSavedObject("token");
      Response response = await dioInstance.post(url, data: data);
      return response;
    } catch (e) {
      if (e is DioError) {
        if (e.response != null) {
          try {
            var errr = json.decode(e.response.toString());
            throw new Exception(errr);
          } catch (err) {
            throw e;
          }
        }
        throw e;
      } else {
        throw e;
      }
    }
  }
}
