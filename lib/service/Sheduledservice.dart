import 'package:dio/dio.dart';
import 'package:stjewellery/support_widget/essential.dart';
import 'package:stjewellery/model/Sheduledmodel.dart';
import 'package:stjewellery/screens/Config/ApiConfig.dart';
import 'package:stjewellery/screens/Config/DioInstance.dart';

class Sheduledservice {
  static Future<Sheduledmodel> postService(Map data) async {
    try {
      var url = ApiEndPoints.sheduledList;
      FormData formData = FormData.fromMap({
        'subscriptionId': data['subscriptionId'],
        'UserId': data['UserId'],
      });
      Map s = {
        'subscriptionId': data['subscriptionId'],
        'UserId': data['UserId'],
      };
      print(s);
      Response response = await ApiService.postData(url, formData);
      print(response.data);

      Sheduledmodel requests = Sheduledmodel.fromJson(response.data);
      await saveObject("terms", requests.data!.termsandcondtion!.description);
      await saveObject("refers", requests.data!.referalId!.elementAt(0));
      await saveObject('branch', requests.data!.subs!.branchId);
      return requests;
    } catch (e) {
      print("xoxoxoxoxo");
      showErrorMessage(e.toString());
      print(e.toString());
      throw e;
    }
  }
}
