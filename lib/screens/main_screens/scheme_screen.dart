import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:stjewellery/drawer/drawer.dart';
import 'package:stjewellery/Utils/utils.dart';
import 'package:stjewellery/model/Paymentdetailsmodel.dart';
import 'package:stjewellery/model/Sheduledmodel.dart';
import 'package:stjewellery/model/paymentmodel.dart';
import 'package:stjewellery/screens/Notification/notifications_screen.dart';
import 'package:stjewellery/screens/Paymentsendscreen/NewPaymentScreen.dart';
import 'package:stjewellery/service/Paymentdetailsserivce.dart';
import 'package:stjewellery/service/Paymentservice.dart';
import 'package:stjewellery/service/Sheduledservice.dart';
import 'package:stjewellery/service/dashboard_service.dart';
import '../../Constant/constants.dart';
import '../../model/Dashboardmodel.dart' as model;

class SchemeScreen extends StatefulWidget {
  const SchemeScreen({Key? key}) : super(key: key);

  @override
  State<SchemeScreen> createState() => _SchemeScreenState();
}

class _SchemeScreenState extends State<SchemeScreen>
    with TickerProviderStateMixin {
  bool ios = true;
  final amountController = TextEditingController();

  int totalpayed = 0;
  bool? vis;
  String? userSchemename;
  Sheduledmodel? data;
  dynamic paymentpendingid;
  dynamic schemeId;
  dynamic schemeAmountId;
  dynamic paymentStartDates;
  dynamic paymentEndDates;
  String? upistatus;
  int? role;

  // Gold rate data
  model.Dashboardmodel? dashboardData;
  String? gram;
  String? change;
  bool updown = false;
  String? today;

  // Animation controllers
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    getdata();
    getProfile();
    getrole();
    getPaymentdetails();
    _getDashboardData();
  }

  void _initializeAnimations() {
    _fadeController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(begin: Offset(0, 0.3), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  bool load = true;

  @override
  Widget build(BuildContext context) {
    return load == true
        ? Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          )
        : FadeTransition(
            opacity: _fadeAnimation,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10),

                  // Gold Rate Section
                  _buildGoldRateSection(),

                  SizedBox(height: 20),

                  // Scheme Details Card
                  _buildSchemeDetailsCard(),

                  SizedBox(height: 20),

                  // Payment Actions Section
                  _buildPaymentActionsSection(),

                  SizedBox(height: 30),
                ],
              ),
            ),
          );
  }

  Widget _buildGoldRateSection() {
    if (dashboardData == null) {
      return Container(
        margin: EdgeInsets.all(16),
        height: 100,
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 197, 19, 1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }

    return SlideTransition(
      position: _slideAnimation,
      child: Container(
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 197, 19, 1),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              // Header Row
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.asset(
                      "assets/pngIcons/coinIcon.png",
                      height: 32,
                      width: 32,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Today's Gold Rate",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          today ??
                              DateFormat('dd MMM, yyyy').format(DateTime.now()),
                          style: TextStyle(fontSize: 13, color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              // Rates Row with Fixed Height Containers
              IntrinsicHeight(
                child: Row(
                  children: [
                    // Per Gram Rate
                    Expanded(
                      child: Container(
                        height: 80, // Fixed height for alignment
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "₹${dashboardData!.data.todayRate.toString().split(".")[0]}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              "Per Gram",
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(width: 8),

                    // 8 Gram Rate
                    Expanded(
                      child: Container(
                        height: 80, // Fixed height for alignment
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "₹${gram?.toString().split(".")[0] ?? '0'}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              "8 Grams",
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(width: 8),

                    // Change Rate
                    Expanded(
                      child: Container(
                        height: 80, // Fixed height for alignment
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      "₹${change?.toString().split(".")[0] ?? '0'}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 2),
                                Lottie.asset(
                                  updown
                                      ? "assets/up.json"
                                      : "assets/down.json",
                                  height: 16,
                                  width: 16,
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Text(
                              "Change",
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSchemeDetailsCard() {
    return SlideTransition(
      position: _slideAnimation,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor.withOpacity(0.8),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 15,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Background pattern
            Positioned(
              right: -50,
              top: -50,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Scheme Header
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.savings,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data?.data?.schemeName?.toString() ??
                                  "My Gold Scheme",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Active Plan",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 24),

                  // Stats Row - Only show Total Paid and Total Gold
                  Row(
                    children: [
                      _buildStatItem(
                        "Total Paid",
                        data?.data?.sumAmount != null
                            ? "₹${data!.data!.sumAmount}"
                            : "₹0",
                        Icons.account_balance_wallet,
                      ),
                      SizedBox(width: 20),
                      _buildStatItem(
                        "Total Gold",
                        _getTotalGramText(),
                        Icons.diamond,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentActionsSection() {
    return SlideTransition(
      position: _slideAnimation,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            // Pending Payment Card
            Expanded(
              child: _buildPaymentCard(
                title: "Pending Payment",
                amount: data?.data?.monthlyAmont != null
                    ? "₹${data!.data!.monthlyAmont.toString().split('.')[0]}"
                    : "₹0",
                subtitle: "Due Now",
                color: Colors.orange,
                icon: Icons.payment,
                isPayButton: true,
              ),
            ),

            SizedBox(width: 16),

            // Next Payment Card
            Expanded(
              child: _buildPaymentCard(
                title: "Next Payment",
                amount: data?.data?.monthlyAmont != null
                    ? "₹${data!.data!.monthlyAmont.toString().split('.')[0]}"
                    : "₹0",
                subtitle: _getUpcomingDueDate(),
                color: Colors.blue,
                icon: Icons.schedule,
                isPayButton: false,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentCard({
    required String title,
    required String amount,
    required String subtitle,
    required Color color,
    required IconData icon,
    required bool isPayButton,
  }) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
        border: Border.all(color: color.withOpacity(0.2), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 16),

          Text(
            amount,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),

          SizedBox(height: 8),

          if (isPayButton && (role == 2 || role == 4))
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _handlePaymentAction(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 2,
                ),
                child: Text(
                  "PAY NOW",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            )
          else
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Get dashboard data for gold rates
  Future<void> _getDashboardData() async {
    try {
      today = DateFormat('dd MMM, yyyy').format(DateTime.now());

      model.Dashboardmodel? datas = await Dashbordservice.getDashboard();

      if (datas.success) {
        gram = (double.parse(datas.data.todayRate) * 8).toString();

        if (double.parse(datas.data.todayRate) >
            double.parse(datas.data.gramPrevious)) {
          change =
              ((double.parse(datas.data.todayRate) -
                          double.parse(datas.data.gramPrevious)) *
                      8)
                  .toString();
          updown = true;
        } else {
          change =
              ((double.parse(datas.data.gramPrevious) -
                          double.parse(datas.data.todayRate)) *
                      8)
                  .toString();
          updown = false;
        }

        setState(() {
          dashboardData = datas;
        });
      }
    } catch (e) {
      print("Error getting dashboard data: $e");
    }
  }

  // Helper Methods
  String _getTotalGramText() {
    if (paymntload == true || paymentData?.data.paymentsList.isEmpty == true) {
      return "0g";
    }

    final branchId = paymentData!.data.paymentsList[0].branchId;
    final schemeName = paymentData!.data.schemeName;

    if (schemeName == "UNLIMTED PACKAGE WITH MC" ||
        (branchId == 2 && schemeName == "Marriage Package") ||
        branchId == 4 ||
        branchId == 5 ||
        (branchId == 6 && schemeName != "MONTHLY SCHEME") ||
        (branchId == 14906 &&
            (schemeName == "Daily Scheme" ||
                schemeName == "SKY GOLD SCHEME")) ||
        (branchId == 2 && schemeName == "SKY GOLD  TAARA  SCHEME") ||
        (branchId == 3 &&
            (schemeName == "11 MONTH SCHEME DAILY WITHOUT MC" ||
                schemeName == "SKY GOLD TAARA SCHEME")) ||
        (branchId == 27114 && schemeIddd == 30)) {
      return paymentData!.data.sumGram;
    }

    return "0g";
  }

  String _getUpcomingDueDate() {
    if (data?.data?.upcomingPayment?.isNotEmpty == true) {
      final upcomingPayment = data!.data!.upcomingPayment!.first;
      if (upcomingPayment.paymentEndDates != null) {
        return "Due: ${DateFormat("dd MMM").format(upcomingPayment.paymentEndDates!)}";
      }
    }
    return "No due date";
  }

  void _handlePaymentAction() async {
    if (await getSavedObject("roleid") == 2 ||
        await getSavedObject("roleid") == 4) {
      Map details = {
        'type': data!.data!.paymentType,
        'UserId': await getSavedObject('userid'),
        'toamount': data!.data!.amountTo,
        'SheduledDateId': paymentpendingid,
        'gram': data!.data!.todayEarnings.toString(),
        'amount': data!.data!.monthlyAmont,
        'taransactionId': "nill",
        'subscriptionId': await getSavedObject('subscription'),
        'paidBy': await getSavedObject('userid'),
        'todaysrate': data!.data!.todayRate,
        'schemetype': data!.data!.schemetype!.toString(),
        'average': data!.data!.average.toString(),
        'currentstatus': data!.data!.half.toString(),
      };

      if (upistatus!.compareTo("0") == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewPaymentScreen(arguments: details),
          ),
        ).then((value) {
          getProfile();
        });
      } else {
        showToast("You have already made a payment waiting for approval");
      }
    } else if (await getSavedObject("roleid") == 3) {
      data!.data!.paymentType == 0
          ? showAlertDialog(context)
          : showAlertDialogvarient(context);
    }
  }

  // Original methods (keeping all existing functionality)
  var schemeIddd;

  getrole() async {
    role = await getSavedObject("roleid");
    schemeIddd = await getSavedObject("schemeIddd");
    print(role);
  }

  getdata() async {
    int z = await getSavedObject('userid');
    var ph = await getSavedObject('phone');

    bool b = ph == iosPhoneUser ? false : true;
    print(b);
    setState(() {
      ios = b;
    });
  }

  void getProfile() async {
    totalpayed = 0;
    vis = false;
    Map details = {
      'UserId': await getSavedObject("roleid") == 3
          ? await getSavedObject("customerid")
          : await getSavedObject('userid'),
      'subscriptionId': await getSavedObject('subscription'),
    };

    print(details);
    try {
      //   Loading.show(context);
      Sheduledmodel datas = await Sheduledservice.postService(details);
      print("Reached here");

      setState(() {
        data = datas;
        load = false;
      });

      if (datas.data!.subs!.userSchemeName != null) {
        userSchemename = datas.data!.subs!.userSchemeName.toString();
      }

      data!.data!.schemetype != 1
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
              paymentpendingid = data!.data!.upcomingPayment!.elementAt(0).id;
              schemeId = data!.data!.upcomingPayment!.elementAt(0).schemeId;
              schemeAmountId = data!.data!.upcomingPayment!
                  .elementAt(0)
                  .schemeAmountId;
              upistatus = data!.data!.upcomingPayment!
                  .elementAt(0)
                  .upiStatus
                  .toString();
              vis = true;
            });

      Loading.dismiss();
    } catch (e) {
      Loading.dismiss();
      print(e);
    }
  }

  showAlertDialog(BuildContext context) {
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
          data!.data!.monthlyAmont!,
          data!.data!.todayEarnings.toString(),
        );
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Payment"),
      content: const Text("Would you like to continue with the payment?"),
      actions: [cancelButton, continueButton],
    );

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
                  double.parse(data!.data!.amountTo.toString())) &&
              (double.parse(amountController.text.toString()) >=
                  double.parse(data!.data!.monthlyAmont.toString()))) {
            Navigator.pop(context);
            agentpay(amountController.text.toString(), finalgram);
          } else {
            showToast("Please enter amount within range");
          }
        } catch (e) {
          showToast("Please enter amount within range");
        }
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Payment"),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            height: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Please enter the amount to pay?"),
                Center(
                  child: Container(
                    width: 150,
                    height: 50,
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: "Enter amount",
                        counterText: "",
                      ),
                      controller: amountController,
                      maxLength: 8,
                      onChanged: (value) {
                        setState(() {
                          print(value + "test");
                          if (value.isEmpty) {
                            gram = 0;
                            finalgram = "";
                          } else {
                            gram =
                                double.parse(value) /
                                double.parse(data!.data!.todayRate.toString());
                            finalgram = gram.toStringAsFixed(3);
                          }
                        });
                      },
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
      actions: [cancelButton, continueButton],
    );

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
      //  Loading.show(context);
      Paymentmodel datas = await Paymentservice.postPay(details);
      print("Reached here");

      Loading.dismiss();
      getProfile();
    } catch (e) {
      Loading.dismiss();
      print(e);
    }
  }

  Paymentdetailsmodel? paymentData;
  bool paymntload = true;

  getPaymentdetails() async {
    Map details = {
      'UserId': await getSavedObject("roleid") == 3
          ? await getSavedObject("customerid")
          : await getSavedObject('userid'),
      'subscriptionId': await getSavedObject('subscription'),
    };
    Paymentdetailsmodel datas;
    print(details);
    try {
      datas = await Paymentdetailsservice.postService(details);

      setState(() {
        paymentData = datas;
        paymntload = false;
      });

      print("Reached here paymentttt");
    } catch (e) {
      Loading.dismiss();
      print(e);
    }
  }
}
