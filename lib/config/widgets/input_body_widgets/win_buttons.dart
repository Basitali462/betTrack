import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bet_track/config/model/game_status_model.dart';
import 'package:flutter_bet_track/config/provider/bet_text_provider.dart';
import 'package:flutter_bet_track/config/theme/app_theme.dart';
import 'package:flutter_bet_track/config/widgets/split_popup.dart';
import 'package:provider/provider.dart';

class WinButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final betProvider = Provider.of<BetTextProvider>(context);
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: (){
              if(betProvider.betTextController.text.isEmpty || betProvider.betTextController.text == null){
                return ;
              }
              betProvider.buttonTapSound('sounds/soft_button.wav');
              var previousBet = betProvider.statusData.where((element) => element.status == 'Bet');
              if(previousBet.isNotEmpty){
                betProvider.betWinHandler();
                betProvider.addBets(
                  GameStatus(
                    status: 'Win',
                    amount: betProvider.betTextController.text,
                    time: Timestamp.fromDate(DateTime.now()),
                  ),
                );
              }
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: betProvider.bettingStatus()
                    ? AppTheme.colorButtonGreen
                    : AppTheme.colorDisableButtons,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                'Win',
                style: TextStyle(
                  fontSize: 18,
                  color: betProvider.bettingStatus()
                      ? AppTheme.colorActiveButtonText
                      : AppTheme.colorDisableButtonText,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 15,),
        Expanded(
          child: GestureDetector(
            onTap: (){
              /*if(betProvider.betTextController.text.isEmpty || betProvider.betTextController.text == null){
                return ;
              }
              var previousBet = betProvider.statusData.where((element) => element.status == 'Bet');
              if(previousBet.isNotEmpty){
                showDialog(
                  useSafeArea: false,
                  barrierDismissible: false,
                  barrierColor: Colors.transparent,
                  context: context,
                  builder: (context){
                    return SplitPopup();
                  },);
              }*/
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: betProvider.bettingStatus()
                    ? AppTheme.colorButtonGreen
                    : AppTheme.colorDisableButtons,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                'Custom Win',
                style: TextStyle(
                  fontSize: 18,
                  color: betProvider.bettingStatus()
                      ? AppTheme.colorActiveButtonText
                      : AppTheme.colorDisableButtonText,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
