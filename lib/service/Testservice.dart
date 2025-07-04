// class EnquiryService {
//   static Future<SuccessFailuremodel> postDetails(Map data) async {
//     try {
//       var url = ApiEndPoints.postsubmitenquiry;
//       var user = await getSavedObject("@user");
//       UserModel _user = UserModel.fromJson(user);
//       FormData formData = FormData.fromMap(
//         data,
//       );
//       print(data);
//       print(_user.sessionId);
//       Response response = await dioInstance.post(url, data: formData);
//       SuccessFailuremodel requests =
//           SuccessFailuremodel.fromJson(response.data);
//       print(requests.message);

//       return requests;
//     } catch (e) {
//       print(e.toString());
//       throw e;
//     }
//   }

//   static Future<ProjectListResponse> getProjects(String page) async {
//     try {
//       var url = ApiEndPoints.getprojects;
//       var user = await getSavedObject("@user");
//       UserModel _user = UserModel.fromJson(user);
//       FormData formData = FormData.fromMap(
//         {"pageNbr": page.toString(), "sessionId": _user.sessionId},
//       );
//       Response response = await dioInstance.post(url, data: formData);
//       print(response.data);

//       final jsonDecoded = jsonDecode(response.toString());
//       print(response);
//       return ProjectListResponse.fromJson(jsonDecoded);
//     } catch (e) {
//       print(e.toString());
//       throw e;
//     }
//   }
// }
