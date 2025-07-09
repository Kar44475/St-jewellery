import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stjewellery/Constant/constants.dart';
import 'package:stjewellery/support_widget/essential.dart';
import 'package:stjewellery/model/Recepitmodel.dart';
import 'package:stjewellery/service/Paymentdetailsserivce.dart';

class Receipt extends StatefulWidget {
  final arguments;
  const Receipt({Key? key, this.arguments}) : super(key: key);

  @override
  _ReceiptState createState() => _ReceiptState();
}

class _ReceiptState extends State<Receipt> {
  bool shares = false;
  Map? datas;
  String? gramrate;

  void getrole() async {
    int role = await getSavedObject("roleid");

    if (role != null) {
      if (role == 2 || role == 4) {
        setState(() {
          shares = false;
        });
      } else if (role == 3) {
        setState(() {
          shares = true;
        });
      }
    }
  }

  int? id;

  @override
  void initState() {
    getrole();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    id = widget.arguments;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, size: 20),
        ),
        title: Text("Receipt"),
      ),
      body: SafeArea(
        child: FutureBuilder(
          builder: (context, AsyncSnapshot<Recepitmodel> snapshot) {
            if (snapshot.hasData) {
              {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [h(10), testWidget(snapshot), h(10)],
                    ),
                  ),
                );
              }
            } else {
              return Container();
            }
          },
          future: getPaymentdetails(),
        ),
      ),
    );
  }

  var schemeIddd;
  Future<Recepitmodel> getPaymentdetails() async {
    schemeIddd = await getSavedObject("schemeIddd");

    Recepitmodel? datas;
    Map details = {
      'UserId': await getSavedObject("roleid") == 3
          ? await getSavedObject("customerid")
          : await getSavedObject('userid'),
      'SheduledDateId': id,
    };
    print(details);
    try {
      Loading.show(context);
      print(details);
      //    showLoading(context);
      datas = await Paymentdetailsservice.paymentDetails(details);
      print("Reached here");
      //  Navigator.of(context).pop(true);
      // showLoading(context);
      Loading.dismiss();

      try {
        gramrate = datas.data!.rate!.amount.toString();
      } catch (e) {
        gramrate = "";
      }

      //  totalpayment = data.data.sheduledList.length;
      return datas;
    } catch (e) {
      // showErrorMessage(e);
      Loading.dismiss();
      print(e);
      return datas!;
      //  Navigator.pop(context);
    }
  }

  Widget testWidget(snapshot) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
          child: Column(
            children: [
              Image.asset("assets/pngIcons/mainIcons.png", height: 60),
              h(10),

              Row(
                children: [
                  Spacer(),
                  Text(
                    "Date: ${DateFormat("dd-MM-yyyy").format(snapshot.data.data.paymentsDetails.paymentDate).toString().substring(0, 10)}",
                    style: font(12, Colors.black54, FontWeight.w400),
                  ),
                ],
              ),
              Row(
                children: List.generate(
                  150 ~/ 2,
                  (index) => Expanded(
                    child: Container(
                      color: index % 2 == 0
                          ? Colors.transparent
                          : Colors.grey[400],
                      height: 2,
                    ),
                  ),
                ),
              ),
              h(10),
              detail(
                "Name : ",
                snapshot.data.data.paymentsDetails.name.toString(),
              ),

              detail(
                "Registration Number : ",
                snapshot.data.data.paymentsDetails.registrationNumber,
              ),
              detail(
                "Phone : ",
                snapshot.data.data.paymentsDetails.phone.toString(),
              ),
              detail(
                "Subscription Scheme Id : ",
                "Sb-${snapshot.data.data.paymentsDetails.subscriptionId.toString().padLeft(5, '0')}",
              ),
              // detail("Transaction id : ",
              //     snapshot.data.data.paymentsDetails.taransactionId),
              detail(
                "Voucher number : ",
                snapshot.data.data.paymentsDetails.voucherNumber,
              ),
              h(10),
              // detail(
              //     "Date : ",
              //     DateFormat("dd-MM-yyyy")
              //         .format(snapshot.data.data.paymentsDetails.paymentDate)
              //         .toString()
              //         .substring(0, 10)),
              Row(
                children: List.generate(
                  150 ~/ 2,
                  (index) => Expanded(
                    child: Container(
                      color: index % 2 == 0
                          ? Colors.transparent
                          : Colors.grey[400],
                      height: 2,
                    ),
                  ),
                ),
              ),
              h(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  detail(
                    "Amount : ",
                    rs +
                        snapshot.data.data.paymentsDetails.amount.split('.')[0],
                  ),
                  snapshot.data.data.paymentsDetails.schemeName.toString() ==
                          "UNLIMTED PACKAGE WITH MC"
                      ? detail(
                          "Gram : ",
                          snapshot.data.data.paymentsDetails.gram.toString(),
                        )
                      : SizedBox(),
                  snapshot.data.data.paymentsDetails.branchId == 14906 &&
                              snapshot.data.data.paymentsDetails.schemeName
                                      .toString() ==
                                  "Daily Scheme" ||
                          snapshot.data.data.paymentsDetails.schemeName
                                  .toString() ==
                              "ST Jewellay GOLD SCHEME" ||
                          snapshot.data.data.paymentsDetails.branchId == 6 &&
                              snapshot.data.data.paymentsDetails.schemeName
                                      .toString() ==
                                  "DAILY SCHEME" ||
                          snapshot.data.data.paymentsDetails.branchId == 2 &&
                              snapshot.data.data.paymentsDetails.schemeName
                                      .toString() ==
                                  "ST  TAARA  SCHEME" ||
                          snapshot.data.data.paymentsDetails.branchId == 3 &&
                              snapshot.data.data.paymentsDetails.schemeName
                                      .toString() ==
                                  "11 MONTH SCHEME DAILY WITHOUT MC" ||
                          snapshot.data.data.paymentsDetails.schemeName
                                  .toString() ==
                              "ST SCHEME" ||
                          snapshot.data.data.paymentsDetails.branchId ==
                                  27114 &&
                              schemeIddd == 30
                      ? detail(
                          "Gram : ",
                          snapshot.data.data.paymentsDetails.gram.toString(),
                        )
                      : SizedBox(),
                ],
              ),
              h(10),

              Row(
                children: List.generate(
                  150 ~/ 2,
                  (index) => Expanded(
                    child: Container(
                      color: index % 2 == 0
                          ? Colors.transparent
                          : Colors.grey[400],
                      height: 2,
                    ),
                  ),
                ),
              ),

              h(20),
            ],
          ),
        ),
      ),
    );
  }

  Widget detail(String title, String txt) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.w400)),
          Text(txt, style: TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var smallLineLength = size.width / 20;
    const smallLineHeight = 10;
    var path = Path();

    path.lineTo(0, size.height);
    for (int i = 1; i <= 20; i++) {
      if (i % 2 == 0) {
        path.lineTo(smallLineLength * i, size.height);
      } else {
        path.lineTo(smallLineLength * i, size.height - smallLineHeight);
      }
    }
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper old) => false;
}
