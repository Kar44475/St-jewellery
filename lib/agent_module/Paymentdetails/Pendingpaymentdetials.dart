import 'package:flutter/material.dart';
import 'package:stjewellery/Constant/constants.dart';
import 'package:stjewellery/utils/utils.dart';
import 'package:stjewellery/model/agent_pending_model.dart';
import 'package:stjewellery/service/Pendingpaymentservice.dart';

class PendingPayment extends StatefulWidget {
  @override
  _PendingPaymentState createState() => _PendingPaymentState();
}

class _PendingPaymentState extends State<PendingPayment> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      getPaymentdetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pending Amount", style: appbarStyle)),
      body: load == true
          ? Center(child: const CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: ListView(
                children: [
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      //side: BorderSide(color: Colors.white70, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: ColorUtil.fromHex("#D4EDDA"),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 15.0,
                        right: 15,
                        top: 30,
                        bottom: 30,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 0.0),
                                child: Text(
                                  "AMOUNT",
                                  style: font(
                                    25,
                                    Colors.black,
                                    FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 0),
                                child: Text(
                                  "$rs${datas!.responseData!.pending}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    color: ColorUtil.fromHex("#000000"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  h(30),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "COLLECTION LIST  (${datas!.responseData!.adminpayment!.length})",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: datas!.responseData!.adminpayment!.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return (datas!.responseData!.adminpayment!.isEmpty)
                          ? const Center(
                              child: Text(
                                "No data",
                                style: TextStyle(color: Colors.black),
                              ),
                            )
                          : Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                //side: BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              color: ColorUtil.fromHex("#EDFCBA"),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 15.0,
                                  right: 15,
                                  top: 20,
                                  bottom: 20,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 0.0,
                                      ),
                                      child: Text(
                                        "From date : ${datas!.responseData!.adminpayment!.elementAt(index).fromdate.toString().substring(0, 10)}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: ColorUtil.fromHex("#643036"),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 0),
                                      child: Text(
                                        "To date : ${datas!.responseData!.adminpayment!.elementAt(index).todate.toString().substring(0, 10)}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: ColorUtil.fromHex("#643036"),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 0),
                                      child: Text(
                                        "Amount : ${datas!.responseData!.adminpayment!.elementAt(index).pendingamount}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: ColorUtil.fromHex("#643036"),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                    },
                  ),
                ],
              ),
            ),
    );
  }

  bool load = true;
  Agentpendingmodel? datas;

  Future<Agentpendingmodel> getPaymentdetails() async {
    try {
      // Loading.show(context);
      //    showLoading(context);
      datas = await Pendingpaymentservice.getpendingpayment();
      setState(() {
        load = false;
      });
      print("Reached hereeeee");
      return datas!;
    } catch (e) {
      setState(() {
        load = false;
      });
      // showErrorMessage(e);
      Loading.dismiss();
      print(e);
      return datas!;
      //  Navigator.pop(context);
    }
  }
}
