import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stjewellery/Constant/constants.dart';
import 'package:stjewellery/utils/utils.dart';
import 'package:stjewellery/screens/Login_OTP/login_screen.dart';

exitApp(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.white,
      title: const Text('Confirm exit?'),
      titleTextStyle: font(15, Colors.black, FontWeight.w500),
      contentTextStyle: font(13, Colors.black, FontWeight.w400),
      content: const Text('Are you sure you want to exit?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text('No', style: font(13, Colors.black, FontWeight.w500)),
        ),
        TextButton(
          onPressed: () async {
            close(context);

            //   SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          },
          child: Text('Yes', style: font(13, Colors.black, FontWeight.w500)),
        ),
      ],
    ),
  );
}

deleleData(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Delete Account'),
      content: const Text(
        'This will delete your account and remove all data. Are you sure u want to continue ?',
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () async {
            deleteAccount(context);

            //   SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          },
          child: const Text('Yes'),
        ),
      ],
    ),
  );
}

void close(BuildContext context) async {
  try {
    Loading.show(context);

    Loading.dismiss();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    Navigate.pushAndRemoveUntil(context, const LoginScreen());
  } catch (e) {
    showToast("Failed to logout try again later");
    Loading.dismiss();
    print(e);
  }
}

void deleteAccount(BuildContext context) async {
  try {
    Loading.show(context);

    Loading.dismiss();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    Navigate.pushAndRemoveUntil(context, const LoginScreen());
  } catch (e) {
    // showErrorMessage(e);
    showToast("Failed to delete try again later");
    Loading.dismiss();
    print(e);
    //  Navigator.pop(context);
  }
}
