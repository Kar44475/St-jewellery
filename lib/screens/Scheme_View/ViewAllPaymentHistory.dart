import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stjewellery/Constant/constants.dart';
import 'package:stjewellery/utils/utils.dart';
import 'package:stjewellery/screens/Recepit/Recepit.dart';

class ViewAllPaymentHistory extends StatefulWidget {
  final arguments;

  const ViewAllPaymentHistory({Key? key, this.arguments}) : super(key: key);

  @override
  State<ViewAllPaymentHistory> createState() => _ViewAllPaymentHistoryState();
}

class _ViewAllPaymentHistoryState extends State<ViewAllPaymentHistory> {
  // "tittle": "Payment History",
  @override
  Widget build(BuildContext context) {
    Map details = widget.arguments;
    List<dynamic> listData = details["list"];
    dynamic schemetype = (details["schemeType"]);
    return Scaffold(
      appBar: AppBar(title: Text(details["tittle"], style: appbarStyle)),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 10),
              child: ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  color: Colors.grey,
                  indent: 20,
                  endIndent: 20,
                  height: 0,
                ),
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: listData.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return paymentItem(
                    listData: listData,
                    index: index,
                    shcemeType: schemetype,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class paymentItem extends StatelessWidget {
  const paymentItem({
    Key? key,
    required this.listData,
    required this.index,
    required this.shcemeType,
  }) : super(key: key);

  final List<dynamic> listData;

  final int index;

  final dynamic shcemeType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 10,
        top: 10,
        bottom: 10,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (shcemeType != 1)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Date :${DateFormat("dd MMM yyyy").format(listData.elementAt(index).paymentStartDates)}",
                            style: font(10, Colors.black, FontWeight.w400),
                          ),
                          Text(
                            " to ${DateFormat("dd MMM yyyy").format(listData.elementAt(index).paymentEndDates)}",
                            style: font(10, Colors.black, FontWeight.w400),
                          ),
                        ],
                      ),
                    if (shcemeType == 1)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Paid On :${DateFormat("dd MMM yyyy").format(listData.elementAt(index).updatedAt)}",
                            style: font(10, Colors.black, FontWeight.w400),
                          ),
                        ],
                      ),
                    if (listData.elementAt(index).status == 2)
                      if (listData.elementAt(index).status == 2)
                        const Row(
                          children: [
                            Icon(Icons.done, color: Colors.black),
                            SizedBox(height: 10),
                            Text(
                              "PAID",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Visibility(
                      visible: listData.elementAt(index).status == 2,
                      child: GestureDetector(
                        onTap: (() {
                          Navigate.push(
                            context,
                            Receipt(arguments: listData.elementAt(index).id),
                          );
                        }),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 10.0, right: 10),
                            child: Padding(
                              padding: EdgeInsets.all(6.0),
                              child: Text(
                                "Receipt",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Buttonwidget(
                      //   click: () {
                      //     Navigator.pushNamed(
                      //         context,
                      //         Recepit.routeName,
                      //         arguments: widget
                      //             .data
                      //             .data
                      //             .sheduledList
                      //             .elementAt(
                      //                 index)
                      //             .id);
                      //   },
                      //   colors: "#FFD98D",
                      //   height: 30,
                      //   label: "Receipt",
                      //   labelcolors: "#FFFFFF",
                      //   width: 100,
                      // ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
