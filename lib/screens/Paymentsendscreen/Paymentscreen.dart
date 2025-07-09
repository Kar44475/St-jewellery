// import 'dart:io';
//
// import 'package:external_app_launcher/external_app_launcher.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:stjewellery/BottomNav/BottomNav.dart';
// import 'package:stjewellery/Constant/Constants.dart';
// import 'package:stjewellery/utils/utils.dart';
// import 'package:stjewellery/model/Bankdetailsmodel.dart';
// import 'package:stjewellery/model/userpaymodel.dart';
// import 'package:stjewellery/screens/Paymentsendscreen/newWidgetsPaymentPage.dart';
// import 'package:stjewellery/service/Paymentservice.dart';
// import 'package:stjewellery/service/bankdetailsservice.dart';
//
// class Paymentscreen extends StatefulWidget {
//   final arguments;
//   const Paymentscreen({Key? key, this.arguments}) : super(key: key);
//
//   @override
//   _PaymentscreenState createState() => _PaymentscreenState();
// }
//
// class _PaymentscreenState extends State<Paymentscreen> {
//   //THEME--------------------------------------
//   bool darkmode = false;
//   final bg = const Color(0xff261d1d);
//   //THEME--------------------------------------
//
//   // Future exitt() {
//   //   Navigator.pop(context);
//   // }
//
//   TextEditingController amountController = TextEditingController();
//   TextEditingController transidController = TextEditingController();
//   String finalgram = "";
//   Map? details;
//   double gram = 0;
//   File? _image;
//   final picker = ImagePicker();
//   int paymentmethod = 1;
//   String? schemetype;
//   String? average;
//   String? currentstatus;
//   Bankdetailsmodel? bankdDetails;
//
//   String? payment_response;
//
//   String mid = "PmyQlW65879937951416";
//   String PAYTM_MERCHANT_KEY = "uGOzDNCI7dFq8E!d";
//   String website = "WEBSTAGING";
//   bool testing = true;
//   bool isUpiPresent = true;
//   bool isbankdetailsPresent = true;
//   int tablength = 0;
//
//   double amount = 1;
//   bool loading = false;
//   int? selectedRadio;
//
//   setSelectedRadio(int val) {
//     setState(() {
//       selectedRadio = val;
//       paymentmethod = val;
//     });
//   }
//
//   Future getImage(setState) async {
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path);
//         setState(() {});
//       } else {
//         print('No image selected.');
//       }
//     });
//   }
//
//   int _selectedTabbar = 0;
//   bool isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     getBankDetails();
//     Future.delayed(Duration.zero, () {
//       setState(() {
//         details = widget.arguments;
//         // details = ModalRoute.of(context).settings.arguments;
//         amountController.text = details!['type'].toString() == "0"
//             ? details!["amount"].toString().split('.')[0]
//             : "";
//
//         schemetype = details!['schemetype'];
//         average = details!['average'];
//         currentstatus = details!['currentstatus'];
//       });
//     });
//     selectedRadio = 0;
//   }
//
//   Future<void> getBankDetails() async {
//     try {
//       Loading.show(context);
//       isLoading = true;
//       //    showLoading(context);
//       Bankdetailsmodel bankdetails = await Branchdetailservice.getBankDetails();
//       setState(() {
//         bankdDetails = bankdetails;
//       });
//       print(bankdetails);
//       isbankdetailsPresent =
//           bankdDetails!.data.bankDetails.isEmpty ? false : true;
//
//       isUpiPresent = bankdDetails!.data.upiDetails.isEmpty ? false : true;
//
//       if (isbankdetailsPresent && isUpiPresent) {
//         tablength = 2;
//       } else {
//         tablength = 1;
//       }
//
//       Loading.dismiss();
//       setState(() {
//         isLoading = false;
//       });
//
//       Loading.dismiss();
//     } catch (e) {
//       isLoading = true;
//       print(e);
//       Loading.dismiss();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: isLoading
//           ? Container()
//           : Scaffold(
//               extendBody: true,
//               backgroundColor: darkmode == true ? bg : Colors.white,
//               appBar: AppBar(
//                 backgroundColor: Colors.white,
//                 leading: IconButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     icon: const Icon(
//                       Icons.arrow_back,
//                       size: 25,
//                       color: Colors.black,
//                     )),
//                 title: Text("Payment Details", style: appbarStyle),
//               ),
//               body: details == null
//                   ? Container()
//                   : ListView.builder(
//                       scrollDirection: Axis.vertical,
//                       physics: const BouncingScrollPhysics(),
//                       shrinkWrap: true,
//                       itemCount: bankdDetails!.data.bankDetails.length,
//                       itemBuilder: (context, index) {
//                         return Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 15, vertical: 10),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               FittedBox(
//                                 child: Text(
//                                   "Send money through Bank or UPI ID and send the screenshot",
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     color: darkmode == true
//                                         ? Colors.white
//                                         : Colors.black,
//                                     decoration: TextDecoration.underline,
//                                   ),
//                                 ),
//                               ),
//                               h(15),
//                               Row(
//                                 children: [
//                                   Image.asset("assets/upi.png", height: 15),
//                                   w(10),
//                                   Text(
//                                     "UPI ID DETAILS",
//                                     style: TextStyle(
//                                       fontSize: 13,
//                                       color: darkmode == true
//                                           ? Colors.white
//                                           : Colors.black,
//                                     ),
//                                   )
//                                 ],
//                               ),
//                               h(15),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   PaymentButtons("assets/gpay.png",
//                                       "Google Pay", Colors.white, () {
//                                     upiAlertImg(index, "assets/gpayLogo.png",
//                                         () async {
//                                       Clipboard.setData(ClipboardData(
//                                           text: bankdDetails!.data.upiDetails
//                                               .elementAt(index)
//                                               .upiId!));
//                                       showToast("Upi id copied");
//                                       await LaunchApp.openApp(
//                                           androidPackageName:
//                                               'com.google.android.apps.nbu.paisa.user',
//                                           iosUrlScheme: 'gpay://',
//                                           appStoreLink:
//                                               'itms-apps://itunes.apple.com/us/app/pulse-secure/id945832041',
//                                           openStore: true);
//                                     });
//                                   }),
//                                   PaymentButtons("assets/phonepe.png",
//                                       "PhonePe", const Color(0xff5f259f), () {
//                                     upiAlertImg(index, "assets/phonepeLogo.png",
//                                         () async {
//                                       Clipboard.setData(ClipboardData(
//                                           text: bankdDetails!.data.upiDetails
//                                               .elementAt(index)
//                                               .upiId!));
//                                       showToast("Upi id copied");
//                                       await LaunchApp.openApp(
//                                           androidPackageName: 'com.phonepe.app',
//                                           iosUrlScheme: 'phonepe://',
//                                           appStoreLink:
//                                               'https://apps.apple.com/in/app/phonepe-secure-payments-app/id1170055821',
//                                           openStore: true);
//                                     });
//                                   }),
//                                   PaymentButtons(
//                                     "assets/paytm.png",
//                                     "Paytm",
//                                     Colors.white,
//                                     () {
//                                       upiAlertImg(index, "assets/paytmLogo.png",
//                                           () async {
//                                         Clipboard.setData(ClipboardData(
//                                             text: bankdDetails!.data.upiDetails
//                                                 .elementAt(index)
//                                                 .upiId!));
//                                         showToast("Upi id copied");
//                                         await LaunchApp.openApp(
//                                             androidPackageName:
//                                                 'net.one97.paytm',
//                                             iosUrlScheme: 'paytm://',
//                                             appStoreLink:
//                                                 'https://apps.apple.com/in/app/paytm-secure-upi-payments/id473941634',
//                                             openStore: true);
//                                       });
//                                     },
//                                   ),
//                                 ],
//                               ),
//                               h(20),
//                               Divider(
//                                   color: darkmode == true
//                                       ? Colors.grey[800]
//                                       : Colors.grey[300],
//                                   thickness: 8),
//                               h(10),
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 15),
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Icon(
//                                       FontAwesomeIcons.landmark,
//                                       size: 18,
//                                       color: darkmode == true
//                                           ? Colors.white
//                                           : Colors.black,
//                                     ),
//                                     w(10),
//                                     Text(
//                                       "Bank Details".toUpperCase(),
//                                       style: TextStyle(
//                                           fontSize: 12,
//                                           color: darkmode == true
//                                               ? Colors.white
//                                               : Colors.black,
//                                           fontWeight: FontWeight.w500),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     vertical: 8, horizontal: 15),
//                                 child: Text(
//                                   bankdDetails!.data.bankDetails
//                                       .elementAt(index)
//                                       .bankName!,
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     color: darkmode == true
//                                         ? Colors.white
//                                         : Colors.black,
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 10),
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                       border:
//                                           Border.all(color: Colors.grey[300]!),
//                                       borderRadius: BorderRadius.circular(15)),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(15),
//                                     child: Column(
//                                       children: [
//                                         copyFields(
//                                           "Beneficiary Name",
//                                           bankdDetails!.data.bankDetails
//                                               .elementAt(index)
//                                               .beneficiaryName!,
//                                           () {
//                                             Clipboard.setData(ClipboardData(
//                                                 text: bankdDetails!
//                                                     .data.bankDetails
//                                                     .elementAt(index)
//                                                     .beneficiaryName!));
//                                             showToast(
//                                                 "Beneficiary Name copied");
//                                           },
//                                         ),
//                                         const Divider(color: Colors.grey),
//                                         copyFields(
//                                           "Account Number",
//                                           bankdDetails!.data.bankDetails
//                                               .elementAt(index)
//                                               .accNo!,
//                                           () {
//                                             Clipboard.setData(ClipboardData(
//                                                 text: bankdDetails!
//                                                     .data.bankDetails
//                                                     .elementAt(index)
//                                                     .accNo!));
//                                             showToast("Account number copied");
//                                           },
//                                         ),
//                                         const Divider(color: Colors.grey),
//                                         copyFields(
//                                           "Branch IFSC Code",
//                                           bankdDetails!.data.bankDetails
//                                               .elementAt(index)
//                                               .ifscCode!,
//                                           () {
//                                             Clipboard.setData(ClipboardData(
//                                                 text: bankdDetails!
//                                                     .data.bankDetails
//                                                     .elementAt(index)
//                                                     .ifscCode!));
//                                             showToast("Branch IFSC copied");
//                                           },
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//               bottomNavigationBar: Container(
//                 height: 70,
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
//                   child: GestureDetector(
//                     onTap: () {
//                       uploadAlert();
//                     },
//                     child: Container(
//                         alignment: Alignment.center,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(30)),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Text(
//                               "UPLOAD SCREENSHOT",
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w500),
//                             ),
//                             w(10),
//                             const Icon(Icons.upload,
//                                 color: Colors.black, size: 18)
//                           ],
//                         )),
//                   ),
//                 ),
//               ),
//             ),
//     );
//   }
//
//   void pay(String amount, String gram) async {
//     // if (paymentmethod == 0) {
//     //   showToast("Please provide a payment method");
//     // } else {
//     Map sendvalues = {
//       'UserId': await getSavedObject('userid'),
//       'SheduledDateId': details!["SheduledDateId"],
//       'gram': gram,
//       'amount': amount,
//       'taransactionId': transidController.text.toString().compareTo("") == 0
//           ? "nil"
//           : transidController.text.toString(),
//       'subscriptionId': await getSavedObject('subscription'),
//       'paidBy': await getSavedObject('userid'),
//       'payment_method': paymentmethod,
//       'screenshot': _image == null ? null : _image!.path
//     };
//     try {
//       Loading.show(context);
//       Userpaymodel datas = await Paymentservice.userpay(sendvalues);
//       print("Reached here");
//       Loading.dismiss();
//       Navigate.pushAndRemoveUntil(context, BottomNav());
//       // Navigator.pop(context);
//       // exitt();
//     } catch (e) {
//       // showErrorMessage(e);
//       Loading.dismiss();
//       print(e);
//       //  Navigator.pop(context);
//     }
//     // }
//   }
//
//   void upiAlertImg(index, String icn, GestureTapCallback onTapp) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         elevation: 10,
//         titlePadding: EdgeInsets.zero,
//         actionsPadding: const EdgeInsets.only(bottom: 20, top: 20),
//         actions: [
//           InkWell(
//             onTap: onTapp,
//             child: Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 30),
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(30),
//                     color: const Color(0xffFFCF6B)),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 10),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text(
//                         "Open",
//                         style: TextStyle(fontSize: 10),
//                       ),
//                       Image.asset(
//                         icn,
//                         height: 30,
//                         width: 40,
//                         fit: BoxFit.scaleDown,
//                       )
//                     ],
//                   ),
//                 )),
//           )
//         ],
//         title: Row(
//           children: [
//             IconButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 icon: const Icon(Icons.close)),
//             const Spacer()
//           ],
//         ),
//         content: StreamBuilder<Object>(
//             stream: null,
//             builder: (context, snapshot) {
//               return Wrap(
//                 alignment: WrapAlignment.center,
//                 runSpacing: 10,
//                 // crossAxisAlignment: CrossAxisAlignment.start,
//                 // mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const FittedBox(child: Text(storeName)),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Icon(FontAwesomeIcons.landmark, size: 18),
//                       w(10),
//                       Text(bankdDetails!.data.bankDetails
//                           .elementAt(index)
//                           .bankName!),
//                     ],
//                   ),
//                   // bankdDetails.data.upiDetails.elementAt(index).image != null
//                   //     ? Image.network(
//                   //     ApiConfigs.imageurls +
//                   //         bankdDetails.data.upiDetails
//                   //             .elementAt(index)
//                   //             .image,
//                   //     height: 200,
//                   //     width: 200)
//                   //     : Image.asset("assets/qr.png")
//                   // Text("QR Not available")
//                   // ,
//                   Text(
//                     bankdDetails!.data.upiDetails.elementAt(index).upiId != null
//                         ? "UPI Id: ${bankdDetails!.data.upiDetails.elementAt(index).upiId}"
//                         : "UPI Id not available",
//                     style: const TextStyle(fontSize: 12),
//                   ),
//                 ],
//               );
//             }),
//       ),
//     );
//   }
//
//   void uploadAlert() {
//     showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (context) {
//         return StatefulBuilder(builder: (context, setState) {
//           return WillPopScope(
//             onWillPop: () async {
//               _image = null;
//               setState(() {});
//               Navigator.pop(context);
//               return true; // Ensure a boolean value is returned
//             },
//             child: AlertDialog(
//               // insetPadding: EdgeInsets.zero,
//               actions: [
//                 GestureDetector(
//                   onTap: () {
//                     print(amountController.text.length);
//                     if (details!["type"] == 0) {
//                       if (_image == null || amountController.text.isEmpty) {
//                         // if (transidController.text.toString().compareTo("") ==
//                         //     0) {
//                         //   showToast(
//                         //       "Please provide a screenshot of transaction to continue");
//                         // } else {
//                         //   pay(amountController.text.toString(), details['gram']);
//                         // }
//                         showToastCenter(
//                             "Please input amount & provide a screenshot of transaction to continue");
//                       } else {
//                         pay(amountController.text.toString(), details!['gram']);
//                       }
//                     } else {
//                       if (_image == null || amountController.text.isEmpty) {
//                         showToastCenter(
//                             "Please input amount & provide a screenshot of transaction to continue");
//                       } else {
//                         if (schemetype.toString().compareTo("1") == 0) {
//                           if (currentstatus.toString().compareTo("dialy") ==
//                               0) {
//                             pay(amountController.text.toString(), finalgram);
//                           }
//
//                           if (currentstatus.toString().compareTo("dialy") !=
//                               0) {
//                             pay(amountController.text.toString(), finalgram);
//                           }
//                         } else {
//                           try {
//                             if (_image == null) {
//                               if (transidController.text
//                                       .toString()
//                                       .compareTo("") ==
//                                   0) {
//                                 showToastCenter(
//                                     "Please provide a Transaction id or screenshot");
//                               } else {
//                                 pay(amountController.text.toString(),
//                                     finalgram);
//                               }
//                             } else {
//                               pay(amountController.text.toString(), finalgram);
//                             }
//                           } catch (e) {
//                             showToastCenter(
//                                 "Please enter amount with in range");
//                           }
//                         }
//                       }
//                     }
//                   },
//                   child: Container(
//                       margin: const EdgeInsets.symmetric(horizontal: 20),
//                       alignment: Alignment.center,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(30),
//                           color: themeClr),
//                       child: const Padding(
//                         padding: EdgeInsets.symmetric(vertical: 10),
//                         child: Text(
//                           "SEND",
//                           style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.white,
//                               fontWeight: FontWeight.w500),
//                         ),
//                       )),
//                 )
//               ],
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12)),
//               titlePadding: const EdgeInsets.symmetric(vertical: 20),
//               actionsPadding: const EdgeInsets.only(bottom: 20),
//               title: Row(
//                 children: [
//                   IconButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                         // amountController.clear();
//                         setState(() {
//                           _image = null;
//                         });
//                       },
//                       icon: const Icon(Icons.close, color: Colors.black)),
//                   // ToggleSwitch(
//                   //   minHeight: 25,
//                   //   minWidth: 98,
//                   //   fontSize: 10,
//                   //   initialLabelIndex: 0,
//                   //   activeBgColor: [accentClr],
//                   //   activeFgColor: Colors.white,
//                   //   inactiveBgColor: Colors.grey[200],
//                   //   inactiveFgColor: Colors.black,
//                   //   labels: ['Upi Transfer', 'Bank Transfer'],
//                   //   onToggle: (index) {
//                   //     if (index == 0) {
//                   //       paymentmethod = 1;
//                   //     } else {
//                   //       paymentmethod = 2;
//                   //     }
//                   //     print('switched to: $index');
//                   //   },
//                   // ),
//                 ],
//               ),
//               elevation: 10,
//               content: StreamBuilder<Object>(
//                   stream: null,
//                   builder: (context, snapshot) {
//                     return Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         TextFormField(
//                           autofocus: true,
//                           enabled: (details!["type"]) == 0 ? false : true,
//                           controller: amountController,
//                           style: const TextStyle(fontSize: 30),
//                           keyboardType: TextInputType.number,
//                           textAlign: TextAlign.center,
//                           decoration: InputDecoration(
//                               border: InputBorder.none,
//                               prefixStyle: const TextStyle(
//                                   fontSize: 30, color: Colors.black),
//                               counterText: "",
//                               contentPadding: EdgeInsets.zero,
//                               isDense: true,
//                               hintStyle: TextStyle(
//                                   fontSize: 30, color: Colors.grey[500]),
//                               hintText: '${rs}0'),
//                           maxLength: 8,
//                           onChanged: (value) {
//                             setState(() {
//                               print("${value}test");
//                               if (value.isEmpty) {
//                                 gram = 0;
//                                 finalgram = "";
//                               } else {
//                                 gram = double.parse(value) /
//                                     double.parse(
//                                         details!['todaysrate'].toString());
//                                 finalgram = gram.toStringAsFixed(3);
//                               }
//                             });
//                           },
//                         ),
//                         h(10),
//                         (_image == null)
//                             ? InkWell(
//                                 onTap: () {
//                                   setState(() {});
//                                   getImage(setState);
//                                 },
//                                 child: Container(
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(30),
//                                         color: const Color(0xffE3E3E3)),
//                                     child: Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                           vertical: 10, horizontal: 15),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           const Text(
//                                             "Upload Screenshot",
//                                             style: TextStyle(fontSize: 14),
//                                           ),
//                                           w(5),
//                                           const Icon(Icons.file_upload_outlined,
//                                               size: 18)
//                                         ],
//                                       ),
//                                     )),
//                               )
//                             : Container(
//                                 width: MediaQuery.of(context).size.width - 20,
//                                 height: 100,
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                     color: ColorUtil.fromHex("#EAEAEA"),
//                                   ),
//                                   borderRadius: const BorderRadius.all(
//                                       Radius.circular(5)),
//                                   image: DecorationImage(
//                                     image: FileImage(File(_image!.path)),
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                                 child: Align(
//                                   alignment: Alignment.topRight,
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       setState(() {
//                                         _image = null;
//                                       });
//                                     },
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                         borderRadius: const BorderRadius.only(
//                                             bottomLeft: Radius.circular(30)),
//                                         color: Colors.grey[500],
//                                       ),
//                                       child: const Padding(
//                                         padding: EdgeInsets.only(
//                                             left: 8,
//                                             bottom: 8,
//                                             top: 5,
//                                             right: 5),
//                                         child: Icon(Icons.close,
//                                             size: 15, color: Colors.white),
//                                       ),
//                                       // child: IconButton(
//                                       //   icon: Icon(Icons.close),
//                                       //   onPressed: () {
//                                       //     setState(() {
//                                       //       _image = null;
//                                       //     });
//                                       //   },
//                                       // ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                       ],
//                     );
//                   }),
//             ),
//           );
//         });
//       },
//     );
//   }
// ////////////////paytm
// //  void generateTxnToken(int mode) async {
// //     setState(() {
// //       loading = true;
// //     });
// //     String orderId = DateTime.now().millisecondsSinceEpoch.toString();
//
// //     String callBackUrl = (testing
// //             ? 'https://securegw-stage.paytm.in'
// //             : 'https://securegw.paytm.in') +
// //         '/theia/paytmCallback?ORDER_ID=' +
// //         orderId;
//
// //     //Host the Server Side Code on your Server and use your URL here. The following URL may or may not work. Because hosted on free server.
// //     //Server Side code url: https://github.com/mrdishant/Paytm-Plugin-Server
// //     var url = 'https://desolate-anchorage-29312.herokuapp.com/generateTxnToken';
//
// //     var body = json.encode({
// //       "mid": mid,
// //       "key_secret": PAYTM_MERCHANT_KEY,
// //       "website": website,
// //       "orderId": orderId,
// //       "amount": amount.toString(),
// //       "callbackUrl": callBackUrl,
// //       "custId": "122",
// //       "mode": mode.toString(),
// //       "testing": testing ? 0 : 1
// //     });
//
// //     try {
// //       final response = await http.post(
// //         Uri.parse(url),
// //         body: body,
// //         headers: {'Content-type': "application/json"},
// //       );
// //       print("Response is");
// //       print(response.body);
// //       String txnToken = response.body;
// //       setState(() {
// //         payment_response = txnToken;
// //       });
//
// //       var paytmResponse = Paytm.payWithPaytm(
// //           mid, orderId, txnToken, amount.toString(), callBackUrl, testing);
//
// //       paytmResponse.then((value) {
// //         print(value);
// //         setState(() {
// //           loading = false;
// //           print("Value is ");
// //           print(value);
// //           if (value['error']) {
// //             payment_response = value['errorMessage'];
// //           } else {
// //             if (value['response'] != null) {
// //               payment_response = value['response']['STATUS'];
// //             }
// //           }
// //           payment_response += "\n" + value.toString();
// //         });
// //       });
// //     } catch (e) {
// //       print(e);
// //     }
// //   }
//
//   // _openJioSavaan(data) async {
//   //   String dt = data['JioSavaan'] as String;
//   //   bool isInstalled =
//   //       await DeviceApps.isAppInstalled('com.jio.media.jiobeats');
//   //   if (isInstalled != false) {
//   //     AndroidIntent intent = AndroidIntent(action: 'action_view', data: dt);
//   //     await intent.launch();
//   //   } else {
//   //     String url = dt;
//   //     if (await canLaunch(url))
//   //       await launch(url);
//   //     else
//   //       throw 'Could not launch $url';
//   //   }
//   // }
// }
