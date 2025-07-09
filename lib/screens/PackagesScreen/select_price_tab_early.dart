import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:stjewellery/support_widget/essential.dart';
import 'package:stjewellery/agent_module/agent_home_screen/agent_tab.dart';
import 'package:stjewellery/model/SchemeListModel.dart';
import 'package:stjewellery/model/Schemeaddmodel.dart';
import 'package:stjewellery/model/schemeAmountListmodel.dart';
import 'package:stjewellery/screens/PackagesScreen/select_scheme.dart';
import 'package:stjewellery/service/Schemelistservice.dart';
import 'package:stjewellery/service/postSchemeService.dart';

class SelectpriceTabyearly extends StatefulWidget {
  final arguments;

  const SelectpriceTabyearly({Key? key, this.arguments}) : super(key: key);

  @override
  _SelectPackageState createState() => _SelectPackageState();
}

class _SelectPackageState extends State<SelectpriceTabyearly> {
  SchemeList? details;
  int? schemeid;
  int termindex = 0;

  SchemeAmountListmodel? schemelistModel;

  int? role;

  getrole() async {
    role = await getSavedObject("roleid");
  }

  int? priceid;
  List<int> pricelist = [];
  var _isCheckeded;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        details = widget.arguments;
        schemeid = details!.id;
      });
      getAmount();
    });
  }

  bool load = true;
  getAmount() async {
    try {
      Loading.show(context);
      SchemeAmountListmodel datas = await Schemelistservice.schemeAmount(
        schemeid.toString(),
      );
      setState(() {
        Loading.dismiss();
        schemelistModel = datas;
        print(schemelistModel);
        load = false;
      });
      _isCheckeded = List<bool>.filled(
        schemelistModel!.data.fixed.length,
        false,
        growable: true,
      );
      schemelistModel!.data.fixed.forEach((element) {
        pricelist.add(element.id);
      });
    } catch (e) {
      Loading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Select Amount",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: load == true
          ? const Center(child: CircularProgressIndicator())
          : schemelistModel!.data != null
          ? Column(
              children: [
                Expanded(
                  child: VariablePriceAmount(
                    data: schemelistModel!,
                    schemeid: schemeid!,
                    details: details!,
                  ),
                ),
              ],
            )
          : const Center(child: Text("No data available")),
    );
  }
}

class VariablePriceAmount extends StatefulWidget {
  final SchemeAmountListmodel data;
  final int schemeid;
  final SchemeList details;

  const VariablePriceAmount({
    Key? key,
    required this.data,
    required this.schemeid,
    required this.details,
  }) : super(key: key);
  @override
  _VariablePriceAmountState createState() => _VariablePriceAmountState();
}

class _VariablePriceAmountState extends State<VariablePriceAmount> {
  bool terms = false;
  int? priceid;
  int? termssId;
  List<int> pricelist = [];
  var _isCheckeded;
  String _chosenValue = "Gold";
  int termindex = 0;
  bool schemeCheck = false;

  tick(int index) {
    setState(() {
      _isCheckeded.clear();
      _isCheckeded = List<bool>.filled(
        widget.data.data.varient.length,
        false,
        growable: true,
      );
      _isCheckeded.remove(index);
      _isCheckeded.insert(index, true);
      priceid = pricelist.elementAt(index);
      termssId = widget.data.data.varient.elementAt(index).termsId;
      print(priceid);
    });
    for (int i = 0; i < widget.data.data.termsandcondtion.length; i++) {
      if (widget.data.data.termsandcondtion.elementAt(i).id ==
          widget.data.data.varient.elementAt(index).termsId) {
        termindex = i;
      }
    }
  }

