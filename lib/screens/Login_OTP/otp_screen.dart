import 'dart:async';
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stjewellery/screens/Login_OTP/sms_otp_template.dart';
import 'package:stjewellery/support_widget/essential.dart';
import 'package:stjewellery/agent_module/agent_home_screen/agent_tab.dart';
import 'package:stjewellery/model/user_model.dart';
import 'package:stjewellery/screens/PackagesScreen/select_scheme.dart';
import 'package:stjewellery/screens/Registration/RegisterPage.dart';
import 'package:stjewellery/service/Userservice.dart';

class OtpPage extends StatefulWidget {
  final generatedOtp;
  final mobile;

  const OtpPage({super.key, this.generatedOtp, this.mobile});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  static const int _countdownStartTime = 30;
  int _remainingCountdownTime = _countdownStartTime;
  Timer? _countdownTimer;
  bool _isResendEnabled = false;

  final List<TextEditingController> _otpInputControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _otpFocusNodes = List.generate(
    6,
    (index) => FocusNode(),
  );

  String? _firebaseToken;
  String? _userMobileNumber;
  String? _currentOtpCode;
  int? _generatedRandomOtp;

  bool _isVerifyButtonPressed = false;

  static const String _debugMobileNumber = "+919562044475";
  static const int _otpLength = 6;
  static const int _agentRoleId = 3;

  @override
  void initState() {
    super.initState();
    _initializeUserData();
    Future.delayed(Duration.zero, () {
      _handleSpecialUserLogin();
      _startOtpCountdown();
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _disposeControllers();
    _disposeFocusNodes();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          _buildHeaderSection(context, screenWidth),
          _buildOtpFormSection(context, screenHeight),
        ],
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context, double screenWidth) {
    return Expanded(
      flex: 9,
      child: Container(
        color: Theme.of(context).primaryColor,
        width: double.infinity,
        child: SafeArea(
          child: Column(
            children: [
              _buildBackButton(context),
              _buildLogoSection(screenWidth),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 24),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  Widget _buildLogoSection(double screenWidth) {
    return Expanded(
      child: Center(
        child: Image.asset(
          "assets/pngIcons/mainIcons.png",
          width: screenWidth * 0.4,
          height: screenWidth * 0.4,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildOtpFormSection(BuildContext context, double screenHeight) {
    return Expanded(
      flex: 11,
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Container(
          width: double.infinity,
          decoration: _getFormContainerDecoration(),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: screenHeight * 0.5 - 64),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    _buildOtpTitle(context),
                    const SizedBox(height: 12),
                    _buildOtpInstructions(),
                    const SizedBox(height: 32),
                    _buildOtpInputFields(),
                    const SizedBox(height: 24),
                    _buildResendSection(context),
                    const Spacer(),
                    _buildVerifyButton(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _getFormContainerDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 10,
          offset: const Offset(0, -5),
        ),
      ],
    );
  }

  Widget _buildOtpTitle(BuildContext context) {
    return Text(
      "ENTER OTP",
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).primaryColor,
        letterSpacing: 1.5,
      ),
    );
  }

  Widget _buildOtpInstructions() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black,
          fontWeight: FontWeight.w400,
          height: 1.5,
        ),
        children: [
          const TextSpan(
            text: "A 6-digit OTP has been sent to your registered mobile ",
          ),
          TextSpan(text: "\nnumber ${widget.mobile}\n"),
          const TextSpan(
            text: "please enter the OTP below to verify your identity",
          ),
        ],
      ),
    );
  }

  Widget _buildOtpInputFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(_otpLength, (index) {
        return _buildSingleOtpField(index);
      }),
    );
  }

  Widget _buildSingleOtpField(int index) {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: TextFormField(
        controller: _otpInputControllers[index],
        focusNode: _otpFocusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        decoration: const InputDecoration(
          counterText: "",
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: (value) => _handleOtpFieldChange(value, index),
      ),
    );
  }

  Widget _buildResendSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (_isResendEnabled)
          GestureDetector(
            onTap: _handleResendOtp,
            child: const Text(
              "Resend Code",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          )
        else ...[
          Text(
            "Resend Code in ",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            "00:${_remainingCountdownTime.toString().padLeft(2, '0')}",
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildVerifyButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      margin: const EdgeInsets.only(top: 50),
      child: _isVerifyButtonPressed == true
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            )
          : ElevatedButton(
              onPressed: () => _handleVerifyButtonPress(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Verify OTP",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
    );
  }

  void _initializeUserData() {
    setState(() {
      _userMobileNumber = widget.mobile.toString();
      _currentOtpCode = widget.generatedOtp;
    });
  }

  void _disposeControllers() {
    for (var controller in _otpInputControllers) {
      controller.dispose();
    }
  }

  void _disposeFocusNodes() {
    for (var focusNode in _otpFocusNodes) {
      focusNode.dispose();
    }
  }

  void _startOtpCountdown() {
    _countdownTimer?.cancel();
    setState(() {
      _remainingCountdownTime = _countdownStartTime;
      _isResendEnabled = false;
    });

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingCountdownTime > 0) {
        setState(() {
          _remainingCountdownTime--;
        });
      } else {
        timer.cancel();
        _onCountdownComplete();
      }
    });
  }

