// import 'dart:async';
// import 'dart:math';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:stjewellery/AgentModule/homescreen/agentab.dart';
// import 'package:stjewellery/Constant/constants.dart';
// import 'package:stjewellery/Utils/Utils.dart';
// import 'package:stjewellery/model/Usermodel.dart';
// import 'package:stjewellery/screens/Login_OTP/OTP_Template.dart';
// import 'package:stjewellery/screens/PackagesScreen/SelectScheme.dart';
// import 'package:stjewellery/screens/Registration/RegisterPage.dart';
// import 'package:stjewellery/service/Userservice.dart';

// class OtpSkipPage extends StatefulWidget {
//   final generatedOtp;
//   final mobile;

//   const OtpSkipPage({Key? key, this.generatedOtp, this.mobile})
//     : super(key: key);

//   @override
//   State<OtpSkipPage> createState() => _OtpSkipPageState();
// }

// class _OtpSkipPageState extends State<OtpSkipPage> {
//   static const int countdownStart = 30;
//   int _remainingTime = countdownStart;
//   Timer? _timer;
//   bool resendEnable = false;
//   TextEditingController textEditingController = TextEditingController();
//   var firebasetoken;
//   var mobilenumber;
//   var myOtp;
//   int? randomNumber;

//   @override
//   void initState() {
//     super.initState();
//     setState(() {
//       mobilenumber = widget.mobile.toString();
//       myOtp = widget.generatedOtp;
//     });

//     Future.delayed(Duration.zero, () {
//       getUserDetails();
//     });
//   }

//   void _startCountdown() {
//     // Cancel any existing timer
//     _timer?.cancel();
//     setState(() {
//       _remainingTime = countdownStart;
//       resendEnable = false;
//     });

//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (_remainingTime > 0) {
//         setState(() {
//           _remainingTime--;
//         });
//       } else {
//         timer.cancel();
//         _onCountdownComplete();
//       }
//     });
//   }

//   void _onCountdownComplete() {
//     setState(() {
//       resendEnable = true;
//     });
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }

//   bool bttnPress = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.white,
//         title: GestureDetector(
//           onTap: () {},
//           child: Row(
//             children: [
//               w(15),
//               const Icon(Icons.arrow_back_ios, color: Colors.blue, size: 14),
//               Text("Back", style: font(14, Colors.blue, FontWeight.w600)),
//             ],
//           ),
//         ),
//       ),
//       body: Center(child: Text("No OTP login initiated!")),
//       // body: Center(
//       //   child: Column(
//       //     children: [
//       //       h(ScreenSize.setHeight(context, 0.2)),
//       //       Text(
//       //         textAlign: TextAlign.center,
//       //         "An SMS sent to your mobile number \n+91 79 XXX-XXXX",
//       //         style: font(15, Colors.black, FontWeight.w600),
//       //       ),
//       //       h(20),
//       //       Text(
//       //         textAlign: TextAlign.center,
//       //         "Enter six-digit code",
//       //         style: font(12, ColorUtil.fromHex("#78838D"), FontWeight.w400),
//       //       ),
//       //       Padding(
//       //         padding: const EdgeInsets.symmetric(horizontal: 110),
//       //         child: TextFormField(
//       //           cursorColor: Colors.black,
//       //           controller: textEditingController,
//       //           keyboardType: TextInputType.number,
//       //           maxLength: 6,
//       //           cursorHeight: 30,
//       //           onChanged: (value) {
//       //             if (value.length == 6) {
//       //               print(textEditingController.text.toString());
//       //               _signInWithPhoneNumber(
//       //                   textEditingController.text.toString());
//       //             }
//       //           },
//       //           cursorOpacityAnimates: true,
//       //           textAlign: TextAlign.center,
//       //           autofocus: false,
//       //           decoration: InputDecoration(
//       //             counterText: "", // Hides the max length text
//       //             hintText: "XXX-XXX",
//       //             hintStyle: TextStyle(
//       //               fontWeight: FontWeight.w400,
//       //               fontSize: 36,
//       //               color: ColorUtil.fromHex("#BAC2C7"),
//       //             ),
//       //           ),
//       //           style:
//       //               const TextStyle(fontSize: 36, fontWeight: FontWeight.w500),
//       //         ),
//       //       ),
//       //       h(20),
//       //       resendEnable
//       //           ? GestureDetector(
//       //               onTap: () {
//       //                 generateRandomNumber();
//       //                 // resendOtp(context,widget.mobile, randomNumber.toString());
//       //                 _startCountdown(); // Restart the countdown
//       //               },
//       //               child: Text(
//       //                 "Resend OTP",
//       //                 style: font(14, Colors.black, FontWeight.w600),
//       //               ),
//       //             )
//       //           : Row(
//       //               mainAxisAlignment: MainAxisAlignment.center,
//       //               children: [
//       //                 Text(
//       //                   "Resend Code in ",
//       //                   style: font(
//       //                       14, ColorUtil.fromHex("#78838D"), FontWeight.w400),
//       //                 ),
//       //                 Text(
//       //                   "00:$_remainingTime",
//       //                   style: font(14, Colors.black, FontWeight.w600),
//       //                 ),
//       //               ],
//       //             ),
//       //     ],
//       //   ),
//       // ),
//       // bottomNavigationBar: Container(
//       //   height: 80,
//       //   child: bttnPress == true
//       //       ? loadBttn()
//       //       : bttn("Verify OTP", () async {
//       //           setState(() {
//       //             bttnPress = true;
//       //           });
//       //           // Map b = {"phone": mobilenumber, "FcmToken": firebasetoken};
//       //           // print(b);
//       //           // Usermodel? datas = await UserService.login(b);
//       //           // print("````````````````");
//       //           // print(datas!.data!.islogin);
//       //           // print("````````````````");
//       //           _signInWithPhoneNumber(textEditingController.text.toString());
//       //         }),
//       // ),
//     );
//   }

