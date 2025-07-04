import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:stjewellery/Utils/Utils.dart';
import 'package:stjewellery/screens/Login_OTP/OtpScreen.dart';

// String cookie = "PHPSESSID=mfq5bi8d5h24c1t506m9m8r210";
String firstPart =
    "https://firstdialsms.in/sendsms?uname=stjewellery&pwd=stjewellery25&senderid=STJWLR&to=";
String secondpart = '&msg=';
String lastPart =
    " is your One Time Password for online verification of ST JEWELLERY MANUFACTURERS customer app. Don't share this with anyone &route=T&peid=1701169942595471722&tempid=1707173824140884442";

Future<void> sendOtp(
  BuildContext context,
  String phone,
  String otp,
  bool jumpneed,
) async {
  print(phone);
  print(otp);
  var dio = Dio();

  try {
    var response = await dio.request(
      firstPart + phone + secondpart + otp + lastPart,
      options: Options(method: 'GET'),
    );

    if (response.statusCode == 200) {
      if (jumpneed) 
      {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                OtpPage(generatedOtp: otp, mobile: "+91$phone"),
          ),
        );
      }
    } else {
      showToast("Something went wrong!");
      print(response.statusMessage);
    }
  } catch (e) {
    print("Error: $e");
    showToast("Failed to send OTP. Please try again!");
  }
}

Future<void> resendOtp(BuildContext context, String phone, String otp) async {
  print(phone);
  print(otp);
  // var headers = {'Cookie': cookie};
  var dio = Dio();

  try {
    var response = await dio.request(
      firstPart + phone + secondpart + otp + lastPart,
      options: Options(
        method: 'GET',
        // headers: headers,
      ),
    );

    if (response.statusCode == 200) {
    } else {
      showToast("Something went wrong");
      print(response.statusMessage);
    }
  } catch (e) {
    print("Error: $e");
    showToast("Failed to send OTP. Please try again.");
  }
}
