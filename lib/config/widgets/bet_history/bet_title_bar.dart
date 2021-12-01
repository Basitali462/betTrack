import 'package:flutter/material.dart';
import 'package:flutter_bet_track/config/theme/app_theme.dart';

class BetTitleBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/icons/history_icon.png',
        ),
        Spacer(),
        /*Container(
          alignment: Alignment.center,
          width: 87,
          height: 40,
          decoration: BoxDecoration(
            color: AppTheme.colorDisableButtons,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '10',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF1B1D21).withOpacity(0.5),
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 15,),
              Image.asset(
                'assets/icons/icon-down.png',
              ),
            ],
          ),
        ),*/
      ],
    );
  }
}
