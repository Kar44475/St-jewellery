import 'package:dio/dio.dart';
import 'package:stjewellery/screens/Config/ApiConfig.dart';
import '../model/BranchListModel.dart';
import '../model/referal_model.dart';
import '../screens/Config/DioInstance.dart';

class Branchservice {
  static Future<BranchListModel> getBranch() async {
    try {
      var url = ApiEndPoints.branch;
      Response response = await dioInstance.get(url);
      BranchListModel requests = BranchListModel.fromJson(response.data);
      print(response.data);
      return requests;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  static Future<ReferalModal> getRefaral() async {
    try {
      var url = ApiEndPoints.defaultreferal;
      Response response = await dioInstance.get(url);
      ReferalModal requests = ReferalModal.fromJson(response.data);
      print(response.data);
      return requests;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
