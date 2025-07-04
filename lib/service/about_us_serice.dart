import 'package:stjewellery/model/about_us_model.dart';
import 'package:stjewellery/model/Subscriptionlistmodel.dart';
import 'package:stjewellery/screens/Config/ApiConfig.dart';
import 'package:stjewellery/screens/Config/DioInstance.dart';
import 'package:dio/dio.dart';

class Aboutusservice {
  static Future<Aboutusmodel> getAboutus() async {
    try {
      var url = ApiEndPoints.aboutUs;

      Map data;
      // var user = await getSavedObject("@user");
      // UserModel _user = UserModel.fromJson(user);
      // FormData formData = FormData.fromMap(
      //   data,
      // );
      print(url);
      Response response = await dioInstance.get(url);

      // Response response = await ApiService.getData(url, data);
      print(response.data);
      Aboutusmodel requests = Aboutusmodel.fromJson(response.data);

      return requests;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
