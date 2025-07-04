// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:stjewellery/Constant/Constants.dart';
// import 'package:stjewellery/Utils/Utils.dart';
// import 'package:stjewellery/model/Nextpaymentcustomerlistmodel.dart';
// import 'package:stjewellery/service/customerlistservice.dart';
//
// class Agentnextpaymentcustomer extends StatefulWidget {
//   const Agentnextpaymentcustomer({
//     Key? key,
//   }) : super(key: key);
//   @override
//   _AgentnextpaymentcustomerState createState() =>
//       _AgentnextpaymentcustomerState();
// }
//
// class _AgentnextpaymentcustomerState extends State<Agentnextpaymentcustomer> {
//
//
//   StreamController<List<CustomerList>>? _dataStream;
//   Stream? broadcastStream;
//   List<CustomerList>? customerListall;
//   List<CustomerList> customerListsearch = [];
//
//
//   @override
//   void initState() {
//     _dataStream = StreamController<List<CustomerList>>();
//     broadcastStream = _dataStream!.stream.asBroadcastStream();
//     Future.delayed(Duration.zero, () {
//       getCustomerlistnextpayment();
//     });
//     super.initState();
//   }
//
//
//   search(String text) {
//     print(text);
//     if (text.isEmpty) {
//       _dataStream!.add(customerListall!);
//     } else {
//       customerListsearch.clear();
//       customerListall!.forEach((element) {
//         if (element.name!.toLowerCase().contains(text.toLowerCase()) ||
//             element.registrationNumber!
//                 .toLowerCase()
//                 .contains(text.toLowerCase())) {
//           print(customerListsearch.length.toString());
//           customerListsearch.add(element);
//         }
//       });
//
//       _dataStream!.add(customerListsearch);
//     }
//   }
//
//   TextEditingController controllers = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 15.0),
//               child: Container(
//                 height: 50,
//                 width: MediaQuery.of(context).size.width,
//                 margin:
//                     const EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 10),
//                 decoration: new BoxDecoration(
//                     color: Colors.grey[100],
//                     boxShadow: [shadow],
//                     border: Border.all(color: Colors.black38),
//                     borderRadius: BorderRadius.circular(5)),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: Container(
//                           child: TextField(
//                             style: font(14, Colors.black, FontWeight.w400),
//                             controller: controllers,
//                             onChanged: search,
//                             decoration: InputDecoration(
//                                 hintStyle: TextStyle(
//                                   color: ColorUtil.fromHex("#000000"),
//                                   fontFamily: "OpenSans",
//                                 ),
//                                 border: InputBorder.none,
//                                 hintText: 'Search'),
//                           ),
//                         ),
//                       ),
//                       w(15),
//                       Icon(
//                         Icons.search,
//                         color: ColorUtil.fromHex("#000000"),
//                         size: 24.0,
//                         semanticLabel:
//                             'Text to announce in accessibility modes',
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: StreamBuilder(
//                 stream: broadcastStream,
//                 builder: (context, snapshot) {
//                   if (snapshot.hasData) {
//                     return Container(
//                       child: snapshot.data != null
//                           ? SafeArea(
//                               child: Column(
//                                 children: [
//                                   Expanded(
//                                     child: snapshot.data.length == 0
//                                         ? const Center(
//                                             child: Text(
//                                               "No cilent",
//                                               style: TextStyle(
//                                                   color: Colors.black),
//                                             ),
//                                           )
//                                         : ListView.builder(
//                                             itemCount: snapshot.data.length,
//                                             itemBuilder:
//                                                 (BuildContext ctxt, int index) {
//                                               return Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 20.0,
//                                                     right: 20,
//                                                     top: 15),
//                                                 child: Container(
//                                                   decoration: BoxDecoration(
//                                                       boxShadow: [shadow],
//                                                       border: Border.all(
//                                                           color:
//                                                               Colors.black12),
//                                                       color: ColorUtil.fromHex(
//                                                           "#ececec"),
//                                                       borderRadius:
//                                                           const BorderRadius.all(
//                                                               Radius.circular(
//                                                                   10))),
//                                                   child: InkWell(
//                                                     onTap: () async {
//                                                       await saveObject(
//                                                           "customerid",
//                                                           snapshot.data
//                                                               .elementAt(index)
//                                                               .userId);
//                                                       await saveObject(
//                                                           "subscription",
//                                                           snapshot.data
//                                                               .elementAt(index)
//                                                               .subscriptionId);
//
//                                                       // Navigator.pushNamed(
//                                                       //     context,
//                                                       //     HomeTabs.routeName);
//                                                     },
//                                                     child: Padding(
//                                                       padding:
//                                                           const EdgeInsets.only(
//                                                               left: 10.0,
//                                                               right: 10,
//                                                               top: 15,
//                                                               bottom: 15),
//                                                       child: Column(
//                                                         crossAxisAlignment:
//                                                             CrossAxisAlignment
//                                                                 .start,
//                                                         children: [
//                                                           line(
//                                                               snapshot.data
//                                                                   .elementAt(
//                                                                       index)
//                                                                   .name
//                                                                   .toString(),
//                                                               Icons.person,
//                                                               FontWeight.w700),
//                                                           w(5),
//                                                           line(
//                                                               snapshot.data
//                                                                   .elementAt(
//                                                                       index)
//                                                                   .registrationNumber
//                                                                   .toString(),
//                                                               Icons
//                                                                   .featured_play_list_rounded,
//                                                               FontWeight.w500),
//                                                           w(5),
//                                                           line(
//                                                               snapshot.data
//                                                                   .elementAt(
//                                                                       index)
//                                                                   .phone
//                                                                   .toString(),
//                                                               Icons.phone,
//                                                               FontWeight.w500)
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               );
//                                             }),
//                                   ),
//                                   const Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: [
//                                       SizedBox(
//                                         height: 5,
//                                       ),
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             )
//                           : Container(),
//                     );
//                   } else {
//                     return Container(
//                       decoration: const BoxDecoration(),
//                     );
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//
//     );
//   }
//
//
//   getCustomerlistnextpayment() async {
//     Nextpaymentcustomerlistmodel datas;
//     try {
//       Loading.show(context);
//       Map d = {
//         "agentId": await getSavedObject("userid"),
//         "limit": "10",
//         "page": "1"
//       };
//       datas = await Customerlistservice.getCustomernextpaymnetlist(d);
//       Loading.dismiss();
//
//       customerListall = datas.data!.customerList;
//       Loading.dismiss();
//       _dataStream!.add(customerListall!);
//
//     } catch (e) {
//       Loading.dismiss();
//     }
//   }
//
//   line(String txt, IconData icn, FontWeight weight) {
//     return Row(
//       children: [
//         Icon(icn, size: 18),
//         w(10),
//         Text(txt, style: TextStyle(fontSize: 14, fontWeight: weight))
//       ],
//     );
//   }
// }

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stjewellery/agent_module/Agentregistration/agent_registration_screen.dart';
import 'package:stjewellery/Constant/constants.dart';
import 'package:stjewellery/Utils/utils.dart';
import 'package:stjewellery/model/Nextpaymentcustomerlistmodel.dart';
import 'package:stjewellery/model/Sheduledmodel.dart';
import 'package:stjewellery/model/paymentmodel.dart';
import 'package:stjewellery/service/Paymentservice.dart';
import 'package:stjewellery/service/Sheduledservice.dart';
import 'package:stjewellery/service/customer_list_service.dart';

