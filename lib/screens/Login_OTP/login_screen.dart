import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:stjewellery/support_widget/essential.dart';
import 'package:stjewellery/screens/Login_OTP/otp_template.dart';
import 'package:stjewellery/screens/Login_OTP/otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with WidgetsBindingObserver {
  final TextEditingController _phoneNumberController = TextEditingController();
  bool _isLoadingOtp = false;
  int? _generatedOtpNumber;
  int _logoTapCount = 0;
  Timer? _tapCountTimer;
  bool _isLongPressing = false;

  static const String _testPhoneNumber = "9946088916";
  static const String _testOtp = "000000";
  static const int _tapCountThreshold = 4;
  static const int _longPressDurationSeconds = 3;
  static const int _tapResetDelayMs = 400;

  @override
  void initState() {
    super.initState();
    _generateRandomOtp();
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _tapCountTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildHeaderSection(context),
          _buildLoginFormSection(context),
        ],
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Expanded(
      flex: 9,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor.withOpacity(0.9),
            ],
          ),
        ),
        width: double.infinity,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [_buildLogoSection(screenWidth)],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoSection(double screenWidth) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: _handleLogoTap,
        child: Image.asset(
          "assets/pngIcons/mainIcons.png",
          width: screenWidth * 0.3,
          height: screenWidth * 0.3,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildLoginFormSection(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Expanded(
      flex: 11,
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Container(
          width: double.infinity,
          decoration: _buildFormContainerDecoration(),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: screenHeight * 0.5 - 80),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    _buildSignInTitle(context),
                    const SizedBox(height: 16),
                    _buildSubtitle(),
                    const SizedBox(height: 40),
                    _buildPhoneNumberField(),
                    const Spacer(),
                    _buildGetOtpButton(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildFormContainerDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(35),
        topRight: Radius.circular(35),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 15,
          offset: const Offset(0, -8),
        ),
      ],
    );
  }

  Widget _buildSignInTitle(BuildContext context) {
    return GestureDetector(
      onLongPressStart: _handleLongPressStart,
      onLongPressEnd: _handleLongPressEnd,
      child: Text(
        "SIGN IN",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: Theme.of(context).primaryColor,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      "Your golden account awaits - log in to shine",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 15,
        color: Colors.grey[600],
        fontWeight: FontWeight.w400,
        height: 1.4,
      ),
    );
  }

  Widget _buildPhoneNumberField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: IntlPhoneField(
        initialCountryCode: "IN",
        controller: _phoneNumberController,
        keyboardType: const TextInputType.numberWithOptions(signed: true),
        decoration: InputDecoration(
          labelText: 'Mobile Number',
          labelStyle: TextStyle(
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
          border: _buildInputBorder(),
          focusedBorder: _buildFocusedInputBorder(),
          enabledBorder: _buildInputBorder(),
          errorBorder: _buildInputBorder(),
          disabledBorder: _buildInputBorder(),
          filled: true,
          fillColor: Colors.grey[50],
          counterText: "",
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
        ),
        languageCode: "en",
        onChanged: (phone) => print(phone.completeNumber),
        onCountryChanged: (country) =>
            print('Country changed to: ${country.name}'),
      ),
    );
  }

  OutlineInputBorder _buildInputBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[300]!, width: 1.5),
      borderRadius: BorderRadius.circular(15),
    );
  }

  OutlineInputBorder _buildFocusedInputBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
      borderRadius: BorderRadius.circular(15),
    );
  }

  Widget _buildGetOtpButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      margin: const EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: _isLoadingOtp
          ? Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.8),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              ),
            )
          : ElevatedButton(
              onPressed: () => _handleGetOtpPressed(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                "Get OTP",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ),
    );
  }

  void _handleLogoTap() {
    _logoTapCount++;
    _tapCountTimer?.cancel();
    _tapCountTimer = Timer(const Duration(milliseconds: _tapResetDelayMs), () {
      if (_logoTapCount == _tapCountThreshold) {
        setState(() {
          _phoneNumberController.text = _testPhoneNumber;
        });
      }
      _logoTapCount = 0;
    });
  }

  void _handleLongPressStart(LongPressStartDetails details) {
    setState(() {
      _isLongPressing = true;
    });

    Timer(const Duration(seconds: _longPressDurationSeconds), () {
      if (_isLongPressing) {
        showToast("No OTP login initiated");
        _validatePhoneNumber(_phoneNumberController.text);
        // Commented out navigation as requested in original code
        // _navigateToOtpSkip();
      }
    });
  }

  void _handleLongPressEnd(LongPressEndDetails details) {
    setState(() {
      _isLongPressing = false;
    });
  }

  void _handleGetOtpPressed(BuildContext context) {
    final phoneNumber = _phoneNumberController.text.trim();
    printDebug(phoneNumber);

    if (_validatePhoneNumber(phoneNumber)) {
      if (phoneNumber == _testPhoneNumber) {
        _navigateToTestOtp(context, phoneNumber);
      } else {
        _sendOtpToUser(context, phoneNumber);
      }
    }
  }

  void _navigateToTestOtp(BuildContext context, String phoneNumber) {
    setState(() {
      _isLoadingOtp = false;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            OtpPage(generatedOtp: _testOtp, mobile: "+91$phoneNumber"),
      ),
    );
  }

  void _sendOtpToUser(BuildContext context, String phoneNumber) {
    sendOtp(context, phoneNumber, _generatedOtpNumber.toString(), true);
  }

  bool _validatePhoneNumber(String phoneNumber) {
    const String phonePattern = r'(^(?:[+0]9)?[0-9]{6,12}$)';
    final RegExp regExp = RegExp(phonePattern);

    if (phoneNumber.isEmpty) {
      showToast('Please enter mobile number');
      return false;
    } else if (!regExp.hasMatch(phoneNumber)) {
      showToastCenter('Please enter valid mobile number');
      return false;
    }
    return true;
  }

  int _generateRandomOtp() {
    final Random random = Random();
    _generatedOtpNumber = random.nextInt(900000) + 100000;
    return _generatedOtpNumber!;
  }
}
