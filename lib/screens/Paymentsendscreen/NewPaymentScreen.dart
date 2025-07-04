import 'dart:io';

import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stjewellery/Constant/constants.dart';
import 'package:stjewellery/Utils/Utils.dart';
import 'package:stjewellery/model/Bankdetailsmodel.dart';
import 'package:stjewellery/model/userpaymodel.dart';
import 'package:stjewellery/screens/Paymentsendscreen/newWidgetsPaymentPage.dart';
import 'package:stjewellery/service/Paymentservice.dart';
import 'package:stjewellery/service/bankdetailsservice.dart';
import 'package:url_launcher/url_launcher.dart';

class NewPaymentScreen extends StatefulWidget {
  final arguments;
  const NewPaymentScreen({Key? key, required this.arguments}) : super(key: key);

  @override
  State<NewPaymentScreen> createState() => _NewPaymentScreenState();
}

class _NewPaymentScreenState extends State<NewPaymentScreen> {
  Bankdetailsmodel? bankdDetails;
  Map? details;
  TextEditingController amountController = TextEditingController();
  TextEditingController transidController = TextEditingController();
  String? schemetype;
  String? currentstatus;
  String finalgram = "";
  File? _image;
  double gram = 0;
  final picker = ImagePicker();
  int paymentmethod = 1;
  int? selectedRadio;
  String? average;

  void openGooglePay(int index, String upiId) async {
    Clipboard.setData(ClipboardData(text: upiId));
    showToast("UPI ID copied");
    final Uri gpayUri = Uri.parse("gpay://");

    if (Platform.isIOS) {
      if (await canLaunchUrl(gpayUri)) {
        await launchUrl(gpayUri);
      } else {
        await launchUrl(
          Uri.parse(
            "https://apps.apple.com/in/app/google-pay-save-pay-manage/id1193357041",
          ),
          mode: LaunchMode.externalApplication,
        );
      }
    } else {
      try {
        await LaunchApp.openApp(
          androidPackageName: 'com.google.android.apps.nbu.paisa.user',
          openStore: true, // Opens Play Store if Google Pay is not installed
        );
      } catch (e) {
        final Uri playStoreUri = Uri.parse(
          "https://play.google.com/store/apps/details?id=com.google.android.apps.nbu.paisa.user",
        );
        await launchUrl(playStoreUri, mode: LaunchMode.externalApplication);
      }
    }
  }

  void openPhonePe(int index, String upiId) async {
    Clipboard.setData(ClipboardData(text: upiId));
    showToast("UPI ID copied");
    final Uri phonePeUri = Uri.parse("phonepe://");
    if (Platform.isIOS) {
      if (await canLaunchUrl(phonePeUri)) {
        await launchUrl(phonePeUri);
      } else {
        await launchUrl(
          Uri.parse(
            "https://apps.apple.com/in/app/phonepe-secure-payments-app/id1170055821",
          ),
          mode: LaunchMode.externalApplication,
        );
      }
    } else {
      try {
        await LaunchApp.openApp(
          androidPackageName: 'com.phonepe.app',
          openStore: true, // Opens Play Store if Google Pay is not installed
        );
      } catch (e) {
        final Uri playStoreUri = Uri.parse(
          "https://play.google.com/store/apps/details?id=com.phonepe.app",
        );
        await launchUrl(playStoreUri, mode: LaunchMode.externalApplication);
      }
    }
  }

  void openPaytm(int index, String upiId) async {
    Clipboard.setData(ClipboardData(text: upiId));
    showToast("UPI ID copied");

    final Uri paytmUri = Uri.parse("paytm://");
    if (Platform.isIOS) {
      if (await canLaunchUrl(paytmUri)) {
        await launchUrl(paytmUri);
      } else {
        await launchUrl(
          Uri.parse(
            "https://apps.apple.com/in/app/paytm-secure-upi-payments/id473941634",
          ),
          mode: LaunchMode.externalApplication,
        );
      }
    } else {
      try {
        await LaunchApp.openApp(
          androidPackageName: 'net.one97.paytm',
          openStore: true, // Opens Play Store if Google Pay is not installed
        );
      } catch (e) {
        final Uri playStoreUri = Uri.parse(
          "https://play.google.com/store/apps/details?id=net.one97.paytm",
        );
        await launchUrl(playStoreUri, mode: LaunchMode.externalApplication);
      }
    }
  }