class Agentnextpaymentcustomer extends StatefulWidget {
  const Agentnextpaymentcustomer({Key? key}) : super(key: key);

  @override
  _AgentnextpaymentcustomerState createState() =>
      _AgentnextpaymentcustomerState();
}

class _AgentnextpaymentcustomerState extends State<Agentnextpaymentcustomer> {
  Map<int, bool> loadingButtons = {}; // Track loading state per button

  TextEditingController amountController = TextEditingController();

  List<CustomerList> customerListAll = [];
  List<CustomerList> customerListSearch = [];
  StreamController<List<CustomerList>>? _dataStream;
  Stream? broadcastStream;
  TextEditingController controllers = TextEditingController();
  ScrollController _scrollController = ScrollController();

  int currentPage = 1;
  final int limit = 10;
  bool isLoading = false;
  bool hasMore = true;

  @override
  void initState() {
    _dataStream = StreamController<List<CustomerList>>();
    broadcastStream = _dataStream!.stream.asBroadcastStream();

    _scrollController.addListener(_onScroll);

    Future.delayed(Duration.zero, () {
      getCustomerListNextPayment();
      getAgent();
    });

    super.initState();
  }

  String agentid = "";
  getAgent() async {
    String s = await getSavedObject("referalId");
    if (s != null)
      setState(() {
        agentid = s;
      });
  }

