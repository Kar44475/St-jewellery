import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stjewellery/Constant/constants.dart';

class ScreenSize {
  // Method to get dynamic width
  static double setWidth(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.width * percentage;
  }

  // Method to get dynamic height
  static double setHeight(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.height * percentage;
  }
}

//--------Color-------

class ColorUtil {
  /// Converts a color string in the format `#RRGGBB` to a `Color` object.
  static Color fromHex(String hexColorString) {
    // Remove the '#' if present
    final cleanHexString = hexColorString.replaceAll('#', '');

    // Ensure it's 6 characters long, then add the alpha value
    if (cleanHexString.length == 6) {
      return Color(int.parse('0xFF$cleanHexString'));
    } else {
      throw ArgumentError(
        'Invalid color format: $hexColorString. Expected format: #RRGGBB',
      );
    }
  }
}

//------------Buttons---------------------

Widget primaryButton(String buttonText, GestureTapCallback onTapCallback) {
  return GestureDetector(
    onTap: onTapCallback,
    child: Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: ColorUtil.fromHex("#FF0F0F"),
      ),
      child: Text(buttonText, style: font(16, Colors.white, FontWeight.w600)),
    ),
  );
}

Widget secondaryButton(String buttonText, GestureTapCallback onTapCallback) {
  return GestureDetector(
    onTap: onTapCallback,
    child: Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color.fromRGBO(144, 48, 54, 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Text(buttonText, style: font(16, Colors.white, FontWeight.w600)),
      ),
    ),
  );
}

Widget loadingButton() {
  return Container(
    alignment: Alignment.center,
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: ColorUtil.fromHex("#FF0F0F"),
    ),
    child: const SizedBox(
      height: 25,
      width: 25,
      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
    ),
  );
}

Widget paymentButton(GestureTapCallback onTapCallback) {
  return GestureDetector(
    onTap: onTapCallback,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: Colors.black,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Text("PAY", style: font(14, Colors.white, FontWeight.w600)),
      ),
    ),
  );
}

Widget sectionHeading(String headingText) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
    child: Text(headingText, style: font(16, Colors.black, FontWeight.w600)),
  );
}

saveObject(String storageKey, dynamic objectValue) async {
  try {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(storageKey, json.encode(objectValue));
  } catch (error) {
    throw error;
  }
}

getSavedObject(String storageKey) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  var savedData = sharedPreferences.getString(storageKey);
  return savedData != null
      ? json.decode(sharedPreferences.getString(storageKey)!)
      : null;
}

printDebug(String debugText) {
  return print(debugText);
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message), duration: const Duration(seconds: 3)),
  );
}

class Loading {
  static BuildContext? _currentDialogContext;

  /// Show a loading dialog if it's not already shown
  static void show(BuildContext context) {
    if (_currentDialogContext != null) return; // Prevent multiple dialogs

    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissal by tapping outside
      builder: (dialogContext) {
        _currentDialogContext = dialogContext;
        return WillPopScope(
          onWillPop: () async => false, // Disable back button
          child: Center(
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(child: CircularProgressIndicator()),
            ),
          ),
        );
      },
    ).then((_) {
      // Reset context when the dialog is dismissed externally
      _currentDialogContext = null;
    });
  }

  /// Dismiss the loading dialog if it's currently shown
  static void dismiss() {
    if (_currentDialogContext == null) {
      debugPrint("Dismiss called but _currentDialogContext is already null.");
      return;
    }

    Future.microtask(() {
      if (_currentDialogContext?.mounted ??
          false && Navigator.canPop(_currentDialogContext!)) {
        debugPrint("Dismissing loading dialog.");
        Navigator.of(_currentDialogContext!).pop();
      } else {
        debugPrint("Navigator cannot pop the loading dialog.");
      }
      _currentDialogContext = null;
    });
  }
}

class AppColors {
  static String buttonTextColor = "#ffffff";
  static String primaryButtonColor = "#FFF284";
}

saveUserName(String storageKey, dynamic nameValue) async {
  try {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(storageKey, json.encode(nameValue));
  } catch (error) {
    throw error;
  }
}

bool get isInDebugMode {
  bool debugModeFlag = false;
  assert(debugModeFlag = true);
  return debugModeFlag;
}

showErrorMessage(dynamic errorObject) {
  if (isInDebugMode) {
    if (kDebugMode) {
      print("Error is :$errorObject");
    }
  }
  if (!errorObject.toString().contains("setState()")) {
    if (errorObject is DioError) {
      DioError dioErrorObject = errorObject;
      var errorMessage = dioErrorObject.response!.data["message"];
      if (errorMessage == null) {
        errorMessage = dioErrorObject.response!.data["message"];
        errorMessage ??= "Oops Something went wrong try again !!";
      } else {
        errorMessage = dioErrorObject.response!.data["message"];
      }
      Fluttertoast.showToast(
        msg: errorMessage.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      Fluttertoast.showToast(
        msg: errorObject.toString() ?? "Oops Something went wrong try again !!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}

showToastCenter(String toastMessage) {
  Fluttertoast.showToast(
    msg: toastMessage,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

showToast(String toastMessage) {
  Fluttertoast.showToast(
    msg: toastMessage,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

class Navigate {
  static PageRoute _getPageRoute(Widget destinationPage) {
    return Platform.isIOS
        ? CupertinoPageRoute(builder: (context) => destinationPage)
        : MaterialPageRoute(builder: (context) => destinationPage);
  }

  static void push(BuildContext context, Widget destinationPage) {
    Navigator.push(context, _getPageRoute(destinationPage));
  }

  static void pushReplacement(BuildContext context, Widget destinationPage) {
    Navigator.pushReplacement(context, _getPageRoute(destinationPage));
  }

  static void pushAndRemoveUntil(
    BuildContext context,
    Widget destinationPage, {
    bool Function(Route<dynamic>)? removeUntilCondition,
  }) {
    Navigator.pushAndRemoveUntil(
      context,
      _getPageRoute(destinationPage),
      removeUntilCondition ?? (route) => false, // Default: Remove all routes
    );
  }

  static void pushWithCallback(
    BuildContext context,
    Widget destinationPage,
    Future<void> Function() onReturnCallback, // Allow async callbacks
  ) {
    Navigator.push(
      context,
      _getPageRoute(destinationPage),
    ).then((value) => onReturnCallback());
  }
}
