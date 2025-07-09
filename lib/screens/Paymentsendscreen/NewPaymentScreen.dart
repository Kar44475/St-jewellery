import 'dart:io';

import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stjewellery/Constant/constants.dart';
import 'package:stjewellery/Utils/utils.dart';
import 'package:stjewellery/model/Bankdetailsmodel.dart';
import 'package:stjewellery/model/userpaymodel.dart';
import 'package:stjewellery/screens/Paymentsendscreen/newWidgetsPaymentPage.dart';
import 'package:stjewellery/service/Paymentservice.dart';
import 'package:stjewellery/service/bank_details_service.dart';
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
          openStore: true,
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
          openStore: true,
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
          openStore: true,
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
            appBar: AppBar(
              title: Text("Payment Details"),

              elevation: 0,
              shadowColor: Colors.grey.withOpacity(0.1),
            ),
            body: details == null
                ? Container()
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: bankdDetails!.data.bankDetails.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.blue[50],
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.blue[100]!),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.info_outline,
                                      color: Colors.blue[600],
                                      size: 18,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        "Send money through Bank or UPI ID and send the screenshot",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.blue[700],
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),

                              // UPI Section
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.orange[50],
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.orange[100]!,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          "assets/upi.png",
                                          height: 20,
                                        ),
                                        const SizedBox(width: 12),
                                        Text(
                                          "UPI PAYMENT OPTIONS",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.orange[800],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        _buildPaymentButton(
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
                                        _buildPaymentButton(
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
                                        _buildPaymentButton(
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
                                  ],
                                ),
                              ),

                              const SizedBox(height: 24),

                              // Bank Details Section
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.green[50],
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.green[100]!),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.landmark,
                                          size: 18,
                                          color: Colors.green[700],
                                        ),
                                        const SizedBox(width: 12),
                                        Text(
                                          "BANK DETAILS",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.green[800],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      bankdDetails!.data.bankDetails
                                          .elementAt(index)
                                          .bankName!,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.green[800],
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Colors.grey[200]!,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          children: [
                                            _buildCopyField(
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
                                                showToast(
                                                  "Beneficiary Name copied",
                                                );
                                              },
                                            ),
                                            Divider(color: Colors.grey[200]),
                                            _buildCopyField(
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
                                                showToast(
                                                  "Account number copied",
                                                );
                                              },
                                            ),
                                            Divider(color: Colors.grey[200]),
                                            _buildCopyField(
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
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
            bottomNavigationBar: Container(
              margin: const EdgeInsets.all(20),
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  uploadAlert();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeClr,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "UPLOAD SCREENSHOT",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Icon(Icons.upload, size: 20),
                  ],
                ),
              ),
            ),
          );
  }

  Widget _buildPaymentButton(
    String iconPath,
    String label,
    Color bgColor,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(iconPath, height: 24, width: 24),
            const SizedBox(height: 6),
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCopyField(String label, String value, VoidCallback onCopy) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: onCopy,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.copy, size: 16, color: Colors.blue[600]),
          ),
        ),
      ],
    );
  }

  void upiAlertImg(index, String icn, GestureTapCallback onTapp) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 10,
        titlePadding: EdgeInsets.zero,
        actionsPadding: const EdgeInsets.only(bottom: 20, top: 20),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: onTapp,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffFFCF6B),
                foregroundColor: Colors.black,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Open",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    icn,
                    height: 24,
                    width: 24,
                    fit: BoxFit.scaleDown,
                  ),
                ],
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
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  storeName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(FontAwesomeIcons.landmark, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      bankdDetails!.data.bankDetails.elementAt(index).bankName!,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    bankdDetails!.data.upiDetails.elementAt(index).upiId != null
                        ? "UPI ID: ${bankdDetails!.data.upiDetails.elementAt(index).upiId}"
                        : "UPI ID not available",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
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
                return true;
              },
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                titlePadding: const EdgeInsets.all(20),
                actionsPadding: const EdgeInsets.only(
                  bottom: 20,
                  left: 20,
                  right: 20,
                ),
                title: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          _image = null;
                        });
                      },
                      icon: const Icon(Icons.close, color: Colors.black),
                    ),
                    const Spacer(),
                    const Text(
                      "Payment Details",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(width: 48),
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
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextFormField(
                            autofocus: true,
                            enabled: (details!["type"]) == 0 ? false : true,
                            controller: amountController,
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                            ),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixStyle: const TextStyle(
                                fontSize: 32,
                                color: Colors.black,
                              ),
                              counterText: "",
                              contentPadding: EdgeInsets.zero,
                              isDense: true,
                              hintStyle: TextStyle(
                                fontSize: 32,
                                color: Colors.grey[400],
                              ),
                              hintText: '${rs}0',
                            ),
                            maxLength: 8,
                            onChanged: (value) {
                              setState(() {
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
                        ),
                        const SizedBox(height: 20),
                        (_image == null)
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {});
                                  getImage(setState);
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey[300]!,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.blue[50],
                                  ),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.cloud_upload_outlined,
                                        size: 32,
                                        color: Colors.blue[600],
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        "Upload Screenshot",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.blue[700],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                width: double.infinity,
                                height: 120,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[300]!),
                                  borderRadius: BorderRadius.circular(12),
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
                                      margin: const EdgeInsets.all(8),
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: Colors.red[400],
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.close,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                        const SizedBox(height: 20),
                      ],
                    );
                  },
                ),
                actions: [
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (details!["type"] == 0) {
                          if (_image == null || amountController.text.isEmpty) {
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
                                pay(
                                  amountController.text.toString(),
                                  finalgram,
                                );
                              }
                              if (currentstatus.toString().compareTo("dialy") !=
                                  0) {
                                pay(
                                  amountController.text.toString(),
                                  finalgram,
                                );
                              }
                            } else {
                              try {
                                if (_image == null) {
                                  if (transidController.text
                                          .toString()
                                          .compareTo("") ==
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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themeClr,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "SEND",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void pay(String amount, String gram) async {
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
    } catch (e) {
      Loading.dismiss();
      print(e);
    }
  }

  bool isbankdetailsPresent = true;
  bool isLoading = false;
  bool isUpiPresent = true;
  int tablength = 0;

  Future<void> getBankDetails() async {
    try {
      Loading.show(context);
      isLoading = true;
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
