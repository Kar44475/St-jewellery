import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stjewellery/Constant/constants.dart';
import 'package:stjewellery/Utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black12),
            boxShadow: [shadow],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  "assets/pngIcons/mainIcons.png",
                  height: 40,
                  color: themeClr,
                ),
                h(20),
                Text(
                  "A new version of $storeName is available.\nPlease update to latest version",
                  textAlign: TextAlign.center,
                  style: font(14, Colors.black, FontWeight.w600),
                ),
                h(20),
                secondaryButton("Update Now", () {
                  if (Platform.isAndroid) {
                    launchUrl(Uri.parse(androidLink));
                  } else if (Platform.isIOS) {
                    launchUrl(Uri.parse(iosLink));
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
