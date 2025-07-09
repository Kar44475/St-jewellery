import 'package:flutter/material.dart';

final bgClr = Color(0xff3c230f);
final themeClr = Color(0xff461524);
const storeName = "St Jewellery";

final appbarcolor = Color(0xff183219);
final Boxcolor = Color(0xffe3e3e3);
final Iconcolor = Color(0xffffffff);
final circleBcolor = Color(0xff183219);

h(double h) {
  return SizedBox(height: h);
}

w(double w) {
  return SizedBox(width: w);
}

const rs = "₹ ";

font(double s, Color clr, FontWeight weight) {
  return TextStyle(
    fontSize: s,
    color: clr,
    fontWeight: weight,
    fontFamily: 'Roboto',
  );
}

// String tstImg =
//     "https://www.dazzlesjewellery.in/cdn/shop/files/IMG_9798_0af72cbf-a031-4900-8c47-96cfa781b91d.jpg?v=1720172694";
const shadow = BoxShadow(
  color: Colors.black12,
  offset: Offset(0.0, 2.0),
  blurRadius: 2.0,
  spreadRadius: 1.0,
);

final appbarStyle = font(18, Colors.black, FontWeight.w600);

String iosPhoneUser = "+919946088916";

String androidLink =
    "https://play.google.com/store/apps/details?id=com.skygold.schemeapp&pcampaignid=web_share";

String iosLink = "https://apps.apple.com/us/app/sky-group/id6443760116";
