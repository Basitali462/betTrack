import 'package:flutter/material.dart';
import 'package:flutter_bet_track/config/model/game_status_model.dart';
import 'package:flutter_bet_track/config/provider/bet_text_provider.dart';
import 'package:flutter_bet_track/config/theme/app_theme.dart';
import 'package:provider/provider.dart';

class AddFundsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final betProvider = Provider.of<BetTextProvider>(context);
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: (){
              betProvider.addFunds(double.parse(betProvider.newFundsInputController.text));
              Navigator.of(context).pop();
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: AppTheme.colorButtonBlue,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                'Add',
                style: TextStyle(
                  fontSize: 18,
                  color: AppTheme.colorActiveButtonText,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 15,),
        Expanded(
          child: GestureDetector(
            onTap: (){
              betProvider.newFundsInputController.clear();
              Navigator.of(context).pop();
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: AppTheme.colorButtonRed,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 18,
                  color: AppTheme.colorActiveButtonText,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
