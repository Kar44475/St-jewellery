import 'package:stjewellery/model/SchemeListModel.dart';
import 'package:stjewellery/model/schemeAmountListmodel.dart';
import 'package:stjewellery/screens/Config/ApiConfig.dart';
import 'package:stjewellery/screens/Config/DioInstance.dart';
import 'package:dio/dio.dart';

class Schemelistservice {
  static Future<SchemeListmodel> getScheme() async {
    try {
      var url = ApiEndPoints.schemeList;

      Map<String, dynamic> data = {};
      Response response = await ApiService.getData(url, data);
      // Response response = await Dio().get(ApiConfigs.API_URL + url);
      SchemeListmodel requests = SchemeListmodel.fromJson(response.data);

      return requests;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  static Future<SchemeAmountListmodel> schemeAmount(String id) async {
    try {
      var url = ApiEndPoints.schemeAmount + id;
      print(id);

      Map<String, dynamic> data = {};
      print("url : $url");
      Response response = await ApiService.getData(url, data);
      print(response.data);
      SchemeAmountListmodel requests = SchemeAmountListmodel.fromJson(
        response.data,
      );

      return requests;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
