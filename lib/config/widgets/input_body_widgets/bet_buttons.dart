import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bet_track/config/data_files/game_status_data.dart';
import 'package:flutter_bet_track/config/model/game_status_model.dart';
import 'package:flutter_bet_track/config/provider/bet_text_provider.dart';
import 'package:flutter_bet_track/config/theme/app_theme.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class BetButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final betProvider = Provider.of<BetTextProvider>(context);
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: (){
              betProvider.placeBetHandler(context);
              /*if(betProvider.betTextController.text.isEmpty || betProvider.betTextController.text == null){
                return ;
              }
              if(int.parse(betProvider.betTextController.text) > betProvider.currentTotalBalance){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Can\'t bet more than ${betProvider.currentTotalBalance}',
                    ),
                    duration: Duration(seconds: 2),
                  ),
                );
                return ;
              }

              var previousBet = betProvider.statusData.where((element) => element.status == 'Bet');
              if(previousBet.isEmpty){
                betProvider.changeBalance(int.parse(betProvider.betTextController.text));
                betProvider.addBets(
                  GameStatus(
                    status: 'Bet',
                    amount: betProvider.betTextController.text,
                    time: Timestamp.fromDate(DateTime.now()),
                  ),
                );
              }else if(previousBet.isNotEmpty){
                betProvider.addBets(
                  GameStatus(
                    status: 'Lose',
                    amount: betProvider.betTextController.text,
                    time: Timestamp.fromDate(DateTime.now()),
                  ),
                );
                betProvider.changeBalance(int.parse(betProvider.betTextController.text));
                betProvider.addBets(
                  GameStatus(
                    status: 'Bet',
                    amount: betProvider.betTextController.text,
                    time: Timestamp.fromDate(DateTime.now()),
                  ),
                );
              }*/
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: betProvider.betTextController.text.isEmpty
                    ? AppTheme.colorDisableButtons
                    : AppTheme.colorButtonBlue,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                'Bet',
                style: TextStyle(
                  fontSize: 18,
                  color: betProvider.betTextController.text.isEmpty
                      ? AppTheme.colorDisableButtonText
                      : AppTheme.colorActiveButtonText,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 15,),
        Expanded(
          child: GestureDetector(
            onTap: (){
              if(betProvider.betTextController.text.isEmpty || betProvider.betTextController.text == null){
                return ;
              }
              List<GameStatus> previousBet = betProvider.statusData.where((element) => element.status == 'Bet').toList();
              betProvider.buttonTapSound('sounds/soft_button.wav');
              if(previousBet.isNotEmpty){
                betProvider.clearBet();
                betProvider.removeBet(previousBet[0].id);
              }
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: betProvider.bettingStatus()
                    ? AppTheme.colorButtonRed
                    : AppTheme.colorDisableButtons,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                'Cancel',
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
