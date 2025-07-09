import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:stjewellery/Utils/utils.dart';
import 'package:stjewellery/screens/Login_OTP/otp_screen.dart';

// String cookie = "PHPSESSID=mfq5bi8d5h24c1t506m9m8r210";
String smsApiBaseUrl =
    "https://firstdialsms.in/sendsms?uname=stjewellery&pwd=stjewellery25&senderid=STJWLR&to=";
String messageParameter = '&msg=';
String smsApiSuffix =
    " is your One Time Password for online verification of ST JEWELLERY MANUFACTURERS customer app. Don't share this with anyone &route=T&peid=1701169942595471722&tempid=1707173824140884442";

Future<void> sendOtp(
  BuildContext context,
  String phoneNumber,
  String otpCode,
  bool shouldNavigate,
) async {
  print(phoneNumber);
  print(otpCode);
  var httpClient = Dio();

  try {
    var apiResponse = await httpClient.request(
      smsApiBaseUrl + phoneNumber + messageParameter + otpCode + smsApiSuffix,
      options: Options(method: 'GET'),
    );

    if (apiResponse.statusCode == 200) {
      if (shouldNavigate) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                OtpPage(generatedOtp: otpCode, mobile: "+91$phoneNumber"),
          ),
        );
      }
    } else {
      showToast("Something went wrong!");
      print(apiResponse.statusMessage);
    }
  } catch (error) {
    print("Error: $error");
    showToast("Failed to send OTP. Please try again!");
  }
}

Future<void> resendOtp(
  BuildContext context,
  String phoneNumber,
  String otpCode,
) async {
  print(phoneNumber);
  print(otpCode);
  // var headers = {'Cookie': cookie};
  var httpClient = Dio();

  try {
    var apiResponse = await httpClient.request(
      smsApiBaseUrl + phoneNumber + messageParameter + otpCode + smsApiSuffix,
      options: Options(
        method: 'GET',
        // headers: headers,
      ),
    );

    if (apiResponse.statusCode == 200) {
    } else {
      showToast("Something went wrong");
      print(apiResponse.statusMessage);
    }
  } catch (error) {
    print("Error: $error");
    showToast("Failed to send OTP. Please try again.");
  }
}
