import 'package:stjewellery/model/Paymentdetailsmodel.dart';
import 'package:stjewellery/model/Recepitmodel.dart';
import 'package:stjewellery/support_widget/essential.dart';

import 'package:stjewellery/screens/Config/ApiConfig.dart';
import 'package:stjewellery/screens/Config/DioInstance.dart';
import 'package:dio/dio.dart';

class Paymentdetailsservice {
  static Future<Paymentdetailsmodel> postService(Map data) async {
    try {
      var url = ApiEndPoints.paymentList;
      // var user = await getSavedObject("@user");
      // UserModel _user = UserModel.fromJson(user);
      FormData formData = FormData.fromMap({
        'subscriptionId': data['subscriptionId'],
        'UserId': data['UserId'],
      });
      Response response = await ApiService.postData(url, formData);
      print(response.data);
      Paymentdetailsmodel requests = Paymentdetailsmodel.fromJson(
        response.data,
      );
      return requests;
    } catch (e) {
      showErrorMessage(e);
      print(e.toString());
      throw e;
    }
  }

  static Future<Recepitmodel> paymentDetails(Map data) async {
    try {
      var url = ApiEndPoints.paymentDetails;
      // var user = await getSavedObject("@user");
      // UserModel _user = UserModel.fromJson(user);
      FormData formData = FormData.fromMap({
        'SheduledDateId': data['SheduledDateId'],
        'UserId': data['UserId'],
      });
      Response response = await ApiService.postData(url, formData);
      print(response.data);
      Recepitmodel requests = Recepitmodel.fromJson(response.data);
      return requests;
    } catch (e) {
      showErrorMessage(e);
      print(e.toString());
      throw e;
    }
  }
}