//   getFirebasetoken() async {
//     FirebaseMessaging messaging = FirebaseMessaging.instance;
//     firebasetoken = await messaging.getToken();
//     print(firebasetoken);
//   }

//   Future<void> noOtpFUnction() async {
//     getFirebasetoken();

//     print("mobile : " + mobilenumber);
//     if (mobilenumber.toString() == "+919946088916") {
//       getUserDetails();
//     } else {
//       print("regularr");
//     }
//   }

//   Future<void> getUserDetails() async {
//     print("xoxoxoxoxoxoxooxox");
//     try {
//       Map b = {"phone": mobilenumber, "FcmToken": firebasetoken};
//       print(firebasetoken);
//       // Loading.show(context);
//       Usermodel? datas = await UserService.login(b);
//       // Loading.dismiss();
//       print("````````````````");
//       print(datas!.data!.islogin);
//       print("````````````````");

//       if (datas.data!.islogin!) {
//         if (datas.data!.roleId == 3) {
//           Navigate.pushAndRemoveUntil(context, Agentab());
//           // Navigator.pushNamedAndRemoveUntil(context,
//           //     AgentDashboardhome.routeName, (Route<dynamic> route) => false);
//         } else {
//           if (datas.data!.subscriptionList!.isEmpty) {
//             print("1");
//             Navigate.pushAndRemoveUntil(context, SelectScheme());

//             // Navigator.pushNamedAndRemoveUntil(
//             //     context,
//             //     Selectpackagefirsttime.routeName,
//             //     (Route<dynamic> route) => false);
//           } else {
//             print("2 heree");
//             Navigate.pushAndRemoveUntil(context, SelectScheme());
//             // Navigator.push(
//             //   context,
//             //   MaterialPageRoute(builder: (context) => SelectScheme()),
//             // );
//           }
//         }
//       } else {
//         print("register new");
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => Registration(phone: widget.mobile),
//           ),
//         );
//       }
//       //  Navigator.of(context).pop(true);
//       // showLoading(context);
//       // setState(() {
//       //   Loading.dismiss();
//       //   data = datas;
//       //   print(data);
//       //   //  test();
//       // });
//     } catch (e) {
//       print(e);
//       // showErrorMessage(e);
//       // Loading.dismiss();
//       //  Navigator.pop(context);
//     }
//   }

//   int? generateRandomNumber() {
//     Random random = Random();

//     randomNumber = random.nextInt(900000) + 100000;
//     setState(() {
//       myOtp = randomNumber;
//     });

//     resendOtp(context, widget.mobile, randomNumber.toString());

//     return randomNumber;
//   }

//   _signInWithPhoneNumber(String number) async {
//     p("submitted: $number");
//     p("myOTO : $myOtp");
//     if (myOtp.toString() == number.toString()) {
//       showSnackBar(context, "OTP Verified");
//       setState(() {
//         bttnPress = false;
//       });
//       // Navigator.push(
//       //   context,
//       //   MaterialPageRoute(
//       //       builder: (context) => Registration(phone: mobilenumber.toString())),
//       // );
//       try {
//         getUserDetails();
//         getFirebasetoken();
//         return;
//       } catch (e) {
//         print(e);
//       }
//     } else {
//       showSnackBar(context, "Incorrect OTP");
//     }
//   }
// }
