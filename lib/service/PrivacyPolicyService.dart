import 'package:dio/dio.dart';
import 'package:stjewellery/model/PrivacyPolicyModel.dart';
import 'package:stjewellery/screens/Config/ApiConfig.dart';

import '../screens/Config/DioInstance.dart';

class PrivacyPolicyService {
  static Future<PrivacyPolicyModel> getPolicy() async {
    try {
      var url = ApiEndPoints.privcyPolicy;
      Response response = await dioInstance.get(url);
      print(response.data);
      PrivacyPolicyModel requests = PrivacyPolicyModel.fromJson(response.data);
      print(response.data);
      return requests;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