  void _onCountdownComplete() {
    setState(() {
      _isResendEnabled = true;
    });
  }

  void _handleOtpFieldChange(String value, int index) {
    if (value.isNotEmpty) {
      if (index < _otpLength - 1) {
        _otpFocusNodes[index + 1].requestFocus();
      } else {
        _otpFocusNodes[index].unfocus();
        String completeOtp = _getCompleteOtpValue();
        if (completeOtp.length == _otpLength) {
          _verifyEnteredOtp(completeOtp);
        }
      }
    } else {
      if (index > 0) {
        _otpFocusNodes[index - 1].requestFocus();
      }
    }
  }

  String _getCompleteOtpValue() {
    return _otpInputControllers.map((controller) => controller.text).join();
  }

  void _clearAllOtpFields() {
    for (var controller in _otpInputControllers) {
      controller.clear();
    }
    _otpFocusNodes[0].requestFocus();
  }

  void _handleResendOtp() {
    _generateNewRandomOtp();
    _startOtpCountdown();
    _clearAllOtpFields();
  }

  void _handleVerifyButtonPress(BuildContext context) {
    String enteredOtp = _getCompleteOtpValue();
    if (enteredOtp.length == _otpLength) {
      setState(() {
        _isVerifyButtonPressed = true;
      });
      _verifyEnteredOtp(enteredOtp);
    } else {
      showSnackBar(context, "Please enter complete OTP");
    }
  }

  Future<void> _getFirebaseMessagingToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    _firebaseToken = await messaging.getToken();
    print(_firebaseToken);
  }

  Future<void> _handleSpecialUserLogin() async {
    try {
      await _getFirebaseMessagingToken();
    } catch (e) {}
    ;

    print("mobile : $_userMobileNumber");
    if (_userMobileNumber.toString() == _debugMobileNumber) {
      await _fetchAndProcessUserDetails();
    } else {
      print("regular user");
    }
  }

  Future<void> _fetchAndProcessUserDetails() async {
    print("Processing special user login");
    try {
      Map<String, dynamic> loginData = {
        "phone": _userMobileNumber,
        "FcmToken": _firebaseToken,
      };
      print(_firebaseToken);

      Usermodel? userData = await UserService.login(loginData);
      print("User login status: ${userData!.data!.islogin}");

      if (userData.data!.islogin!) {
        if (userData.data!.roleId == _agentRoleId) {
          Navigate.pushReplacement(context, AgentTab());
        } else {
          if (userData.data!.subscriptionList!.isEmpty) {
            Navigate.pushAndRemoveUntil(context, SelectScheme());
          } else {
            print("User has subscriptions - navigating to SelectScheme");
            Navigate.pushAndRemoveUntil(context, SelectScheme());
          }
        }
      } else {
        _navigateToRegistration();
      }
    } catch (e) {
      print("Error in user authentication: $e");
    }
  }

  void _navigateToRegistration() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Registration(phone: widget.mobile),
      ),
    );
  }

  int _generateNewRandomOtp() {
    final Random random = Random();
    _generatedRandomOtp = random.nextInt(900000) + 100000;
    setState(() {
      _currentOtpCode = _generatedRandomOtp.toString();
    });
    _resendOtpToUser(context, widget.mobile, _generatedRandomOtp.toString());
    return _generatedRandomOtp!;
  }

  Future<void> _verifyEnteredOtp(String enteredOtpCode) async {
    printDebug("Entered OTP: $enteredOtpCode");
    printDebug("Expected OTP: $_currentOtpCode");

    if (_currentOtpCode.toString() == enteredOtpCode.toString()) {
      showSnackBar(context, "OTP Verified");
      setState(() {
        _isVerifyButtonPressed = false;
      });
      try {
        await _fetchAndProcessUserDetails();
        await _getFirebaseMessagingToken();
        return;
      } catch (e) {
        print("Error during OTP verification: $e");
      }
    } else {
      setState(() {
        _isVerifyButtonPressed = false;
      });
      showSnackBar(context, "Incorrect OTP");
      _clearAllOtpFields();
    }
  }

  void _resendOtpToUser(
    BuildContext context,
    String mobileNumber,
    String otpCode,
  ) {
    resendOtp(context, mobileNumber, otpCode);
  }
}
