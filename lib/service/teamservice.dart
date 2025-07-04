import 'package:dio/dio.dart';
import 'package:stjewellery/screens/Config/ApiConfig.dart';
import '../model/teamModel.dart';
import '../screens/Config/DioInstance.dart';

class Teamservice {
  static Future<TeamModel> getTeam() async {
    try {
      var url = ApiEndPoints.team;
      Map<String, dynamic> data = {};

      // Response response = await dioInstance.get(url);
      Response response = await ApiService.getData(url, data);

      TeamModel requests = TeamModel.fromJson(response.data);
      print(requests.data!.status);
      return requests;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