  Future getImage(setState) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        setState(() {});
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      getBankDetails();
      Future.delayed(Duration.zero, () {
        setState(() {
          details = widget.arguments;
          amountController.text = details!['type'].toString() == "0"
              ? details!["amount"].toString().split('.')[0]
              : "";

          schemetype = details!['schemetype'];
          average = details!['average'];
          currentstatus = details!['currentstatus'];
        });
      });
      selectedRadio = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(title: Text("Payment Details", style: appbarStyle)),
            body: details == null
                ? Container()
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: bankdDetails!.data.bankDetails.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const FittedBox(
                              child: Text(
                                "Send money through Bank or UPI ID and send the screenshot",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            h(15),
                            Row(
                              children: [
                                Image.asset("assets/upi.png", height: 15),
                                w(10),
                                const Text(
                                  "UPI ID DETAILS",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            h(15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                PaymentButtons(
                                  "assets/gpay.png",
                                  "Google Pay",
                                  Colors.white,
                                  () {
                                    upiAlertImg(
                                      index,
                                      "assets/gpay.png",
                                      () async {
                                        openGooglePay(
                                          index,
                                          bankdDetails!.data.upiDetails
                                              .elementAt(index)
                                              .upiId!,
                                        );
                                      },
                                    );
                                  },
                                ),
                                PaymentButtons(
                                  "assets/phonepe.png",
                                  "PhonePe",
                                  const Color(0xff5f259f),
                                  () {
                                    upiAlertImg(
                                      index,
                                      "assets/phonepe.png",
                                      () async {
                                        openPhonePe(
                                          index,
                                          bankdDetails!.data.upiDetails
                                              .elementAt(index)
                                              .upiId!,
                                        );
                                      },
                                    );
                                  },
                                ),
                                PaymentButtons(
                                  "assets/paytm.png",
                                  "Paytm",
                                  Colors.white,
                                  () {
                                    upiAlertImg(
                                      index,
                                      "assets/paytm.png",
                                      () async {
                                        openPaytm(
                                          index,
                                          bankdDetails!.data.upiDetails
                                              .elementAt(index)
                                              .upiId!,
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                            h(20),
                            Divider(color: Colors.grey[300], thickness: 8),
                            h(10),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    FontAwesomeIcons.landmark,
                                    size: 18,
                                    color: Colors.black,
                                  ),
                                  w(10),
                                  Text(
                                    "Bank Details".toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 15,
                              ),
                              child: Text(
                                bankdDetails!.data.bankDetails
                                    .elementAt(index)
                                    .bankName!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[300]!),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    children: [
                                      copyFields(
                                        "Beneficiary Name",
                                        bankdDetails!.data.bankDetails
                                            .elementAt(index)
                                            .beneficiaryName!,
                                        () {
                                          Clipboard.setData(
                                            ClipboardData(
                                              text: bankdDetails!
                                                  .data
                                                  .bankDetails
                                                  .elementAt(index)
                                                  .beneficiaryName!,
                                            ),
                                          );
                                          showToast("Beneficiary Name copied");
                                        },
                                      ),
                                      const Divider(color: Colors.grey),
                                      copyFields(
                                        "Account Number",
                                        bankdDetails!.data.bankDetails
                                            .elementAt(index)
                                            .accNo!,
                                        () {
                                          Clipboard.setData(
                                            ClipboardData(
                                              text: bankdDetails!
                                                  .data
                                                  .bankDetails
                                                  .elementAt(index)
                                                  .accNo!,
                                            ),
                                          );
                                          showToast("Account number copied");
                                        },
                                      ),
                                      const Divider(color: Colors.grey),
                                      copyFields(
                                        "Branch IFSC Code",
                                        bankdDetails!.data.bankDetails
                                            .elementAt(index)
                                            .ifscCode!,
                                        () {
                                          Clipboard.setData(
                                            ClipboardData(
                                              text: bankdDetails!
                                                  .data
                                                  .bankDetails
                                                  .elementAt(index)
                                                  .ifscCode!,
                                            ),
                                          );
                                          showToast("Branch IFSC copied");
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
            bottomNavigationBar: Container(
              margin: EdgeInsets.only(bottom: 30),
              height: 70,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 25,
                ),
                child: GestureDetector(
                  onTap: () {
                    uploadAlert();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26, width: 2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "UPLOAD SCREENSHOT",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        w(10),
                        const Icon(Icons.upload, color: Colors.black, size: 18),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  void upiAlertImg(index, String icn, GestureTapCallback onTapp) {
    {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 10,
          titlePadding: EdgeInsets.zero,
          actionsPadding: const EdgeInsets.only(bottom: 20, top: 20),
          actions: [
            InkWell(
              onTap: onTapp,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color(0xffFFCF6B),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Open",
                        style: font(14, Colors.black, FontWeight.w500),
                      ),
                      w(5),
                      Image.asset(
                        icn,
                        height: 30,
                        width: 40,
                        fit: BoxFit.scaleDown,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
          title: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close),
              ),
              const Spacer(),
            ],
          ),
          content: StreamBuilder<Object>(
            stream: null,
            builder: (context, snapshot) {
              return Wrap(
                alignment: WrapAlignment.center,
                runSpacing: 10,
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  FittedBox(
                    child: Text(
                      storeName,
                      style: font(17, Colors.black, FontWeight.w500),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Icon(FontAwesomeIcons.landmark, size: 18),
                      w(10),
                      Text(
                        bankdDetails!.data.bankDetails
                            .elementAt(index)
                            .bankName!,
                        style: font(15, Colors.black, FontWeight.w600),
                      ),
                    ],
                  ),
                  // bankdDetails.data.upiDetails.elementAt(index).image != null
                  //     ? Image.network(
                  //     ApiConfigs.imageurls +
                  //         bankdDetails.data.upiDetails
                  //             .elementAt(index)
                  //             .image,
                  //     height: 200,
                  //     width: 200)
                  //     : Image.asset("assets/qr.png")
                  // Text("QR Not available")
                  // ,
                  Text(
                    bankdDetails!.data.upiDetails.elementAt(index).upiId != null
                        ? "UPI Id ${bankdDetails!.data.upiDetails.elementAt(index).upiId}"
                        : "UPI Id not available",
                    style: font(15, Colors.black, FontWeight.w600),
                  ),
                ],
              );
            },
          ),
        ),
      );
    }
  }

  void uploadAlert() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return WillPopScope(
              onWillPop: () async {
                _image = null;
                setState(() {});
                Navigator.pop(context);
                return true; // Ensure a boolean value is returned
              },
              child: AlertDialog(
                // insetPadding: EdgeInsets.zero,
                actions: [
                  GestureDetector(
                    onTap: () {
                      print(amountController.text.length);
                      if (details!["type"] == 0) {
                        if (_image == null || amountController.text.isEmpty) {
                          // if (transidController.text.toString().compareTo("") ==
                          //     0) {
                          //   showToast(
                          //       "Please provide a screenshot of transaction to continue");
                          // } else {
                          //   pay(amountController.text.toString(), details['gram']);
                          // }
                          showToastCenter(
                            "Please input amount & provide a screenshot of transaction to continue",
                          );
                        } else {
                          pay(
                            amountController.text.toString(),
                            details!['gram'],
                          );
                        }
                      } else {
                        if (_image == null || amountController.text.isEmpty) {
                          showToastCenter(
                            "Please input amount & provide a screenshot of transaction to continue",
                          );
                        } else {
                          if (schemetype.toString().compareTo("1") == 0) {
                            if (currentstatus.toString().compareTo("dialy") ==
                                0) {
                              pay(amountController.text.toString(), finalgram);
                            }

                            if (currentstatus.toString().compareTo("dialy") !=
                                0) {
                              pay(amountController.text.toString(), finalgram);
                            }
                          } else {
                            try {
                              if (_image == null) {
                                if (transidController.text.toString().compareTo(
                                      "",
                                    ) ==
                                    0) {
                                  showToastCenter(
                                    "Please provide a Transaction id or screenshot",
                                  );
                                } else {
                                  pay(
                                    amountController.text.toString(),
                                    finalgram,
                                  );
                                }
                              } else {
                                pay(
                                  amountController.text.toString(),
                                  finalgram,
                                );
                              }
                            } catch (e) {
                              showToastCenter(
                                "Please enter amount with in range",
                              );
                            }
                          }
                        }
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: themeClr,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "SEND",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                titlePadding: const EdgeInsets.symmetric(vertical: 20),
                actionsPadding: const EdgeInsets.only(bottom: 20),
                title: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // amountController.clear();
                        setState(() {
                          _image = null;
                        });
                      },
                      icon: const Icon(Icons.close, color: Colors.black),
                    ),
                    // ToggleSwitch(
                    //   minHeight: 25,
                    //   minWidth: 98,
                    //   fontSize: 10,
                    //   initialLabelIndex: 0,
                    //   activeBgColor: [accentClr],
                    //   activeFgColor: Colors.white,
                    //   inactiveBgColor: Colors.grey[200],
                    //   inactiveFgColor: Colors.black,
                    //   labels: ['Upi Transfer', 'Bank Transfer'],
                    //   onToggle: (index) {
                    //     if (index == 0) {
                    //       paymentmethod = 1;
                    //     } else {
                    //       paymentmethod = 2;
                    //     }
                    //     print('switched to: $index');
                    //   },
                    // ),
                  ],
                ),
                elevation: 10,
                content: StreamBuilder<Object>(
                  stream: null,
                  builder: (context, snapshot) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          autofocus: true,
                          enabled: (details!["type"]) == 0 ? false : true,
                          controller: amountController,
                          style: const TextStyle(fontSize: 30),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixStyle: const TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                            ),
                            counterText: "",
                            contentPadding: EdgeInsets.zero,
                            isDense: true,
                            hintStyle: TextStyle(
                              fontSize: 30,
                              color: Colors.grey[500],
                            ),
                            hintText: '${rs}0',
                          ),
                          maxLength: 8,
                          onChanged: (value) {
                            setState(() {
                              print("${value}test");
                              if (value.isEmpty) {
                                gram = 0;
                                finalgram = "";
                              } else {
                                gram =
                                    double.parse(value) /
                                    double.parse(
                                      details!['todaysrate'].toString(),
                                    );
                                finalgram = gram.toStringAsFixed(3);
                              }
                            });
                          },
                        ),
                        h(10),
                        (_image == null)
                            ? InkWell(
                                onTap: () {
                                  setState(() {});
                                  getImage(setState);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black12),
                                    borderRadius: BorderRadius.circular(30),
                                    color: const Color(0xffE3E3E3),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 15,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "Upload Screenshot",
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        w(5),
                                        const Icon(
                                          Icons.file_upload_outlined,
                                          size: 18,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                width: MediaQuery.of(context).size.width - 20,
                                height: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: ColorUtil.fromHex("#EAEAEA"),
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                  image: DecorationImage(
                                    image: FileImage(File(_image!.path)),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _image = null;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(30),
                                        ),
                                        color: Colors.grey[500],
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.only(
                                          left: 8,
                                          bottom: 8,
                                          top: 5,
                                          right: 5,
                                        ),
                                        child: Icon(
                                          Icons.close,
                                          size: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                      // child: IconButton(
                                      //   icon: Icon(Icons.close),
                                      //   onPressed: () {
                                      //     setState(() {
                                      //       _image = null;
                                      //     });
                                      //   },
                                      // ),
                                    ),
                                  ),
                                ),
                              ),
                        const SizedBox(height: 10),
                      ],
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  void pay(String amount, String gram) async {
    // if (paymentmethod == 0) {
    //   showToast("Please provide a payment method");
    // } else {
    Map sendvalues = {
      'UserId': await getSavedObject('userid'),
      'SheduledDateId': details!["SheduledDateId"],
      'gram': gram,
      'amount': amount,
      'taransactionId': transidController.text.toString().compareTo("") == 0
          ? "nil"
          : transidController.text.toString(),
      'subscriptionId': await getSavedObject('subscription'),
      'paidBy': await getSavedObject('userid'),
      'payment_method': paymentmethod,
      'screenshot': _image == null ? null : _image!.path,
    };
    try {
      Loading.show(context);
      Userpaymodel datas = await Paymentservice.userpay(sendvalues);
      print("Reached here");
      Loading.dismiss();
      Navigator.pop(context);
      // exitt();
    } catch (e) {
      // showErrorMessage(e);
      Loading.dismiss();
      print(e);
      //  Navigator.pop(context);
    }
    // }
  }

  bool isbankdetailsPresent = true;
  bool isLoading = false;
  bool isUpiPresent = true;
  int tablength = 0;

  Future<void> getBankDetails() async {
    try {
      Loading.show(context);
      isLoading = true;
      //    showLoading(context);
      Bankdetailsmodel bankdetails = await Branchdetailservice.getBankDetails();
      setState(() {
        bankdDetails = bankdetails;
      });
      print(bankdetails);
      isbankdetailsPresent = bankdDetails!.data.bankDetails.isEmpty
          ? false
          : true;

      isUpiPresent = bankdDetails!.data.upiDetails.isEmpty ? false : true;

      if (isbankdetailsPresent && isUpiPresent) {
        tablength = 2;
      } else {
        tablength = 1;
      }

      Loading.dismiss();
      setState(() {
        isLoading = false;
      });

      Loading.dismiss();
    } catch (e) {
      isLoading = true;
      print(e);
      Loading.dismiss();
    }
  }
}
