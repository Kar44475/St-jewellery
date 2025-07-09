import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stjewellery/screens/main_screens/scheme_screen.dart';
import 'package:stjewellery/Constant/constants.dart';
import 'package:stjewellery/utils/utils.dart';
import 'package:stjewellery/model/Sheduledmodel.dart';
import 'package:stjewellery/screens/Recepit/Recepit.dart';
import 'package:stjewellery/screens/Scheme_View/Status_Widget.dart';

class paymentItem extends StatelessWidget {
  const paymentItem({
    Key? key,
    required this.widget,
    required this.index,
    required this.data,
  }) : super(key: key);

  final SchemeScreen widget;

  final int index;

  final Sheduledmodel data;

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
                    if (data.data!.schemetype != 1)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Date :${DateFormat("dd-MMM-yyyy").format(data.data!.sheduledList!.elementAt(index).paymentStartDates!)}",
                            style: font(10, Colors.grey, FontWeight.w400),
                          ),
                          Text(
                            " to ${DateFormat("dd-MMM-yyyy").format(data.data!.sheduledList!.elementAt(index).paymentEndDates!)}",
                            style: font(10, Colors.grey, FontWeight.w400),
                          ),
                        ],
                      ),
                    if (data.data!.schemetype == 1)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Paid On :${DateFormat("dd-MMM-yyyy").format(data.data!.paidPayment!.elementAt(index).updatedAt!)}",
                            style: font(13, Colors.grey, FontWeight.w400),
                          ),
                        ],
                      ),
                    if (data.data!.paidPayment!.elementAt(index).status == 2)
                      const SizedBox(height: 3),
                    if (data.data!.paidPayment!.elementAt(index).status == 2)
                      const Row(
                        children: [
                          Icon(Icons.done, color: Colors.grey),
                          Text(
                            "PAID",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              const Spacer(),
              data.data!.schemetype != 1
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 0),
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 6,
                            right: 6,
                            top: 2,
                            bottom: 2,
                          ),
                          child: Column(
                            children: [
                              data.data!.paidPayment!.elementAt(index).status ==
                                      3
                                  ? Statuswidget(
                                      paid: "Not paid",
                                      colors: Colors.red[900]!,
                                    )
                                  : data.data!.paidPayment!
                                            .elementAt(index)
                                            .status ==
                                        1
                                  ? Statuswidget(
                                      paid: "On going",
                                      colors: Colors.orange[900]!,
                                    )
                                  : data.data!.paidPayment!
                                            .elementAt(index)
                                            .status ==
                                        0
                                  ? Statuswidget(
                                      paid: "Up coming",
                                      colors: Colors.yellow[900]!,
                                    )
                                  : Container(),
                              const SizedBox(height: 10),
                              Visibility(
                                visible:
                                    data.data!.paidPayment!
                                        .elementAt(index)
                                        .status ==
                                    2,
                                child: InkWell(
                                  onTap: (() {
                                    Navigate.push(
                                      context,
                                      Receipt(
                                        arguments: data.data!.paidPayment!
                                            .elementAt(index)
                                            .id,
                                      ),
                                    );
                                  }),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black12),
                                      color: ColorUtil.fromHex("#C5DECB"),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.only(
                                        left: 10.0,
                                        right: 10,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: Text(
                                          "Receipt",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(
                      child: Row(
                        children: [
                          const SizedBox(width: 5),
                          Visibility(
                            visible:
                                data.data!.paidPayment!
                                    .elementAt(index)
                                    .status ==
                                2,
                            child: InkWell(
                              onTap: () {
                                Navigate.push(
                                  context,
                                  Receipt(
                                    arguments: data.data!.paidPayment!
                                        .elementAt(index)
                                        .id,
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white24),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(50.0),
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.only(
                                    left: 10.0,
                                    right: 10,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(6.0),
                                    child: Text(
                                      "Receipt",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
