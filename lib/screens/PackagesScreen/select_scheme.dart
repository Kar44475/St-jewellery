import 'package:flutter/material.dart';
import 'package:stjewellery/screens/main_screens/top_navigation.dart';
import 'package:stjewellery/Constant/constants.dart';
import 'package:stjewellery/utils/utils.dart';
import 'package:stjewellery/model/Sheduledmodel.dart';
import 'package:stjewellery/model/Subscriptionlistmodel.dart';
import 'package:stjewellery/model/paymentmodel.dart';
import 'package:stjewellery/screens/PackagesScreen/select_new_scheme.dart';
import 'package:stjewellery/service/Paymentservice.dart';
import 'package:stjewellery/service/Schemelistgetservice.dart';
import 'package:stjewellery/service/Sheduledservice.dart';

class SelectScheme extends StatefulWidget {
  @override
  _SelectSchemeState createState() => _SelectSchemeState();
}

class _SelectSchemeState extends State<SelectScheme> {
  // Loading states
  Map<int, bool> _buttonLoadingStates = {};
  bool _isPageLoading = true;
  bool _isPaymentButtonPressed = false;

  // User data
  int? _selectedSchemeIndex;
  int? _userRole;
  String _memberName = "";
  bool _isAgent = false; // Add agent check

  // Scheme data
  List<int> _subscriptionIds = [];
  List<int> _schemeAmountIds = [];
  Subscriptionlistmodel? _subscriptionData;

  // Payment data
  dynamic _pendingPaymentId;
  int _totalPaidCount = 0;
  bool? _isPaymentVisible;
  Sheduledmodel? _scheduleData;
  dynamic _currentSchemeId;
  dynamic _currentSchemeAmountId;
  dynamic _paymentStartDate;
  dynamic _paymentEndDate;
  String? _upiPaymentStatus;

