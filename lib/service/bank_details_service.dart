import 'package:dio/dio.dart';
import 'package:stjewellery/model/Bankdetailsmodel.dart';
import 'package:stjewellery/screens/Config/ApiConfig.dart';
import '../model/BranchListModel.dart';
import '../screens/Config/DioInstance.dart';

class Branchdetailservice {
  static Future<Bankdetailsmodel> getBankDetails() async {
    try {
      var url = ApiEndPoints.bankdetails;
      Response response = await dioInstance.get(url);
      Bankdetailsmodel requests = Bankdetailsmodel.fromJson(response.data);

      print(response.data);
      return requests;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
