import 'package:flutter/material.dart';
import 'package:stjewellery/Constant/constants.dart';

Widget PaymentButtons(
  String img,
  String txt,
  Color clr,
  GestureTapCallback onTapp,
) {
  return GestureDetector(
    onTap: onTapp,
    child: Column(
      children: [
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: clr,
                border: Border.all(color: Colors.black26),
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Image.asset(img, height: 50),
              ),
            ),
            Positioned(
              child: CircleAvatar(
                child: Icon(Icons.qr_code, color: Colors.white, size: 18),
                radius: 12,
                backgroundColor: Colors.black,
              ),
              bottom: 3,
              right: 3,
            ),
          ],
        ),
        h(5),
        Text(txt, style: TextStyle(color: Colors.black)),
      ],
    ),
  );
}

Widget copyFields(String head, String txt, GestureTapCallback onTapp) {
  return Row(
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              head,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
            Text(
              txt,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      IconButton(
        onPressed: onTapp,
        icon: Icon(Icons.copy),
        color: Colors.black,
      ),
    ],
  );
}
