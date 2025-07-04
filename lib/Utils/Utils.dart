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
  static Color fromHex(String hexColor) {
    // Remove the '#' if present
    final hex = hexColor.replaceAll('#', '');

    // Ensure it's 6 characters long, then add the alpha value
    if (hex.length == 6) {
      return Color(int.parse('0xFF$hex'));
    } else {
      throw ArgumentError(
        'Invalid color format: $hexColor. Expected format: #RRGGBB',
      );
    }
  }
}

//------------Buttons---------------------

Widget  bttn(String txt, GestureTapCallback tapp) {
  return GestureDetector(
    onTap: tapp,
    child: Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: ColorUtil.fromHex("#FF0F0F"),
      ),
      child: Text(txt, style: font(16, Colors.white, FontWeight.w600)),
    ),
  );
}

Widget bttn2(String txt, GestureTapCallback tapp) {
  return GestureDetector(
    onTap: tapp,
    child: Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.red
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Text(txt, style: font(16, Colors.white, FontWeight.w600)),
      ),
    ),
  );
}

Widget loadBttn() {
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

Widget payBttn(GestureTapCallback tapp) {
  return GestureDetector(
    onTap: tapp,
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

Widget heading(String txt) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
    child: Text(txt, style: font(16, Colors.black, FontWeight.w600)),
  );
}

saveObject(String key, value) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, json.encode(value));
  } catch (e) {
    throw e;
  }
}

getSavedObject(String key) async {
  final prefs = await SharedPreferences.getInstance();
  var data = prefs.getString(key);
  return data != null ? json.decode(prefs.getString(key)!) : null;
}

p(String txt) {
  return print(txt);
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message), duration: const Duration(seconds: 3)),
  );
}

class Loading {
  static BuildContext? _dialogContext;

  /// Show a loading dialog if it's not already shown
  static void show(BuildContext context) {
    if (_dialogContext != null) return; // Prevent multiple dialogs

    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissal by tapping outside
      builder: (dialogContext) {
        _dialogContext = dialogContext;
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
      _dialogContext = null;
    });
  }

  /// Dismiss the loading dialog if it's currently shown
  static void dismiss() {
    if (_dialogContext == null) {
      debugPrint("Dismiss called but _dialogContext is already null.");
      return;
    }

    Future.microtask(() {
      if (_dialogContext?.mounted ??
          false && Navigator.canPop(_dialogContext!)) {
        debugPrint("Dismissing loading dialog.");
        Navigator.of(_dialogContext!).pop();
      } else {
        debugPrint("Navigator cannot pop the loading dialog.");
      }
      _dialogContext = null;
    });
  }
}

class Colorsapps {
  static String buttonTextcolor = "#ffffff";
  static String buttonColor = "#FFF284";
}

savename(String key, value) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, json.encode(value));
  } catch (e) {
    throw e;
  }
}

bool get isInDebugMode {
  bool inDebugMode = false;
  assert(inDebugMode = true);
  return inDebugMode;
}

showErrorMessage(error) {
  if (isInDebugMode) {
    if (kDebugMode) {
      print("Error is :$error");
    }
  }
  if (!error.toString().contains("setState()")) {
    if (error is DioError) {
      DioError e = error;
      var message = e.response!.data["message"];
      if (message == null) {
        message = e.response!.data["message"];
        message ??= "Oops Something went wrong try again !!";
      } else {
        message = e.response!.data["message"];
      }
      Fluttertoast.showToast(
        msg: message.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      Fluttertoast.showToast(
        msg: error.toString() ?? "Oops Something went wrong try again !!",
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

showToastCenter(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

class Navigate {
  static PageRoute _getPageRoute(Widget page) {
    return Platform.isIOS
        ? CupertinoPageRoute(builder: (context) => page)
        : MaterialPageRoute(builder: (context) => page);
  }

  static void push(BuildContext context, Widget page) {
    Navigator.push(context, _getPageRoute(page));
  }

  static void pushReplacement(BuildContext context, Widget page) {
    Navigator.pushReplacement(context, _getPageRoute(page));
  }

  static void pushAndRemoveUntil(
    BuildContext context,
    Widget page, {
    bool Function(Route<dynamic>)? removeUntilCondition,
  }) {
    Navigator.pushAndRemoveUntil(
      context,
      _getPageRoute(page),
      removeUntilCondition ?? (route) => false, // Default: Remove all routes
    );
  }

  static void pushWithCallback(
    BuildContext context,
    Widget page,
    Future<void> Function() onReturn, // Allow async callbacks
  ) {
    Navigator.push(context, _getPageRoute(page)).then((value) => onReturn());
  }
}