  // Controllers
  TextEditingController _paymentAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _loadSchemeData();
      _getUserRole();
      _checkIfAgent();
    });
  }

  @override
  void dispose() {
    _paymentAmountController.dispose();
    super.dispose();
  }

  /// Gets user role from storage
  Future<void> _getUserRole() async {
    _userRole = await getSavedObject("roleid");
  }

  /// Check if user is an agent
  Future<void> _checkIfAgent() async {
    var referalId = await getSavedObject("referalId");
    setState(() {
      _isAgent = referalId != null && referalId.toString().isNotEmpty;
    });
  }

  /// Loads scheme data from API
  Future<void> _loadSchemeData() async {
    _memberName = await getSavedObject("name");
    int userId;
    _subscriptionIds.clear();
    _schemeAmountIds.clear();

    try {
      Loading.show(context);
      userId = await getSavedObject("roleid") == 3
          ? await getSavedObject("customerid")
          : await getSavedObject("userid");

      Subscriptionlistmodel responseData = await Schemelistgetservice.getScheme(
        userId,
      );
      Loading.dismiss();

      setState(() {
        _subscriptionData = responseData;
        print(_subscriptionData);
        _isPageLoading = false;
      });

      _subscriptionData!.data.subscriptionList.forEach((subscription) {
        _subscriptionIds.add(subscription.id);
        _schemeAmountIds.add(subscription.schemeAmountId);
      });
    } catch (e) {
      Loading.dismiss();
      print("Error loading scheme data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_userRole == 2 || _userRole == 4) {
          return false;
        } else {
          Navigator.pop(context);
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: _buildNewSchemeButton(),
        appBar: _buildAppBar(),
        body: _isPageLoading
            ? const Center(child: CircularProgressIndicator())
            : _buildBody(),
      ),
    );
  }

  /// Builds the app bar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: (_userRole == 2 || _userRole == 4)
          ? null
          : IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.black),
            ),
      title: const Text(
        "Choose Scheme",
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: false,
    );
  }

  /// Builds the floating action button for new scheme
  Widget _buildNewSchemeButton() {
    return FloatingActionButton.extended(
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () {
        Navigate.push(context, SelectNewScheme());
      },
      icon: const Icon(Icons.add, color: Colors.white),
      label: const Text(
        "New Scheme",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
    );
  }

  /// Builds the main body content
  Widget _buildBody() {
    return Column(
      children: [
        Expanded(
          child: _subscriptionData!.data.subscriptionList.isEmpty
              ? _buildEmptyState()
              : _buildSchemeList(),
        ),
        const SizedBox(height: 5),
      ],
    );
  }

  /// Builds empty state when no schemes are available
  Widget _buildEmptyState() {
    return const Center(
      child: Text(
        "No scheme selected \nPlease select a scheme",
        style: TextStyle(color: Colors.black, fontSize: 16),
        textAlign: TextAlign.center,
      ),
    );
  }

  /// Builds the list of available schemes
  Widget _buildSchemeList() {
    return ListView.builder(
      itemCount: _subscriptionData!.data.subscriptionList.length,
      itemBuilder: (BuildContext context, int index) {
        final subscription = _subscriptionData!.data.subscriptionList[index];
        bool isSelected = _selectedSchemeIndex == index;

        return Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20, top: 15),
          child: GestureDetector(
            onTap: () => _handleSchemeSelection(index),
            child: _buildSchemeCard(subscription, index, isSelected),
          ),
        );
      },
    );
  }

  /// Handles scheme selection
  Future<void> _handleSchemeSelection(int index) async {
    // For agents with pay button enabled, don't change selection color
    // For admin users (role 2 or 4), handle selection and navigation
    if (_userRole == 2 || _userRole == 4) {
      setState(() {
        _selectedSchemeIndex = index;
      });
      await saveObject("subscription", _subscriptionIds.elementAt(index));
      await saveObject("schemeAmountId", _schemeAmountIds.elementAt(index));
      Navigate.pushReplacement(context, TopNavigation());
    } else if (!_isAgent) {
      // For regular users (non-agents), allow selection
      setState(() {
        _selectedSchemeIndex = index;
      });
    }
    // For agents, do nothing on tap - they should use the pay button
  }

  /// Builds individual scheme card
  Widget _buildSchemeCard(dynamic subscription, int index, bool isSelected) {
    // For agents, don't show selection color change
    bool showSelection = !_isAgent && isSelected;

    return Container(
      decoration: BoxDecoration(
        boxShadow: [shadow],
        color: showSelection
            ? const Color.fromRGBO(255, 203, 3, 1)
            : Colors.white,
        border: Border.all(
          color: const Color.fromRGBO(255, 203, 3, 1),
          width: 2,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          children: [
            _buildSchemeHeader(subscription),
            _buildSchemeDivider(),
            _buildSchemeAmount(subscription),
            _buildActionButtons(subscription, index),
          ],
        ),
      ),
    );
  }

  /// Builds scheme header with name and member info
  Widget _buildSchemeHeader(dynamic subscription) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildInfoColumn("Scheme Name", subscription.schemeName.toString()),
          _buildInfoColumn("Member Name", _memberName),
        ],
      ),
    );
  }

  /// Builds info column with title and value
  Widget _buildInfoColumn(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.black.withOpacity(0.6),
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  /// Builds divider line
  Widget _buildSchemeDivider() {
    return Divider(
      height: 30,
      indent: 20,
      endIndent: 20,
      color: Colors.black.withOpacity(0.2),
    );
  }

  /// Builds scheme amount section
  Widget _buildSchemeAmount(dynamic subscription) {
    return subscription.subscriptionType == 0
        ? _buildFixedAmount(subscription)
        : _buildVariableAmount(subscription);
  }

  /// Builds fixed amount display
  Widget _buildFixedAmount(dynamic subscription) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildInfoColumn(
            "Scheme Amount",
            rs + subscription.schemAmount.toString().split('.')[0],
          ),
        ],
      ),
    );
  }

  /// Builds variable amount display with vertical divider
  Widget _buildVariableAmount(dynamic subscription) {
    return IntrinsicHeight(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildInfoColumn(
              "Min Amount",
              rs + subscription.schemAmount.toString().split('.')[0],
            ),
            VerticalDivider(color: Colors.black.withOpacity(0.2), thickness: 1),
            _buildInfoColumn(
              "Max Amount",
              rs + subscription.amountTo.toString().split('.')[0],
            ),
          ],
        ),
      ),
    );
  }

  /// Builds action buttons section
  Widget _buildActionButtons(dynamic subscription, int index) {
    return Column(
      children: [
        // Pay button (only for non-admin users)
        if (_userRole != 2 && _userRole != 4)
          _buildPayButton(subscription, index),

        // View Customer button - commented out as requested
        // _buildViewCustomerButton(index),
      ],
    );
  }

  /// Builds pay button
  Widget _buildPayButton(dynamic subscription, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: _buttonLoadingStates[index] == true
          ? _buildLoadingButton()
          : _buildPayActionButton(subscription, index),
    );
  }

  /// Builds loading button
  Widget _buildLoadingButton() {
    return Container(
      height: 40,
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  /// Builds pay action button
  Widget _buildPayActionButton(dynamic subscription, int index) {
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () => _handlePayButtonPress(subscription, index),
        child: const Text(
          "Pay",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  /// Handles pay button press
  Future<void> _handlePayButtonPress(dynamic subscription, int index) async {
    setState(() {
      _buttonLoadingStates[index] = true;
      _isPaymentButtonPressed = true;
    });

    await _getPaymentProfile(subscription.userId, subscription.id);

    setState(() {
      _buttonLoadingStates[index] = false;
    });
  }

  /// Handles view customer action
  Future<void> _handleViewCustomer(int index) async {
    await saveObject("subscription", _subscriptionIds.elementAt(index));
    await saveObject("schemeAmountId", _schemeAmountIds.elementAt(index));
    Navigate.push(context, TopNavigation());
  }

  /// Gets payment profile data
  Future<void> _getPaymentProfile(int userId, int subscriptionId) async {
    _totalPaidCount = 0;
    _isPaymentVisible = false;

    Map paymentDetails = {'UserId': userId, 'subscriptionId': subscriptionId};

    print(paymentDetails);
    try {
      Sheduledmodel responseData = await Sheduledservice.postService(
        paymentDetails,
      );
      print("Payment profile loaded");

      setState(() {
        _scheduleData = responseData;
      });

      _processPaymentData(responseData);

      setState(() {
        _isPaymentButtonPressed = false;
      });

      _scheduleData!.data!.paymentType == 0
          ? _showFixedPaymentDialog(context, userId, subscriptionId)
          : _showVariablePaymentDialog(context, userId, subscriptionId);
    } catch (e) {
      setState(() {
        _isPaymentButtonPressed = false;
      });
      print("Error getting payment profile: $e");
    }
  }

  /// Processes payment data from response
  void _processPaymentData(Sheduledmodel responseData) {
    if (responseData.data!.schemetype != 1) {
      responseData.data!.sheduledList!.forEach((element) {
        if (element.status == 2) {
          _totalPaidCount++;
        } else if (element.status == 1) {
          setState(() {
            _pendingPaymentId = element.id;
            _currentSchemeId = element.schemeId;
            _currentSchemeAmountId = element.schemeAmountId;
            _paymentStartDate = element.paymentStartDates;
            _paymentEndDate = element.paymentEndDates;
            _upiPaymentStatus = element.upiStatus.toString();
            _isPaymentVisible = true;
          });
        }
      });
    } else {
      setState(() {
        _pendingPaymentId = responseData.data!.upcomingPayment!.elementAt(0).id;
        _currentSchemeId = responseData.data!.upcomingPayment!
            .elementAt(0)
            .schemeId;
        _currentSchemeAmountId = responseData.data!.upcomingPayment!
            .elementAt(0)
            .schemeAmountId;
        _upiPaymentStatus = responseData.data!.upcomingPayment!
            .elementAt(0)
            .upiStatus
            .toString();
        _isPaymentVisible = true;
      });
    }
  }

  /// Shows fixed payment dialog
  void _showFixedPaymentDialog(
    BuildContext context,
    int userId,
    int subscriptionId,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 10,
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 15,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header Section with Icon
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).primaryColor,
                        Theme.of(context).primaryColor.withOpacity(0.8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(
                          Icons.payment,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        "Payment Confirmation",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                // Content Section
                Padding(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    children: [
                      // Amount Display Card
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).primaryColor.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Theme.of(
                              context,
                            ).primaryColor.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Payment Amount",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "${rs}${_scheduleData!.data!.monthlyAmont}",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20),

                      // Additional Info
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: Colors.blue,
                              size: 20,
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                "This payment will be processed immediately and cannot be undone.",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[700],
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 24),

                      // Confirmation Text
                      Text(
                        "Would you like to continue with the payment?",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                // Action Buttons
                Padding(
                  padding: EdgeInsets.only(left: 24, right: 24, bottom: 24),
                  child: Row(
                    children: [
                      // Cancel Button
                      Expanded(
                        child: Container(
                          height: 50,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: Colors.grey[400]!,
                                width: 1.5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 16),

                      // Continue Button
                      Expanded(
                        child: Container(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              _processAgentPayment(
                                _scheduleData!.data!.monthlyAmont!,
                                _scheduleData!.data!.todayEarnings.toString(),
                                userId,
                                subscriptionId,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              foregroundColor: Colors.white,
                              elevation: 3,
                              shadowColor: Theme.of(
                                context,
                              ).primaryColor.withOpacity(0.3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.check_circle_outline, size: 20),
                                SizedBox(width: 8),
                                Text(
                                  "Continue",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showVariablePaymentDialog(
    BuildContext context,
    int userId,
    int subscriptionId,
  ) {
    double calculatedGram = 0;
    String finalGramAmount = "";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              title: const Text(
                "Payment Amount",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Range: ${rs}${_scheduleData!.data!.monthlyAmont} - ${rs}${_scheduleData!.data!.amountTo}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text("Please enter the amount to pay:"),
                  const SizedBox(height: 10),
                  Container(
                    width: 150,
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: "Enter amount",
                        counterText: "",
                        border: OutlineInputBorder(),
                      ),
                      controller: _paymentAmountController,
                      maxLength: 8,
                      onChanged: (value) {
                        setState(() {
                          if (value.isEmpty) {
                            calculatedGram = 0;
                            finalGramAmount = "";
                          } else {
                            try {
                              calculatedGram =
                                  double.parse(value) /
                                  double.parse(
                                    _scheduleData!.data!.todayRate.toString(),
                                  );
                              finalGramAmount = calculatedGram.toStringAsFixed(
                                3,
                              );
                            } catch (e) {
                              calculatedGram = 0;
                              finalGramAmount = "";
                            }
                          }
                        });
                      },
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (finalGramAmount.isNotEmpty)
                    Text(
                      "Gold: ${finalGramAmount}g",
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                ],
              ),
              actions: [
                TextButton(
                  child: const Text("Cancel"),
                  onPressed: () {
                    _paymentAmountController.clear();
                    Navigator.pop(context);
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  child: const Text("Continue"),
                  onPressed: () {
                    try {
                      double enteredAmount = double.parse(
                        _paymentAmountController.text,
                      );
                      double minAmount = double.parse(
                        _scheduleData!.data!.monthlyAmont.toString(),
                      );
                      double maxAmount = double.parse(
                        _scheduleData!.data!.amountTo.toString(),
                      );

                      if (enteredAmount >= minAmount &&
                          enteredAmount <= maxAmount) {
                        Navigator.pop(context);
                        _processAgentPayment(
                          _paymentAmountController.text,
                          finalGramAmount,
                          userId,
                          subscriptionId,
                        );
                      } else {
                        showToast("Please enter amount within range");
                      }
                    } catch (e) {
                      showToast("Please enter a valid amount");
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  /// Processes agent payment
  Future<void> _processAgentPayment(
    String amount,
    String gram,
    int userId,
    int subscriptionId,
  ) async {
    Map paymentDetails = {
      'UserId': userId,
      'SheduledDateId': _pendingPaymentId,
      'gram': gram,
      'amount': amount,
      'taransactionId': "nil",
      'subscriptionId': subscriptionId,
      'paidBy': await getSavedObject('userid'),
    };

    print("Payment details: $paymentDetails");

    try {
      Loading.show(context);
      Paymentmodel responseData = await Paymentservice.postPay(paymentDetails);
      print("Payment processed successfully");
      Loading.dismiss();

      // Refresh the scheme data
      _loadSchemeData();

      showToast("Payment processed successfully");
    } catch (e) {
      Loading.dismiss();
      print("Payment error: $e");
      showToast("Payment failed. Please try again.");
    }
  }
}
