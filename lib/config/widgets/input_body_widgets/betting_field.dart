import 'package:flutter/material.dart';
import 'package:flutter_bet_track/config/model/game_status_model.dart';
import 'package:flutter_bet_track/config/provider/bet_text_provider.dart';
import 'package:flutter_bet_track/config/theme/app_theme.dart';
import 'package:flutter_bet_track/config/widgets/const/container_shadow.dart';
import 'package:provider/provider.dart';

class BettingTextField extends StatelessWidget {
  final TextEditingController textController;
  final bool isReadOnly;
  final bool isAutoFocus;
  final String bettingFieldStatus;

  BettingTextField({this.textController, this.isReadOnly, this.isAutoFocus, this.bettingFieldStatus});

  @override
  Widget build(BuildContext context) {
    final betProvider = Provider.of<BetTextProvider>(context);
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: containerShadow,
      ),
      child: TextField(
        controller: textController,
        textAlignVertical: TextAlignVertical.center,
        readOnly: isReadOnly,
        autofocus: isAutoFocus,
        style: TextStyle(
          color: AppTheme.greyColor,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        //onChanged: betProvider.betTextChanges,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          border: InputBorder.none,
          /*border: OutlineInputBorder(
            borderSide: BorderSide(
              width: 0.2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),*/
          suffixIcon: GestureDetector(
            onTap: (){
              List<GameStatus> previousBet = betProvider.statusData.where((element) => element.status == 'Bet').toList();
              if(previousBet.isNotEmpty){
                betProvider.clearBet();
                betProvider.removeBet(previousBet[0].id);
                betProvider.backSpace();
                betProvider.customWinNumber('0');
              }else{
                betProvider.backSpace();
                betProvider.customWinNumber('0');
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    bettingFieldStatus,
                    style: TextStyle(
                      color: Color(0xFFA960FF),
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(width: 10,),
                  Image.asset(
                    'assets/icons/back-space.png',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
