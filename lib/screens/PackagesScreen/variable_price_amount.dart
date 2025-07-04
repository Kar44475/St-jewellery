import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:stjewellery/Constant/constants.dart';
import 'package:stjewellery/Utils/utils.dart';
import 'package:stjewellery/model/Schemeaddmodel.dart';
import 'package:stjewellery/model/schemeAmountListmodel.dart';
import 'package:stjewellery/screens/PackagesScreen/select_scheme.dart';
import 'package:stjewellery/service/postSchemeService.dart';

class VariablePriceAmount extends StatefulWidget {
  final SchemeAmountListmodel data;
  final int schemeid;

  const VariablePriceAmount({
    Key? key,
    required this.data,
    required this.schemeid,
  }) : super(key: key);
  @override
  _VariablePriceAmountState createState() => _VariablePriceAmountState();
}

class _VariablePriceAmountState extends State<VariablePriceAmount> {
  bool terms = false;
  int? priceid;
  List<int> pricelist = [];
  var _isCheckeded;
  int termindex = 0;
  int? termsid;
  
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
      termsid = widget.data.data.varient.elementAt(index).termsId;
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

  String _chosenValue = "Gold";
  @override
  Widget build(BuildContext context) {
    return widget.data.data.varient.length == 0
        ? Center(
            child: Text(
              "No schemes available!",
              style: font(14, Colors.black, FontWeight.w700),
            ),
          )
        : Container(
            color: Colors.white,
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        childAspectRatio: 2.5,
                      ),
                      itemCount: widget.data.data.varient.length,
                      itemBuilder: (BuildContext context, int index) {
                        bool isSelected = _isCheckeded.elementAt(index);
                        return GestureDetector(
                          onTap: () {
                            tick(index);
                          },
                          child: Container(
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
                            child: Center(
                              child: Text(
                                "$rs${widget.data.data.varient.elementAt(index).amount!.split('.')[0]} - $rs${widget.data.data.varient.elementAt(index).amountTo!.split('.')[0]}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
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
                              unselectedWidgetColor: const Color.fromRGBO(0, 0, 0, 0.5),
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
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    elevation: 16,
                                    child: Container(
                                      height: MediaQuery.of(context).size.height * 0.8,
                                      width: MediaQuery.of(context).size.width * 0.9,
                                      child: ListView(
                                        children: <Widget>[
                                          const SizedBox(height: 20),
                                          Center(
                                            child: Text(
                                              "Terms and conditions",
                                              style: TextStyle(
                                                fontSize: 24,
                                                color: Theme.of(context).primaryColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          Html(
                                            data: widget
                                                .data
                                                .data
                                                .termsandcondtion
                                                .elementAt(termindex)
                                                .description,
                                          ),
                                          const SizedBox(height: 20),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 35.0,
                                              right: 35,
                                            ),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("OK"),
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                    bottom: 2,
                                  ),
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
                              showToast("Please agree to our terms conditions");
                            } else if (priceid == null) {
                              showToast("Please select a payment option");
                            } else {
                              selectScheme();
                            }
                          },
                          child: const Text(
                            "Continue",
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
    DateTime now = new DateTime.now();

    Map details = {
      "SchemeId": widget.schemeid,
      "SchemeAmountId": priceid,
      "UserId": await getSavedObject("roleid") == 3
          ? await getSavedObject("customerid")
          : await getSavedObject("userid"),
      "StartDate": now.toString().substring(0, 10),
      "subscription_type": "1",
      "termsId": termsid,
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
          Navigator.popUntil(
            context,
            ModalRoute.withName('/Customerschemedetails'),
          );
        }
      }
    } catch (e) {
      Loading.dismiss();
    }

    print(details);
  }
}