  @override
  void initState() {
    _isCheckeded = List<bool>.filled(
      widget.data.data.varient.length,
      false,
      growable: true,
    );
    widget.data.data.varient.forEach((element) {
      pricelist.add(element.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 15,
              ),
              child: ListView.builder(
                itemCount: widget.data.data.varient.length,
                itemBuilder: (BuildContext context, int index) {
                  bool isSelected = _isCheckeded.elementAt(index);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: GestureDetector(
                      onTap: () {
                        tick(index);
                        setState(() {
                          schemeCheck = true;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color.fromRGBO(255, 203, 3, 1)
                              : Colors.white,
                          border: Border.all(
                            color: const Color.fromRGBO(255, 203, 3, 1),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          "The amount deposited during half the period of total duration will be the limit for next half",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Terms and Conditions Section
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Theme(
                      data: Theme.of(context).copyWith(
                        unselectedWidgetColor: const Color.fromRGBO(
                          0,
                          0,
                          0,
                          0.5,
                        ),
                      ),
                      child: Checkbox(
                        activeColor: const Color.fromRGBO(0, 0, 0, 1),
                        checkColor: Colors.white,
                        value: terms,
                        onChanged: (val) {
                          setState(() {
                            terms = val!;
                          });
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        print(schemeCheck);
                        // For single item, allow viewing terms without selection
                        if (widget.data.data.varient.length == 1 ||
                            schemeCheck == true) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Center(
                                  child: Text("Terms and Conditions"),
                                ),
                                titleTextStyle: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                                actionsPadding: EdgeInsets.zero,
                                actions: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 0,
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Ok"),
                                    ),
                                  ),
                                ],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                elevation: 16,
                                content: SizedBox(
                                  height: ScreenSize.setHeight(context, 0.6),
                                  width: 300,
                                  child: ListView(
                                    children: [
                                      Html(
                                        data: widget.data.data.termsandcondtion
                                            .elementAt(
                                              widget.data.data.varient.length ==
                                                      1
                                                  ? 0
                                                  : termindex,
                                            )
                                            .description,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          showToastCenter("Please select a scheme");
                        }
                      },
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(bottom: 2),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color.fromRGBO(0, 0, 0, 0.5),
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: const Text(
                              "Terms and conditions",
                              style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 0.5),
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Submit Button with Primary Color
                Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      if (!terms) {
                        showToast("Please agree to our Terms & Conditions");
                      } else {
                        // Handle single item case - auto-select when user clicks Select button
                        if (widget.data.data.varient.length == 1 &&
                            priceid == null) {
                          // Auto-select the single item
                          priceid = pricelist[0];
                          termssId = widget.data.data.varient[0].termsId;

                          // Find the corresponding terms index
                          for (
                            int i = 0;
                            i < widget.data.data.termsandcondtion.length;
                            i++
                          ) {
                            if (widget.data.data.termsandcondtion
                                    .elementAt(i)
                                    .id ==
                                widget.data.data.varient.elementAt(0).termsId) {
                              termindex = i;
                              break;
                            }
                          }
                        }

                        if (priceid == null) {
                          showToast("Please select a payment option");
                        } else {
                          selectScheme();
                        }
                      }
                    },
                    child: const Text(
                      "Select",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void selectScheme() async {
    DateTime now = DateTime.now();

    Map details = {
      "SchemeId": widget.schemeid,
      "SchemeAmountId": priceid,
      "scheme_type": widget.details.schemeType,
      "check_payment_interval": widget.details.paymentIntervel,
      "UserId": await getSavedObject("roleid") == 3
          ? await getSavedObject("customerid")
          : await getSavedObject("userid"),
      "StartDate": now.toString().substring(0, 10),
      "subscription_type": "1",
      "termsId": termssId,
    };
    try {
      print(details);
      Loading.show(context);

      Schemeaddmodel datas = await PostSchemeService.postService(details);
      setState(() {
        Loading.dismiss();
      });
      if (datas.success) {
        if (await getSavedObject("roleid") == 2 ||
            await getSavedObject("roleid") == 4) {
          Navigate.pushAndRemoveUntil(context, SelectScheme());
        } else {
          Navigate.pushAndRemoveUntil(context, AgentTab());
        }
      }
    } catch (e) {
      Loading.dismiss();
    }

    print(details);
  }
}
