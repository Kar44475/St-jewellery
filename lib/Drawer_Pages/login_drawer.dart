import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stjewellery/Constant/constants.dart';
import 'package:stjewellery/Drawer_Pages/contact_us.dart';

import 'package:stjewellery/Drawer_Pages/Offers.dart';


import 'package:stjewellery/Drawer_Pages/Terms&Consitions.dart';
import 'package:stjewellery/Drawer_Pages/WalletScreen.dart';
import 'package:stjewellery/Drawer_Pages/privacy_policy.dart';
import 'package:stjewellery/Utils/Utils.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stjewellery/Widgets/exitwidget.dart';
import 'package:stjewellery/screens/PackagesScreen/SelectScheme.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginDrawer extends StatefulWidget {
  const LoginDrawer({Key? key}) : super(key: key);

  @override
  State<LoginDrawer> createState() => _LoginDrawerState();
}

class _LoginDrawerState extends State<LoginDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenSize.setWidth(context, 0.7),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(right: BorderSide(color: Colors.black12)),
      ),
      child: ListView(
        children: [
          Row(
            children: [
              Spacer(),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close),
              ),
            ],
          ),
          // item(CupertinoIcons.lock, "Terms & Conditions", () {
          //   Navigate.push(context, TermsNconditions());
          // }),
          item(Icons.privacy_tip_outlined, "Privacy Policy", () {
            Navigate.push(context, PrivacyPolicy());
          }),
          item(Icons.support_agent, "Contact Us", () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ContactUs()),
            );
          }),
        ],
      ),
    );
  }
}

void _launch(String id) async =>
    await canLaunch(id) ? await launch(id) : throw 'Could not launch $id';

item(IconData icn, String txt, GestureTapCallback tapp) {
  return GestureDetector(
    onTap: tapp,
    child: Column(
      children: [
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                Icon(icn, color: Colors.black),
                w(10),
                Text(txt, style: font(16, Colors.black, FontWeight.w600)),
              ],
            ),
          ),
        ),
        const Divider(
          color: Colors.black12,
          height: 10,
          indent: 10,
          endIndent: 10,
        ),
      ],
    ),
  );
}

item2(IconData icn, String txt, GestureTapCallback tapp) {
  return GestureDetector(
    onTap: tapp,
    child: Column(
      children: [
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                Icon(icn, color: Colors.red),
                w(10),
                Text(txt, style: font(16, Colors.red, FontWeight.w600)),
              ],
            ),
          ),
        ),
        const Divider(
          color: Colors.black12,
          height: 10,
          indent: 10,
          endIndent: 10,
        ),
      ],
    ),
  );
}
