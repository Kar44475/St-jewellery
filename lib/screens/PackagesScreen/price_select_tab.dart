import 'package:flutter/material.dart';
import 'package:stjewellery/Constant/constants.dart';
import 'package:stjewellery/Utils/utils.dart';
import 'package:stjewellery/model/schemeAmountListmodel.dart';
import 'package:stjewellery/screens/PackagesScreen/fixed_price_tab.dart';
import 'package:stjewellery/screens/PackagesScreen/variable_price_amount.dart';
import 'package:stjewellery/service/Schemelistservice.dart';

class PriceSelectTab extends StatefulWidget {
  final arguments;
  const PriceSelectTab({Key? key, this.arguments}) : super(key: key);

  @override
  _SelectPackageState createState() => _SelectPackageState();
}

class _SelectPackageState extends State<PriceSelectTab>
    with TickerProviderStateMixin {
  int? schemeid;
  SchemeAmountListmodel? data;
  int? role;
  int? priceid;
  List<int> pricelist = [];
  var _isCheckeded;
  late TabController _tabController;

  getrole() async {
    role = await getSavedObject("roleid");
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    Future.delayed(Duration.zero, () {
      setState(() {
        schemeid = widget.arguments;
      });
      getAmount();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
        data = datas;
        print(data);
        load = false;
      });
      _isCheckeded = List<bool>.filled(
        data!.data.fixed.length,
        false,
        growable: true,
      );
      data!.data.fixed.forEach((element) {
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
          : data!.data != null
          ? Column(
              children: [
                const SizedBox(height: 20),

                // Custom Tab Bar
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromRGBO(255, 203, 3, 1),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      // Variable Price Tab
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            _tabController.animateTo(0);
                          },
                          child: AnimatedBuilder(
                            animation: _tabController,
                            builder: (context, child) {
                              bool isSelected = _tabController.index == 0;
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color.fromRGBO(255, 203, 3, 1)
                                      : Colors.white,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(7),
                                    bottomLeft: Radius.circular(7),
                                  ),
                                ),
                                child: Text(
                                  "Variable Price",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      // Divider line
                      Container(
                        width: 1,
                        height: 45,
                        color: const Color.fromRGBO(255, 203, 3, 1),
                      ),

                      // Fixed Price Tab
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            _tabController.animateTo(1);
                          },
                          child: AnimatedBuilder(
                            animation: _tabController,
                            builder: (context, child) {
                              bool isSelected = _tabController.index == 1;
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color.fromRGBO(255, 203, 3, 1)
                                      : Colors.white,
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(7),
                                    bottomRight: Radius.circular(7),
                                  ),
                                ),
                                child: Text(
                                  "Fixed Price",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Tab Bar View
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      VariablePriceAmount(data: data!, schemeid: schemeid!),
                      FixedPriceAmount(data: data!, schemeid: schemeid!),
                    ],
                  ),
                ),
              ],
            )
          : const Center(child: Text("No data available")),
    );
  }
}
