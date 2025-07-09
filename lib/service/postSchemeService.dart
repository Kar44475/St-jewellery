import 'package:dio/dio.dart';

import 'package:stjewellery/model/Schemeaddmodel.dart';
import 'package:stjewellery/screens/Config/ApiConfig.dart';
import 'package:stjewellery/screens/Config/DioInstance.dart';
import 'package:stjewellery/utils/utils.dart';

class PostSchemeService {
  static Future<Schemeaddmodel> postService(Map data) async {
    try {
      var url = ApiEndPoints.subscription;
      // var user = await getSavedObject("@user");
      // UserModel _user = UserModel.fromJson(user);
      FormData formData = FormData.fromMap({
        'SchemeId': data['SchemeId'],
        'SchemeAmountId': data['SchemeAmountId'],
        'UserId': data['UserId'],
        'StartDate': data['StartDate'],
        'subscription_type': data['subscription_type'],
        "scheme_type": data["scheme_type"],
        "check_payment_interval": data["check_payment_interval"],
        "termsId": data["termsId"],
        //  "redeem_type": data["redeem_type"]
      });
      Response response = await ApiService.postData(url, formData);
      Schemeaddmodel requests = Schemeaddmodel.fromJson(response.data);
      return requests;
    } catch (e) {
      showErrorMessage(e);
      print(e.toString());
      throw e;
    }
  }
}
