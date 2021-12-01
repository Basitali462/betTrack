import 'package:flutter/material.dart';
import 'package:flutter_bet_track/config/theme/app_theme.dart';

class FloatingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return /*FloatingActionButton(
      elevation: 2,
      backgroundColor: Color(0xFF1DCE98),
      onPressed: (){},
      child: Image.asset(
        'assets/icons/analysis.png',
      ),

    );*/
    Container(
      padding: EdgeInsets.all(14),
      margin: EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFF1DCE98),
        boxShadow: [
          BoxShadow(
            color: AppTheme.colorLightGreen,
            offset: Offset(2, 5),
            blurRadius: 5,
            spreadRadius: 2
          ),
        ]
      ),
      child: Image.asset(
        'assets/icons/analysis.png',
        width: 40,
        height: 40,
      ),
    );
  }
}
