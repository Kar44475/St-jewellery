import 'package:flutter/material.dart';
import 'package:stjewellery/Utils/Utils.dart';
import 'package:stjewellery/model/Subscriptionlistmodel.dart';
import 'package:stjewellery/service/Schemelistgetservice.dart';

class Customerschemedetails extends StatefulWidget {
  @override
  _CustomerschemedetailsState createState() => _CustomerschemedetailsState();
}

class _CustomerschemedetailsState extends State<Customerschemedetails> {
  int? subid;
  List<int> subidlist = [];

  int? role;

  getrole() async {
    role = await getSavedObject("roleid");
    print(role.toString());
  }

  @override
  void initState() {
    super.initState();
    getScheme();
  }

  Subscriptionlistmodel? data;
  @override
  Widget build(BuildContext context) {
    //   getrole();
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(),
        child: data!.data != null
            ? SafeArea(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(),
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //       left: 20.0, right: 20, top: 20, bottom: 20),
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //         color: ColorUtil.fromHex("#FFCF5E"),
                    //         borderRadius: BorderRadius.all(Radius.circular(8))),
                    //     child: Padding(
                    //       padding: const EdgeInsets.only(
                    //           left: 10.0, right: 10, top: 10, bottom: 10),
                    //       child: Row(
                    //         children: [
                    //           Text(
                    //             "Create new plan",
                    //             style: TextStyle(
                    //                 fontWeight: FontWeight.w600,
                    //                 color: Colors.white),
                    //           ),
                    //           Spacer(),

                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //       left: 20.0, right: 20, top: 10, bottom: 10),
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //         color: ColorUtil.fromHex("#FFCF5E"),
                    //         borderRadius: BorderRadius.all(Radius.circular(8))),
                    //     child: Padding(
                    //       padding: const EdgeInsets.only(
                    //           left: 10.0, right: 10, top: 20, bottom: 20),
                    //       child: Row(
                    //         children: [
                    //           Text(
                    //             "fdf",
                    //             style: TextStyle(
                    //                 fontWeight: FontWeight.w600,
                    //                 color: Colors.white),
                    //           ),
                    //           Spacer(),
                    //           IconButton(
                    //               icon: Icon(
                    //                 Icons.add,
                    //                 color: Colors.white,
                    //               ),
                    //               onPressed: ()
                    //               )
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 8.0, top: 10),
                    //   child: Text(
                    //     "CHOOSE PLAN",
                    //     style: TextStyle(color: ColorUtil.fromHex("#FECC5F")),
                    //   ),
                    // ),
                    Expanded(
                      child: data!.data.subscriptionList.isEmpty
                          ? const Center(
                              child: Text(
                                "This customer dont have any scheme",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : ListView.builder(
                              itemCount: data!.data.subscriptionList.length,
                              itemBuilder: (BuildContext ctxt, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20.0,
                                    right: 20,
                                    top: 15,
                                  ),
                                  child: GestureDetector(
                                    onTap: () async {
                                      await saveObject(
                                        "subscription",
                                        subidlist.elementAt(index),
                                      );

                                      print(
                                        "select sub id${subidlist.elementAt(index)}",
                                      );
                                      // Navigator.pushNamed(
                                      //     context, HomeTabs.routeName);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: ColorUtil.fromHex("#E3E3E3"),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                      child: InkWell(
                                        onTap: () async {
                                          await saveObject(
                                            "subscription",
                                            subidlist.elementAt(index),
                                          );

                                          print(
                                            "select sub id${subidlist.elementAt(index)}",
                                          );
                                          // Navigator.pushNamed(
                                          //     context, HomeTabs.routeName);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 10.0,
                                            right: 10,
                                            top: 15,
                                            bottom: 15,
                                          ),
                                          child: Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    data!.data.subscriptionList
                                                        .elementAt(index)
                                                        .schemeName
                                                        .toString(),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  data!.data.subscriptionList
                                                              .elementAt(index)
                                                              .subscriptionType ==
                                                          0
                                                      ? Container(
                                                          decoration: BoxDecoration(
                                                            color:
                                                                ColorUtil.fromHex(
                                                                  "#461524",
                                                                ),
                                                            borderRadius:
                                                                const BorderRadius.all(
                                                                  Radius.circular(
                                                                    20,
                                                                  ),
                                                                ),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets.only(
                                                                  left: 7.0,
                                                                  right: 7,
                                                                ),
                                                            child: Text(
                                                              "₹ ${data!.data.subscriptionList.elementAt(index).schemAmount}",
                                                              style:
                                                                  const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                            ),
                                                          ),
                                                        )
                                                      : Row(
                                                          children: [
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                color:
                                                                    ColorUtil.fromHex(
                                                                      "#461524",
                                                                    ),
                                                                borderRadius:
                                                                    const BorderRadius.all(
                                                                      Radius.circular(
                                                                        20,
                                                                      ),
                                                                    ),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets.only(
                                                                      left: 7.0,
                                                                      right: 7,
                                                                    ),
                                                                child: Text(
                                                                  "₹ ${data!.data.subscriptionList.elementAt(index).schemAmount}",
                                                                  style: const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            const Text(
                                                              " To ",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                color:
                                                                    ColorUtil.fromHex(
                                                                      "#461524",
                                                                    ),
                                                                borderRadius:
                                                                    const BorderRadius.all(
                                                                      Radius.circular(
                                                                        20,
                                                                      ),
                                                                    ),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets.only(
                                                                      left: 7.0,
                                                                      right: 7,
                                                                    ),
                                                                child: Text(
                                                                  "₹ ${data!.data.subscriptionList.elementAt(index).amountTo}",
                                                                  style: const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                ],
                                              ),
                                              const Spacer(),
                                              const Icon(
                                                Icons
                                                    .arrow_forward_ios_outlined,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [SizedBox(height: 5)],
                    ),
                  ],
                ),
              )
            : Container(),
      ),

      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(right: 20.0, bottom: 15),
      //   child: Container(
      //     width: 64,
      //     height: 64,
      //     child: FloatingActionButton(

      //         onPressed: () {
      //           {
      //             Navigator.pushNamed(context, SelectPackage.routeName)
      //                 .then((value) => getScheme());
      //           }
      //         },

      //         child: const Icon(
      //           Icons.add,
      //           size: 30,
      //         ),
      //         backgroundColor: ColorUtil.fromHex("#FFCD5E")),
      //   ),
      // ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigator.pushNamed(context, SelectPackage.routeName)
          //     .then((value) => getScheme());
        },
        label: const Text('New Scheme', style: TextStyle(color: Colors.white)),
        icon: const Icon(Icons.add, color: Colors.white),
        backgroundColor: ColorUtil.fromHex("#461524"),
      ),
    );
  }

  Future<void> getScheme() async {
    int userid;
    subidlist.clear();
    try {
      Loading.show(context);
      //    showLoading(context);

      if (await getSavedObject("roleid") == 3) {
        userid = await getSavedObject("customerid");
      } else {
        userid = await getSavedObject("userid");
      }

      // userid = role != 2
      //     ? await getSavedObject("customerid")
      //     : await getSavedObject("userid");

      print("dfbasdfbdsfhdbfdf $role");
      print("dfbasdfbdsfhdbfdf $userid");
      print(await getSavedObject("customerid"));
      print(await getSavedObject("userid"));
      Subscriptionlistmodel datas = await Schemelistgetservice.getScheme(
        userid,
      );
      Loading.dismiss();
      setState(() {
        data = datas;
        print(data);
        //  test();
      });
      data!.data.subscriptionList.forEach((element) {
        subidlist.add(element.id);
      });
    } catch (e) {
      Loading.dismiss();
    }
  }
}
