import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:stjewellery/AgentModule/homescreen/agentab.dart';
import 'package:stjewellery/BottomNav/bottom_navigation.dart';
import 'package:stjewellery/BottomNav/top_navigation.dart';
import 'package:stjewellery/Utils/Utils.dart';
import 'package:stjewellery/model/Usermodel.dart';
 import 'package:stjewellery/screens/Login_OTP/OTP_Template.dart';
import 'package:stjewellery/screens/PackagesScreen/SelectScheme.dart';
import 'package:stjewellery/screens/Registration/RegisterPage.dart';
import 'package:stjewellery/screens/Update/UpdateScreen.dart';
import 'package:stjewellery/service/Dashboardservice.dart';
import 'package:stjewellery/service/Userservice.dart';

class LoginPopupWidget extends StatefulWidget {
  final VoidCallback? onLoginSuccess;
  final String? redirectMessage;

  const LoginPopupWidget({
    Key? key,
    this.onLoginSuccess,
    this.redirectMessage,
  }) : super(key: key);

  @override
  State<LoginPopupWidget> createState() => _LoginPopupWidgetState();
}

class _LoginPopupWidgetState extends State<LoginPopupWidget>
    with TickerProviderStateMixin {
  
  // Animation Controllers
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Page Controller for different screens
  PageController _pageController = PageController();
  int _currentPage = 0;

  // Login Screen Variables (from LoginScreen.dart)
  final TextEditingController _phoneNumberController = TextEditingController();
  bool _isLoadingOtp = false;
  int? _generatedOtpNumber;

  // OTP Screen Variables (from OtpScreen.dart)
  final List<TextEditingController> _otpInputControllers = List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _otpFocusNodes = List.generate(6, (index) => FocusNode());
  static const int _countdownStartTime = 30;
  int _remainingCountdownTime = _countdownStartTime;
  Timer? _countdownTimer;
  bool _isResendEnabled = false;
  bool _isVerifyButtonPressed = false;
  String? _firebaseToken;
  String? _userMobileNumber;
  String? _currentOtpCode;
  int? _generatedRandomOtp;

  // Constants (from OtpScreen.dart)
  static const String _debugMobileNumber = "+919562044475";
  static const int _otpLength = 6;
  static const int _agentRoleId = 3;
  
  // Constants (from LoginScreen.dart)
  static const String _testPhoneNumber = "9946088916";
  static const String _testOtp = "000000";

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _checkExistingLogin();
  }

  void _initializeAnimations() {
    _fadeController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(begin: Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
    );

    _fadeController.forward();
    _slideController.forward();
  }

