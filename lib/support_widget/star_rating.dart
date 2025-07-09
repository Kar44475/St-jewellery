import 'dart:math';

import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  // final double rating;
  final double starSize;
  // final Color starColor;
  final Color starBorderColor;
  final double rating = Random().nextDouble() * 5;

  StarRating({
    // required this.rating,
    this.starSize = 15.0,
    // this.starColor = Color(0xffFFC833),
    this.starBorderColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(5, (index) {
        return Icon(
          Icons.star,
          size: starSize,
          color: index < rating ? Color(0xffffc832) : Colors.grey[300],
        );
      }),
    );
  }
}
