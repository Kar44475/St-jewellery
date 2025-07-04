import 'package:stjewellery/model/Subscriptionlistmodel.dart';
import 'package:stjewellery/screens/Config/ApiConfig.dart';
import 'package:stjewellery/screens/Config/DioInstance.dart';
import 'package:dio/dio.dart';

class Schemelistgetservice {
  static Future<Subscriptionlistmodel> getScheme(int userid) async {
    try {
      print("xoxoxoxoxoxoxoxoxhjboxoxo");

      var url = ApiEndPoints.subscriptionList + userid.toString();

      Map<String, dynamic> data = {};
      print("url : $url");
      Response response = await ApiService.getData(url, data);
      Subscriptionlistmodel requests = Subscriptionlistmodel.fromJson(
        response.data,
      );

      return requests;
    } catch (e) {
      print("catcthh");
      print(e.toString());
      throw e;
    }
  }
}
