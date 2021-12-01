import 'package:flutter/material.dart';

class BottomNavItems extends StatelessWidget {
  final String number;
  final String title;

  BottomNavItems({this.number, this.title});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        FittedBox(
          fit: BoxFit.contain,
          child: Text(
            number,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        FittedBox(
          fit: BoxFit.contain,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }
}
