import 'package:dio/dio.dart';
import 'package:stjewellery/model/offerModel.dart';
import 'package:stjewellery/screens/Config/DioInstance.dart';

import '../screens/Config/ApiConfig.dart';

class Offerservice {
  static Future<Offermodel> getOffers() async {
    try {
      var url = ApiEndPoints.offers;
      Map data;
      // var user = await getSavedObject("@user");
      // UserModel _user = UserModel.fromJson(user);
      // FormData formData = FormData.fromMap(
      //   data,
      // );
      Response response = await dioInstance.get(url);

      // Response response = await ApiService.getData(url, data);
      print("``````````````````response.data``````````````````");
      print(response.data);
      print("``````````````````response.data``````````````````");
      Offermodel requests = Offermodel.fromJson(response.data);
      return requests;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