// Check existing login (from splash_screen.dart navigationPage logic)
Future<void> _checkExistingLogin() async {
  try {
    // First check for app updates (from splash_screen.dart startTime logic)
    await _checkForUpdates();
    
    // Check existing login (from splash_screen.dart navigationPage logic)
    final role = await getSavedObject("roleid");
    final subscription = await getSavedObject("subscription");
    final token = await getSavedObject('token');
    
    print("Existing login check - Role: $role, Subscription: $subscription, Token: $token");

    if (role != null && token != null) {
      // User is already logged in, close popup and navigate accordingly
      Navigator.of(context).pop();
      
      // Follow exact splash_screen.dart navigationPage logic
      if (role == 2 || role == 4) {
        if (subscription != null) {
          // User has a scheme selected - safe to go to TopNavigation
          Navigate.pushAndRemoveUntil(
            context, 
            TopNavigation(
              sourceScreen: 'login_popup',
              initialTab: 0,
            )
          );
        } else {
          // User has no scheme selected - must go to SelectScheme first
          Navigate.pushAndRemoveUntil(context, SelectScheme());
        }
      } else if (role == 3) {
        Navigate.push(context, Agentab());
      }
      return;
    }

    // If not logged in, continue with login flow
  } catch (e) {
    print("Error checking existing login: $e");
    // Continue with login flow
  }
}


  // Check for updates (from splash_screen.dart startTime logic)
  Future<void> _checkForUpdates() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final buildNumber = packageInfo.buildNumber;
      final currentBuild = int.tryParse(buildNumber) ?? 0;

      final datas = await Dashbordservice.getDashboard();
      final latestAndroidBuild = datas.data.versions.android;
      final latestIosBuild = datas.data.versions.ios;

      bool needsUpdate = false;
      if (Platform.isAndroid && latestAndroidBuild > currentBuild) {
        needsUpdate = true;
      } else if (Platform.isIOS && latestIosBuild > currentBuild) {
        needsUpdate = true;
      }

      if (needsUpdate) {
        Navigator.of(context).pop();
        Navigate.pushAndRemoveUntil(context, const UpdateScreen());
        return;
      }
    } catch (e) {
      print("Error checking for updates: $e");
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _pageController.dispose();
    _phoneNumberController.dispose();
    _countdownTimer?.cancel();
    _disposeOtpControllers();
    super.dispose();
  }

  void _disposeOtpControllers() {
    for (var controller in _otpInputControllers) {
      controller.dispose();
    }
    for (var focusNode in _otpFocusNodes) {
      focusNode.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(20),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.8,
              maxWidth: MediaQuery.of(context).size.width * 0.9,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHeader(),
                Flexible(
                  child: PageView(
                    controller: _pageController,
                    physics: NeverScrollableScrollPhysics(),
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    children: [
                      _buildLoginScreen(),
                      _buildOtpScreen(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          if (_currentPage > 0)
            IconButton(
              onPressed: () {
                _pageController.previousPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              icon: Icon(Icons.arrow_back, color: Colors.white),
            ),
          Expanded(
            child: Column(
              children: [
                Image.asset(
                  "assets/pngIcons/mainIcons.png",
                  height: 40,
                
                ),
                SizedBox(height: 8),
                Text(
                  _currentPage == 0 ? 'Login to Continue' : 'Verify OTP',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (widget.redirectMessage != null)
                  Text(
                    widget.redirectMessage!,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 12,
                    ),
                  ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.close, color: Colors.white),
          ),
        ],
      ),
    );
  }

  // Login Screen (based on LoginScreen.dart)
  Widget _buildLoginScreen() {
    return Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "SIGN IN",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
              letterSpacing: 1.5,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Your golden account awaits - log in to shine",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 24),
          
          // Phone Number Field (from LoginScreen.dart)
          IntlPhoneField(
            initialCountryCode: "IN",
            controller: _phoneNumberController,
            keyboardType: TextInputType.numberWithOptions(signed: true),
            decoration: InputDecoration(
              labelText: 'Mobile Number',
              labelStyle: TextStyle(color: Colors.grey[600]),
              border: _buildInputBorder(),
              focusedBorder: _buildInputBorder(),
              enabledBorder: _buildInputBorder(),
              filled: true,
              fillColor: Color.fromRGBO(255, 203, 3, 0.15),
              counterText: "",
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
            languageCode: "en",
            onChanged: (phone) => print(phone.completeNumber),
          ),
          
          SizedBox(height: 24),
          
          // Get OTP Button (from LoginScreen.dart)
          SizedBox(
            width: double.infinity,
            height: 50,
            child: _isLoadingOtp
                ? Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                : ElevatedButton(
                    onPressed: _handleGetOtpPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Get OTP",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  // OTP Screen (based on OtpScreen.dart)
  Widget _buildOtpScreen() {
    return Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "ENTER OTP",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
              letterSpacing: 1.5,
            ),
          ),
          SizedBox(height: 8),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
              children: [
                TextSpan(text: "A 6-digit OTP has been sent to your registered mobile "),
                TextSpan(text: "\nnumber +91${_phoneNumberController.text}\n"),
                TextSpan(text: "please enter the OTP below to verify your identity"),
              ],
            ),
          ),
          SizedBox(height: 24),
          
          // OTP Input Fields (from OtpScreen.dart)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(_otpLength, (index) {
              return _buildSingleOtpField(index);
            }),
          ),
          
          SizedBox(height: 20),
          
          // Resend Section (from OtpScreen.dart)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_isResendEnabled)
                GestureDetector(
                  onTap: _handleResendOtp,
                  child: Text(
                    "Resend Code",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                )
              else ...[
                Text(
                  "Resend Code in ",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
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
          ),
          
          SizedBox(height: 24),
          
          // Verify Button (from OtpScreen.dart)
          SizedBox(
            width: double.infinity,
            height: 50,
            child: _isVerifyButtonPressed
                ? Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                : ElevatedButton(
                    onPressed: _handleVerifyButtonPress,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Verify OTP",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSingleOtpField(int index) {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: TextFormField(
        controller: _otpInputControllers[index],
        focusNode: _otpFocusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          counterText: "",
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (value) => _handleOtpFieldChange(value, index),
      ),
    );
  }

  OutlineInputBorder _buildInputBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(8),
    );
  }

  // Login Screen Methods (from LoginScreen.dart)
  void _handleGetOtpPressed() {
    final phoneNumber = _phoneNumberController.text.trim();
    p(phoneNumber);
    
    if (_validatePhoneNumber(phoneNumber)) {
      setState(() {
        _isLoadingOtp = true;
      });

      if (phoneNumber == _testPhoneNumber) {
        _navigateToTestOtp(phoneNumber);
      } else {
        _sendOtpToUser(phoneNumber);
      }
    }
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

  void _navigateToTestOtp(String phoneNumber) {
    setState(() {
      _isLoadingOtp = false;
      _currentOtpCode = _testOtp;
      _userMobileNumber = "+91$phoneNumber";
    });
    _moveToOtpScreen();
  }

  void _sendOtpToUser(String phoneNumber) {
    _generateRandomOtp();
    sendOtp(context, phoneNumber, _generatedOtpNumber.toString(),false);
    setState(() {
      _isLoadingOtp = false;
      _currentOtpCode = _generatedOtpNumber.toString();
      _userMobileNumber = "+91$phoneNumber";
    });
    _moveToOtpScreen();
  }

  int _generateRandomOtp() {
    final Random random = Random();
    _generatedOtpNumber = random.nextInt(900000) + 100000;
    return _generatedOtpNumber!;
  }

  void _moveToOtpScreen() {
    _pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    _startOtpCountdown();
  }

  // OTP Screen Methods (from OtpScreen.dart)
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

  void _handleVerifyButtonPress() {
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

  void _startOtpCountdown() {
    _countdownTimer?.cancel();
    setState(() {
      _remainingCountdownTime = _countdownStartTime;
      _isResendEnabled = false;
    });

    _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingCountdownTime > 0) {
        setState(() {
          _remainingCountdownTime--;
        });
      } else {
        timer.cancel();
        setState(() {
          _isResendEnabled = true;
        });
      }
    });
  }

  // Generate new random OTP for resend (from OtpScreen.dart)
  int _generateNewRandomOtp() {
    final Random random = Random();
    _generatedRandomOtp = random.nextInt(900000) + 100000;
    setState(() {
      _currentOtpCode = _generatedRandomOtp.toString();
    });
    _resendOtpToUser(context, _phoneNumberController.text, _generatedRandomOtp.toString());
    return _generatedRandomOtp!;
  }

  void _resendOtpToUser(BuildContext context, String mobileNumber, String otpCode) {
    resendOtp(context, mobileNumber, otpCode);
  }

  // Firebase and Authentication Methods (from OtpScreen.dart)
  Future<void> _getFirebaseMessagingToken() async {
    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      _firebaseToken = await messaging.getToken();
      print("Firebase token: $_firebaseToken");
    } catch (e) {
      print("Error getting Firebase token: $e");
    }
  }

  // Handle special user login (from OtpScreen.dart)
  Future<void> _handleSpecialUserLogin() async {
    try {
      await _getFirebaseMessagingToken();
    } catch (e) {
      print("Error getting Firebase token: $e");
    }
    
    print("mobile : $_userMobileNumber");
    if (_userMobileNumber.toString() == _debugMobileNumber) {
      await _fetchAndProcessUserDetails();
    } else {
      print("regular user");
    }
  }

  // Verify entered OTP (from OtpScreen.dart)
  Future<void> _verifyEnteredOtp(String enteredOtpCode) async {
    p("Entered OTP: $enteredOtpCode");
    p("Expected OTP: $_currentOtpCode");
    
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

  // Fetch and process user details (from OtpScreen.dart)
// In the _fetchAndProcessUserDetails method, update the navigation logic:

Future<void> _fetchAndProcessUserDetails() async {
  print("Processing user login");
  try {
    Map<String, dynamic> loginData = {
      "phone": _userMobileNumber,
      "FcmToken": _firebaseToken
    };
    print(_firebaseToken);
    
    Usermodel? userData = await UserService.login(loginData);
    print("User login status: ${userData!.data!.islogin}");

    if (userData.data!.islogin!) {
      // Close popup first
      Navigator.of(context).pop();
      
      // Follow exact OtpScreen.dart navigation logic
      if (userData.data!.roleId == _agentRoleId) {
        Navigate.push(context, Agentab());
      } else {
        // Check if user has subscriptions
        if (userData.data!.subscriptionList!.isEmpty) {
          // User has no schemes - go to SelectScheme
          Navigate.pushReplacement(context, SelectScheme());
        } else {
          // User has subscriptions - save the first one and go to TopNavigation
          // This prevents the error when TopNavigation is called without scheme
          await saveObject("subscription", userData.data!.subscriptionList![0].id);
          await saveObject("schemeAmountId", userData.data!.subscriptionList![0].schemeAmountId);
          
          // Now safely navigate to TopNavigation
          Navigate.pushReplacement(
            context, 
            TopNavigation(
              sourceScreen: 'login_popup',
              initialTab: 0, // Start with Scheme tab
            )
          );
        }
      }
      
      // Call success callback if provided
      if (widget.onLoginSuccess != null) {
        widget.onLoginSuccess!();
      }
    } else {
      // New user - navigate to registration
      Navigator.of(context).pop();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Registration(phone: _userMobileNumber),
        ),
      );
    }
  } catch (e) {
    print("Error in user authentication: $e");
    setState(() {
      _isVerifyButtonPressed = false;
    });
    showToast("Login failed. Please try again.");
  }
}

}
