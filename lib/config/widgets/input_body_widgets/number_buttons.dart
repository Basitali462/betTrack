import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bet_track/config/model/game_status_model.dart';
import 'package:flutter_bet_track/config/provider/bet_text_provider.dart';
import 'package:flutter_bet_track/config/theme/app_theme.dart';
import 'package:provider/provider.dart';

class NumberButtons extends StatelessWidget {
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
                betProvider.customWinHandler('1');
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
                color: betProvider.bettingStatus() || betProvider.customWinAmount == '1'
                    ? AppTheme.colorButtonGreen
                    : AppTheme.colorDisableButtons,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                '1.5',
                style: TextStyle(
                  fontSize: 18,
                  color: betProvider.bettingStatus() || betProvider.customWinAmount == '1'
                      ? AppTheme.colorActiveButtonText
                      : AppTheme.colorDisableButtonText,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 6,),
        Expanded(
          child: GestureDetector(
            onTap: (){
              if(betProvider.betTextController.text.isEmpty || betProvider.betTextController.text == null){
                return ;
              }
              betProvider.buttonTapSound('sounds/soft_button.wav');
              var previousBet = betProvider.statusData.where((element) => element.status == 'Bet');
              if(previousBet.isNotEmpty){
                betProvider.customWinHandler('2');
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
                color: betProvider.bettingStatus() || betProvider.customWinAmount == '2'
                    ? AppTheme.colorButtonGreen
                    : AppTheme.colorDisableButtons,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                '3',
                style: TextStyle(
                  fontSize: 18,
                  color: betProvider.bettingStatus() || betProvider.customWinAmount == '2'
                      ? AppTheme.colorActiveButtonText
                      : AppTheme.colorDisableButtonText,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 6,),
        Expanded(
          child: GestureDetector(
            onTap: (){
              if(betProvider.betTextController.text.isEmpty || betProvider.betTextController.text == null){
                return ;
              }
              betProvider.buttonTapSound('sounds/soft_button.wav');
              var previousBet = betProvider.statusData.where((element) => element.status == 'Bet');
              if(previousBet.isNotEmpty){
                betProvider.customWinHandler('3');
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
                color: betProvider.bettingStatus() || betProvider.customWinAmount == '3'
                    ? AppTheme.colorButtonGreen
                    : AppTheme.colorDisableButtons,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                '5',
                style: TextStyle(
                  fontSize: 18,
                  color: betProvider.bettingStatus() || betProvider.customWinAmount == '3'
                      ? AppTheme.colorActiveButtonText
                      : AppTheme.colorDisableButtonText,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 6,),
        Expanded(
          child: GestureDetector(
            onTap: (){
              if(betProvider.betTextController.text.isEmpty || betProvider.betTextController.text == null){
                return ;
              }
              betProvider.buttonTapSound('sounds/soft_button.wav');
              var previousBet = betProvider.statusData.where((element) => element.status == 'Bet');
              if(previousBet.isNotEmpty){
                betProvider.customWinHandler('4');
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
                color: betProvider.bettingStatus() || betProvider.customWinAmount == '4'
                    ? AppTheme.colorButtonGreen
                    : AppTheme.colorDisableButtons,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                '10',
                style: TextStyle(
                  fontSize: 18,
                  color: betProvider.bettingStatus() || betProvider.customWinAmount == '4'
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
