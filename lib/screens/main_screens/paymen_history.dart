import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stjewellery/drawer/drawer.dart';
import 'package:stjewellery/Utils/utils.dart';
import 'package:stjewellery/model/Paymentdetailsmodel.dart';
import 'package:stjewellery/model/Sheduledmodel.dart';
import 'package:stjewellery/screens/Recepit/Recepit.dart';
import 'package:stjewellery/screens/Scheme_View/ViewAllPaymentHistory.dart';
import 'package:stjewellery/service/Paymentdetailsserivce.dart';
import 'package:stjewellery/service/Sheduledservice.dart';

import '../../Constant/constants.dart';

class PaymentHistoryScreen extends StatefulWidget {
  const PaymentHistoryScreen({Key? key}) : super(key: key);

  @override
  State<PaymentHistoryScreen> createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {
  Sheduledmodel? data;
  Paymentdetailsmodel? paymentData;
  bool isLoading = true;
  int? role;
  var schemeIddd;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    try {
      setState(() {
        isLoading = true;
      });

      await _loadRole();

      await Future.wait([_loadProfile(), _loadPaymentDetails()]);
    } catch (e) {
      print("Error initializing data: $e");
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> _loadRole() async {
    try {
      role = await getSavedObject("roleid");
      schemeIddd = await getSavedObject("schemeIddd");
      print("Role loaded: $role");
    } catch (e) {
      print("Error loading role: $e");
    }
  }

  Future<void> _loadProfile() async {
    try {
      Map details = {
        'UserId': role == 3
            ? await getSavedObject("customerid")
            : await getSavedObject('userid'),
        'subscriptionId': await getSavedObject('subscription'),
      };

      print("Profile details: $details");
      Sheduledmodel profileData = await Sheduledservice.postService(details);

      if (mounted) {
        setState(() {
          data = profileData;
        });
      }
      print("Profile loaded successfully");
    } catch (e) {
      print("Error loading profile: $e");
    }
  }

  Future<void> _loadPaymentDetails() async {
    try {
      Map details = {
        'UserId': role == 3
            ? await getSavedObject("customerid")
            : await getSavedObject('userid'),
        'subscriptionId': await getSavedObject('subscription'),
      };

      print("Payment details request: $details");
      Paymentdetailsmodel paymentDetailsData =
          await Paymentdetailsservice.postService(details);

      if (mounted) {
        setState(() {
          paymentData = paymentDetailsData;
        });
      }
      print("Payment details loaded successfully");
    } catch (e) {
      print("Error loading payment details: $e");
    }
  }

  void _showBottomDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: DrawerWidget(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading ? _buildLoadingWidget() : _buildMainContent(),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
            strokeWidth: 3,
          ),
          SizedBox(height: 20),
          Text(
            "Loading payment history...",
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Please wait while we fetch your data",
            style: TextStyle(color: Colors.grey[500], fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          color: Colors.white,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Column(
                children: [
                  const Text(
                    "PAYMENT HISTORY",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(height: 2, width: 180, color: Colors.black),
                ],
              ),

              const SizedBox(height: 20),

              if (paymentData?.data?.schemeName != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Theme.of(context).primaryColor.withOpacity(0.3),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Scheme: ${paymentData!.data!.schemeName}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      if (paymentData?.data?.sumAmount != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            "Total Paid: $rs${paymentData!.data!.sumAmount}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      if (paymentData?.data?.sumGram != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            "Total Gold: ${paymentData!.data!.sumGram}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

              Expanded(child: _buildPaymentHistoryList()),
            ],
          ),
        ),

        if (role != 2 && role != 4)
          Positioned(
            top: 40,
            left: 20,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildPaymentHistoryList() {
    if (paymentData?.data?.paymentsList?.isEmpty ?? true) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.payment, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              "No payment history available",
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Your payment history will appear here once you make payments",
              style: TextStyle(color: Colors.grey[500], fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _initializeData,
      color: Theme.of(context).primaryColor,
      child: ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: paymentData!.data!.paymentsList!.length,
        itemBuilder: (context, index) {
          final payment = paymentData!.data!.paymentsList![index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _getPaymentStatusColor(payment),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(Icons.person, color: Colors.white, size: 20),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getPaymentDate(payment),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Amount: ${_getPaymentAmount(payment)}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Gold: ${_getPaymentGram(payment)}",
                        style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                      ),
                      // if (_getPaymentStatus(payment).isNotEmpty)
                      //   Padding(
                      //     padding: const EdgeInsets.only(top: 4),
                      //     child: Container(
                      //       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      //       decoration: BoxDecoration(
                      //         color: _getPaymentStatusColor(payment).withOpacity(0.1),
                      //         borderRadius: BorderRadius.circular(4),
                      //       ),
                      //       child: Text(
                      //         _getPaymentStatus(payment),
                      //         style: TextStyle(
                      //           fontSize: 11,
                      //           color: _getPaymentStatusColor(payment),
                      //           fontWeight: FontWeight.w600,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                    ],
                  ),
                ),

                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextButton(
                    onPressed: () => _viewReceipt(payment),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      "Receipt",
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _getPaymentDate(dynamic payment) {
    try {
      if (payment.paymentDate != null) {
        return DateFormat("dd-MMM-yyyy").format(payment.paymentDate);
      }
    } catch (e) {
      print("Error formatting payment date: $e");
    }
    return "Date not available";
  }

  String _getPaymentAmount(dynamic payment) {
    try {
      if (payment.amount != null) {
        return "$rs${payment.amount}";
      }
    } catch (e) {
      print("Error getting payment amount: $e");
    }
    return "₹0";
  }

  String _getPaymentGram(dynamic payment) {
    try {
      if (payment.gram != null) {
        return "${payment.gram}g";
      }
    } catch (e) {
      print("Error getting payment gram: $e");
    }
    return "0g";
  }

  String _getPaymentStatus(dynamic payment) {
    try {
      if (payment.status != null) {
        switch (payment.status) {
          case 1:
            return "Pending";
          case 2:
            return "Completed";
          case 3:
            return "Failed";
          default:
            return "Unknown";
        }
      }
    } catch (e) {
      print("Error getting payment status: $e");
    }
    return "";
  }

  Color _getPaymentStatusColor(dynamic payment) {
    try {
      if (payment.status != null) {
        switch (payment.status) {
          case 1:
            return Colors.orange;
          case 2:
            return Colors.green;
          case 3:
            return Colors.red;
          default:
            return Colors.grey;
        }
      }
    } catch (e) {
      print("Error getting payment status color: $e");
    }
    return Colors.grey;
  }

  IconData _getPaymentStatusIcon(dynamic payment) {
    try {
      if (payment.status != null) {
        switch (payment.status) {
          case 1:
            return Icons.pending;
          case 2:
            return Icons.check;
          case 3:
            return Icons.close;
          default:
            return Icons.help;
        }
      }
    } catch (e) {
      print("Error getting payment status icon: $e");
    }
    return Icons.help;
  }

  bool _isPaymentCompleted(dynamic payment) {
    try {
      //
      return payment.status == 2;
    } catch (e) {
      print("Error checking payment completion: $e");
      return false;
    }
  }

  void _viewReceipt(dynamic payment) {
    try {
      var paymentId = payment.sheduledDateId;

      if (paymentId != null) {
        Navigate.push(context, Receipt(arguments: paymentId));
      } else {
        showToast("Receipt not available - Payment ID missing");
      }
    } catch (e) {
      print("Error opening receipt: $e");
      showToast("Unable to open receipt");
    }
  }

  void _viewAllPaymentHistory() {
    if (data?.data?.paidPayment != null) {
      Map details = {
        "tittle": "Payment History",
        "list": data!.data!.paidPayment,
        "containerColor": "F8D7DA",
        "textColor": "155724",
        "schemeType": data!.data!.schemetype,
      };

      Navigate.push(context, ViewAllPaymentHistory(arguments: details));
    }
  }
}
