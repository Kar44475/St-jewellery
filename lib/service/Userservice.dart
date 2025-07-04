import 'package:stjewellery/Utils/utils.dart';
import 'package:stjewellery/model/Usermodel.dart';
import 'package:stjewellery/screens/Config/ApiConfig.dart';
import 'package:stjewellery/screens/Config/DioInstance.dart';
import 'package:dio/dio.dart';

class UserService {
  static Future<Usermodel?> login(Map data) async {
    Usermodel requests;
    try {
      var url = ApiEndPoints.login;
      FormData formData = FormData.fromMap({
        "phone": data['phone'],
        "FcmToken": data['FcmToken'],
      });

      Map s = {"phone": data['phone'], "FcmToken": data['FcmToken']};
      print(s);
      Response response = await dioInstance.post(url, data: formData);
      if (response.statusCode == 200) {
        print(response.data);
        Usermodel requests = Usermodel.fromJson(response.data);
        await saveObject("name", requests.data!.userName);

        await saveObject("userid", requests.data!.userId);
        await saveObject("Email", requests.data!.email);
        await saveObject("roleid", requests.data!.roleId);
        await saveObject("phone", data['phone']);
        await saveObject("token", requests.data!.token);
        await saveObject('branch', requests.data!.branchId);
        print("completed saving");
        if (requests.data!.roleId == 3) {
          await saveObject("referalId", requests.data!.referalId);
        }
        return requests;
      } else {}
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
