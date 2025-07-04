import 'package:stjewellery/model/Agentpendingmodel.dart';
import 'package:stjewellery/model/SchemeListModel.dart';
import 'package:stjewellery/model/schemeAmountListmodel.dart';
import 'package:stjewellery/screens/Config/ApiConfig.dart';
import 'package:stjewellery/screens/Config/DioInstance.dart';
import 'package:dio/dio.dart';

class Pendingpaymentservice {
  static Future<Agentpendingmodel> getpendingpayment() async {
    try {
      var url = ApiEndPoints.agentPaymentToAdmin;
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
      Agentpendingmodel requests = Agentpendingmodel.fromJson(response.data);

      return requests;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
