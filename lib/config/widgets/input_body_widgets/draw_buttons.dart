import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bet_track/config/model/game_status_model.dart';
import 'package:flutter_bet_track/config/provider/bet_text_provider.dart';
import 'package:flutter_bet_track/config/theme/app_theme.dart';
import 'package:provider/provider.dart';

class DrawButtons extends StatelessWidget {
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
                betProvider.clearBet();
                betProvider.addBets(
                  GameStatus(
                    status: 'Draw',
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
                    ? AppTheme.colorButtonOrange
                    : AppTheme.colorDisableButtons,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                'Draw',
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
              if(betProvider.betTextController.text.isEmpty || betProvider.betTextController.text == null){
                return ;
              }
              if(int.parse(betProvider.betTextController.text) > betProvider.currentTotalBalance){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Can\'t bet balance limit reached',
                    ),
                    duration: Duration(seconds: 2),
                  ),
                );
                return ;
              }
              var previousBet = betProvider.statusData.where((element) => element.status == 'Bet');
              betProvider.buttonTapSound('sounds/soft_button.wav');
              if(previousBet.isNotEmpty){
                //betProvider.changeBalance(int.parse(betProvider.betTextController.text));
                betProvider.addBets(
                  GameStatus(
                    status: 'Lose',
                    amount: betProvider.betTextController.text,
                    time: Timestamp.fromDate(DateTime.now()),
                  ),
                );
                betProvider.changeBalance(int.parse(betProvider.betTextController.text) * 2);
                int initBet = int.parse(betProvider.betTextController.text) + int.parse(betProvider.betTextController.text);
                betProvider.doubleBet(initBet.toString());
                betProvider.addBets(
                  GameStatus(
                    status: 'Bet',
                    amount: betProvider.betTextController.text,
                    time: Timestamp.fromDate(DateTime.now()),
                  ),
                );
              }else{
                //betProvider.changeBalance(int.parse(betProvider.betTextController.text) * 2);
                betProvider.changeBalance(int.parse(betProvider.betTextController.text) * 2);
                int initBet = int.parse(betProvider.betTextController.text) + int.parse(betProvider.betTextController.text);
                betProvider.doubleBet(initBet.toString());
                betProvider.addBets(
                  GameStatus(
                    status: 'Bet',
                    amount: betProvider.betTextController.text,
                    time: Timestamp.fromDate(DateTime.now()),
                  ),
                );
              }
              /*int initBet = int.parse(betProvider.betTextController.text) + int.parse(betProvider.betTextController.text);
              //print(initBet.toString());
              betProvider.doubleBet(initBet.toString());
              print(betProvider.betTextController.text);
              //betProvider.changeBalance(int.parse(betProvider.betTextController.text));
              betProvider.addBets(
                GameStatus(
                  status: 'Bet',
                  amount: betProvider.betTextController.text,
                  time: Timestamp.fromDate(DateTime.now()),
                ),
              );*/
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: betProvider.betTextController.text.isEmpty
                    ? AppTheme.colorDisableButtons
                    : AppTheme.colorButtonOrange,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                'Double',
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
      ],
    );
  }
}
