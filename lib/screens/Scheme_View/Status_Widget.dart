import 'package:flutter/material.dart';

class Statuswidget extends StatelessWidget {
  final String paid;
  final Color colors;
  const Statuswidget({Key? key, required this.paid, required this.colors})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        color: colors,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8, top: 4, bottom: 4),
        child: Center(
          child: Text(paid, style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