  @override
  void dispose() {
    _dataStream?.close();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        hasMore) {
      getCustomerListNextPayment();
    }
  }

  Future<void> getCustomerListNextPayment() async {
    if (isLoading) return;

    setState(() => isLoading = true);

    try {
      Map<String, dynamic> params = {
        "agentId": await getSavedObject("userid"),
        "limit": limit.toString(),
        "page": currentPage.toString(),
      };

      Nextpaymentcustomerlistmodel data =
          await Customerlistservice.getCustomernextpaymnetlist(params);

      List<CustomerList> fetchedList = data.data?.customerList ?? [];

      if (fetchedList.isNotEmpty) {
        customerListAll.addAll(fetchedList);
        _dataStream!.add(customerListAll);
        currentPage++;
        if (fetchedList.length < limit) hasMore = false; // Check here
      } else {
        hasMore = false;
      }
    } catch (e) {
      print("Error fetching data: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  void search(String text) {
    if (text.isEmpty) {
      _dataStream!.add(customerListAll);
    } else {
      customerListSearch = customerListAll.where((element) {
        return element.name!.toLowerCase().contains(text.toLowerCase()) ||
            element.registrationNumber!.toLowerCase().contains(
              text.toLowerCase(),
            );
      }).toList();

      _dataStream!.add(customerListSearch);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Container(
          //   height: 50,
          //   margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          //   decoration: BoxDecoration(
          //     color: Colors.grey[100],
          //     boxShadow: [shadow],
          //     border: Border.all(color: Colors.black38),
          //     borderRadius: BorderRadius.circular(5),
          //   ),
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 15),
          //     child: Row(
          //       children: [
          //         Expanded(
          //           child: TextField(
          //             style: font(14, Colors.black, FontWeight.w400),
          //             controller: controllers,
          //             onChanged: search,
          //             decoration: InputDecoration(
          //               hintStyle: TextStyle(
          //                 color: ColorUtil.fromHex("#000000"),
          //                 fontFamily: "OpenSans",
          //               ),
          //               border: InputBorder.none,
          //               hintText: 'Search',
          //             ),
          //           ),
          //         ),
          //         const SizedBox(width: 15),
          //         Icon(Icons.search,
          //             color: ColorUtil.fromHex("#000000"), size: 24.0),
          //       ],
          //     ),
          //   ),
          // ),
          Expanded(
            child: StreamBuilder<List<CustomerList>>(
              stream: broadcastStream as Stream<List<CustomerList>>?,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(),
                        h(5),
                        const Text("Loading.. Please Wait!"),
                      ],
                    ),
                  );
                }
                if (customerListAll.isEmpty) {
                  return const Text("No Clients");
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      "No clients",
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }

                return ListView.builder(
                  controller: _scrollController,
                  itemCount: snapshot.data!.length + (hasMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    print(
                      "Index: $index, Length: ${snapshot.data!.length}, hasMore: $hasMore",
                    );
                    if (index < snapshot.data!.length) {
                      return buildListItem(snapshot.data![index], index);
                    } else {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigate.pushWithCallback(
            context,
            AgentRegistrationScreen(),
            getCustomerListNextPayment,
          );
        },
        label: Text(
          'New Customer',
          style: font(12, Colors.white, FontWeight.w600),
        ),
        icon: const Icon(Icons.add, size: 18, color: Colors.white),
        backgroundColor: ColorUtil.fromHex("#461524"),
        shape: const StadiumBorder(),
      ),
    );
  }

  Widget buildListItem(CustomerList customer, index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [shadow],
          border: Border.all(color: Colors.black12),
          color: ColorUtil.fromHex("#ececec"),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  line(customer.name.toString(), Icons.person, FontWeight.w700),
                  h(5),
                  line(
                    customer.registrationNumber.toString(),
                    Icons.featured_play_list_rounded,
                    FontWeight.w500,
                  ),
                  h(5),
                  line(customer.phone.toString(), Icons.phone, FontWeight.w500),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    loadingButtons[index] = true;

                    bttnPress = true;
                  });
                  await getProfile(customer.userId, customer.subscriptionId);
                  setState(() {
                    loadingButtons[index] = false;
                  });
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                ),
                child: loadingButtons[index] == true
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        "Pay",
                        style: font(14, Colors.white, FontWeight.w500),
                      ),
              ),
              // bttn2("Pay", () {})
            ],
          ),
        ),
      ),
    );
  }

  Widget line(String txt, IconData icn, FontWeight weight) {
    return Row(
      children: [
        Icon(icn, size: 18),
        const SizedBox(width: 10),
        Text(txt, style: TextStyle(fontSize: 14, fontWeight: weight)),
      ],
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Continue"),
      onPressed: () {
        Navigator.pop(context);
        agentpay(
          scheduleData!.data!.monthlyAmont!,
          scheduleData!.data!.todayEarnings.toString(),
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Payment"),
      content: const Text("Would you like to continue with the paymnet?"),
      actions: [cancelButton, continueButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogvarient(BuildContext context) {
    double gram = 0;
    String finalgram = "";

    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        amountController.text = "";
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Continue"),
      onPressed: () {
        try {
          if ((double.parse(amountController.text.toString()) <=
                  double.parse(scheduleData!.data!.amountTo.toString())) &&
              (double.parse(amountController.text.toString()) >=
                  double.parse(scheduleData!.data!.monthlyAmont.toString()))) {
            Navigator.pop(context);
            agentpay(amountController.text.toString(), finalgram);
          } else {
            showToast("Please enter amount with in range");
          }
        } catch (e) {
          showToast("Please enter amount with in range");
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Payment"),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return SizedBox(
            // height: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Please enter the amount to pay ?",
                  style: font(16, Colors.black, FontWeight.w600),
                ),
                Center(
                  child: Text(
                    "$rs${scheduleData!.data!.monthlyAmont.toString().split('.')[0]}  to  $rs${scheduleData!.data!.amountTo.toString().split('.')[0]}",
                    style: font(17, Colors.black, FontWeight.bold),
                  ),
                ),
                Center(
                  child: SizedBox(
                    // width: 150,
                    height: 50,
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: "Enter amount",
                        counterText: "",
                        prefix: Text(rs),
                      ),
                      controller: amountController,
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
                                  scheduleData!.data!.todayRate.toString(),
                                );

                            finalgram = gram.toStringAsFixed(3);
                          }
                        });
                      },
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      actions: [cancelButton, continueButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void agentpay(String amount, String gram) async {
    Map details = {
      'UserId': await getSavedObject('customerid'),
      'SheduledDateId': paymentpendingid,
      'gram': gram,
      'amount': amount,
      'taransactionId': "nil",
      'subscriptionId': await getSavedObject('subscription'),
      'paidBy': await getSavedObject('userid'),
    };
    print("details--------------------------->$details");
    try {
      Loading.show(context);
      Paymentmodel datas = await Paymentservice.postPay(details);
      print("Reached here");

      Loading.dismiss();
      //widget.paymentrefresh();
      // getProfile();
    } catch (e) {
      Loading.dismiss();
      print(e);
      //  Navigator.pop(context);
    }
  }

  int totalpayed = 0;
  bool? vis;
  Sheduledmodel? scheduleData;
  String? userSchemename;
  dynamic paymentpendingid;
  dynamic schemeId;
  dynamic schemeAmountId;
  dynamic paymentStartDates;
  dynamic paymentEndDates;
  String? upistatus;
  bool bttnPress = false;

  getProfile(userid, subId) async {
    totalpayed = 0;
    vis = false;
    Map details = {
      'UserId': userid,
      // 'UserId': await getSavedObject("roleid") == 3
      //     ? await getSavedObject("customerid")
      //     : await getSavedObject('userid'),
      'subscriptionId': subId,
    };

    print(details);
    try {
      // Loading.show(context);
      //    showLoading(context);
      Sheduledmodel datas = await Sheduledservice.postService(details);
      print("Reached here");
      setState(() {
        scheduleData = datas;
      });
      if (datas.data!.subs!.userSchemeName != null)
        userSchemename = datas.data!.subs!.userSchemeName.toString();

      scheduleData!.data!.schemetype! != 1
          ? datas.data!.sheduledList!.forEach((element) {
              if (element.status == 2) {
                totalpayed++;
              } else if (element.status == 1) {
                setState(() {
                  paymentpendingid = element.id;
                  schemeId = element.schemeId;
                  schemeAmountId = element.schemeAmountId;
                  paymentStartDates = element.paymentStartDates;
                  paymentEndDates = element.paymentEndDates;
                  upistatus = element.upiStatus.toString();
                  vis = true;
                  totalpayed;
                });
              }
            })
          : setState(() {
              paymentpendingid = scheduleData!.data!.upcomingPayment!
                  .elementAt(0)
                  .id;
              schemeId = scheduleData!.data!.upcomingPayment!
                  .elementAt(0)
                  .schemeId;
              schemeAmountId = scheduleData!.data!.upcomingPayment!
                  .elementAt(0)
                  .schemeAmountId;
              upistatus = scheduleData!.data!.upcomingPayment!
                  .elementAt(0)
                  .upiStatus
                  .toString();
              // paymentStartDates = new DateTime.now();
              // paymentEndDates = new DateTime.now();
              vis = true;
            });

      // Loading.dismiss();
      setState(() {
        bttnPress = false;
      });
      scheduleData!.data!.paymentType == 0
          ? showAlertDialog(context)
          : showAlertDialogvarient(context);
    } catch (e) {
      // showErrorMessage(e);
      Loading.dismiss();

      print(e);
      //  Navigator.pop(context);
    }
  }
}
