import 'package:flutter/material.dart';
import 'package:stjewellery/Constant/constants.dart';
import 'package:stjewellery/Utils/utils.dart';
import 'package:stjewellery/model/SchemeListModel.dart';
import 'package:stjewellery/screens/PackagesScreen/PriceSelectTab.dart';
import 'package:stjewellery/screens/PackagesScreen/SelectScheme.dart';
import 'package:stjewellery/screens/PackagesScreen/Yearly_Scheme.dart';
import 'package:stjewellery/service/Schemelistservice.dart';

class SelectNewScheme extends StatefulWidget {
  @override
  _SelectNewSchemeState createState() => _SelectNewSchemeState();
}

class _SelectNewSchemeState extends State<SelectNewScheme> {
  SchemeListmodel? data;

  int? schemeid;
  List<int> schemelist = [];
  List<dynamic> shcemetypelist = [];
  var _isCheckeded;
  SchemeList? details;
  bool backkey = true;
  int? role;
  var branchiid;
  int? shcemetype;

  getrole() async {
    role = await getSavedObject("roleid");
    var token = await getSavedObject("token");
    print(token);
    branchiid = await getSavedObject("branch");
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getScheme();
      getrole();
    });

    super.initState();
  }

  tick(int index) {
    setState(() {
      _isCheckeded.clear();
      _isCheckeded = List<bool>.filled(
        data!.data!.schemeList!.length,
        false,
        growable: true,
      );
      _isCheckeded.remove(index);
      _isCheckeded.insert(index, true);
      schemeid = schemelist.elementAt(index);
      shcemetype = shcemetypelist.elementAt(index);

      print("Scheme id$schemeid");
    });
  }

  bool load = true;
  Future<void> getScheme() async {
    try {
      print("reached packaged");
      Loading.show(context);
      SchemeListmodel datas = await Schemelistservice.getScheme();
      setState(() {
        Loading.dismiss();
        data = datas;
        load = false;
        //  test();
      });
      print(data!.data!.schemeList![0].schemeName.toString());
      _isCheckeded = List<bool>.filled(
        data!.data!.schemeList!.length,
        false,
        growable: true,
      );
      data!.data!.schemeList!.forEach((element) {
        schemelist.add(element.id!);
        shcemetypelist.add(element.schemeType);
      });
    } catch (e) {
      // showErrorMessage(e);
      Loading.dismiss();
      //  Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (role == 2 || role == 4) {
          Navigate.pushReplacement(context, SelectScheme());
          return Future.value(false);
          return Future<bool>.value(false);
        } else {
          Navigator.pop(context);
          //we need to return a future
          return Future.value(false);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              IconButton(
                onPressed: () {
                  if (role == 2 || role == 4) {
                    Navigate.pushReplacement(context, SelectScheme());
                  } else {
                    Navigator.pop(context);
                  }
                },
                icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
              ),
              Text(
                "Select Scheme",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 70,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ElevatedButton(
            onPressed: () {
              print(shcemetype);
              if (schemeid == null) {
                showToast("Please select a scheme");
              } else if (shcemetype == 1) {
                Navigate.push(context, SelectpriceTabyearly(arguments: details));
                // Navigator.pushNamed(
                //     context, SelectpriceTabyearly.routeName,
                //     arguments: details);
              } else {
                Navigate.push(context, PriceSelectTab(arguments: schemeid));
                // Navigator.pushNamed(
                //     context, SelectpriceTab.routeName,
                //     arguments: schemeid);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.black,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              "Continue",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        body: load == true
            ? Opacity(opacity: 0)
            : data!.data != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: data!.data!.schemeList!.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return role == 2 || role == 4
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child:
                                // data.data.schemeList[index]
                                //                     .schemeName ==
                                //                 "TAARA GOLD SCHEME" &&
                                //             branchiid == 2 ||
                                //         data.data.schemeList[index]
                                //                     .schemeName ==
                                //                 "11 MONTH SCHEME DAILY WITHOUT MC" &&
                                //             branchiid == 3
                                Container(
                                  decoration: BoxDecoration(
                                    color: _isCheckeded.elementAt(index) 
                                        ? Color.fromRGBO(255, 203, 3, 1)
                                        : Colors.white,
                                    border: Border.all(
                                      color: Color.fromRGBO(255, 203, 3, 1),
                                      width: 1.5,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      details = data!.data!.schemeList!
                                          .elementAt(index);
                                      tick(index);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 18,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              data!.data!.schemeList!
                                                  .elementAt(index)
                                                  .schemeName!,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: _isCheckeded.elementAt(index)
                                                    ? Colors.black
                                                    : Colors.black,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          // _isCheckeded.elementAt(index)
                                          //     ? Icon(
                                          //         Icons.check_circle,
                                          //         color: Colors.black,
                                          //         size: 24,
                                          //       )
                                          //     : Icon(
                                          //         Icons.circle_outlined,
                                          //         color: Colors.grey[400],
                                          //         size: 24,
                                          //       ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                            // : SizedBox(),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Container(
                              decoration: BoxDecoration(
                                color: _isCheckeded.elementAt(index) 
                                    ? Color.fromRGBO(255, 203, 3, 1)
                                    : Colors.white,
                                border: Border.all(
                                  color: _isCheckeded.elementAt(index)
                                      ? Color.fromRGBO(255, 203, 3, 1)
                                      : Colors.grey[300]!,
                                  width: 1,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(12),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: InkWell(
                                onTap: () {
                                  details = data!.data!.schemeList!
                                      .elementAt(index);
                                  tick(index);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 18,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          data!.data!.schemeList!
                                              .elementAt(index)
                                              .schemeName!,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: _isCheckeded.elementAt(index)
                                                ? Colors.black
                                                : Colors.black54,
                                            fontWeight: _isCheckeded.elementAt(index)
                                                ? FontWeight.w600
                                                : FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      _isCheckeded.elementAt(index)
                                          ? Icon(
                                              Icons.check_circle,
                                              color: Colors.black,
                                              size: 24,
                                            )
                                          : Icon(
                                              Icons.circle_outlined,
                                              color: Colors.grey[400],
                                              size: 24,
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                  },
                ),
              )
            : Container(),
      ),
    );
  }
}
