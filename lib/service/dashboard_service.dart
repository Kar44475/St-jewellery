import 'package:stjewellery/model/CategoryWiseProductResponseModel.dart';
import 'package:stjewellery/model/Dashboardmodel.dart';
import 'package:stjewellery/model/allproductmodel.dart';
import 'package:stjewellery/model/categorymodel.dart';
import 'package:stjewellery/screens/Config/ApiConfig.dart';

import 'package:dio/dio.dart';
import 'package:stjewellery/Utils/utils.dart';

class Dashbordservice {
  static Future<Dashboardmodel> getDashboard() async {
    try {
      var branchid = await getSavedObject('branch') ?? "2";
      var url = "dashboard/" + branchid.toString();
      Map data;
      // var user = await getSavedObject("@user");
      // UserModel _user = UserModel.fromJson(user);
      // FormData formData = FormData.fromMap(
      //   data,
      // );
      print(ApiConfigs.API_URL + url);
      Response response = await Dio().get(ApiConfigs.API_URL + url);
      print(response.data);
      Dashboardmodel requests = Dashboardmodel.fromJson(response.data);

      return requests;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  static Future<CategoryProductResponseModel> getDashboardCatgory() async {
    try {
      var branchid = await getSavedObject('branch') ?? "2";
      var url = ApiEndPoints.categoryList;
      print(ApiConfigs.API_URL + url);
      Response response = await Dio().get(ApiConfigs.API_URL + url);
      print(response.data);

      return CategoryProductResponseModel.fromJson(response.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  static Future<AllProductsResponseModel> getAllProduct() async {
    try {
      var branchid = await getSavedObject('branch') ?? "2";
      var url = ApiEndPoints.allProduct;
      print(ApiConfigs.API_URL + url);
      Response response = await Dio().post(ApiConfigs.API_URL + url);
      print(response.data);

      return AllProductsResponseModel.fromJson(response.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  static Future<CategoryWiseProductResponseModel> getByCategoryProduct(
    String id,
  ) async {
    try {
      var branchid = await getSavedObject('branch') ?? "2";
      var url = ApiEndPoints.productList + "/" + id;
      print(ApiConfigs.API_URL + url);
      Response response = await Dio().get(ApiConfigs.API_URL + url);
      print(response.data);

      return CategoryWiseProductResponseModel.fromJson(response.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
