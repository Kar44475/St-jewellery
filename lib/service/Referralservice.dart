import 'package:stjewellery/model/Referralmodel.dart';
import 'package:stjewellery/utils/utils.dart';

import 'package:stjewellery/screens/Config/ApiConfig.dart';
import 'package:stjewellery/screens/Config/DioInstance.dart';
import 'package:dio/dio.dart';

class Referralservice {
  int? userid;
  static Future<Referralmodel> getReferralservice(userid) async {
    try {
      var url = ApiEndPoints.referalList;

      // var user = await getSavedObject("@user");
      // UserModel _user = UserModel.fromJson(user);
      FormData formData = FormData.fromMap({'UserId': userid});
      Response response = await ApiService.postData(url, formData);
      print(response.data);
      Referralmodel requests = Referralmodel.fromJson(response.data);
      return requests;
    } catch (e) {
      showErrorMessage(e);
      print(e.toString());
      throw e;
    }
  }
}
