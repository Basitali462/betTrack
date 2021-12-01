import 'package:flutter/material.dart';
import 'package:flutter_bet_track/config/theme/app_theme.dart';

class BetStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      margin: EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: AppTheme.colorLightGreen,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        'Your bet has been successfully placed',
        style: TextStyle(
          color: AppTheme.colorGreen,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
