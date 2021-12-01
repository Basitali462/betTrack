import 'package:flutter/material.dart';
import 'package:flutter_bet_track/config/model/game_status_model.dart';
import 'package:flutter_bet_track/config/theme/app_theme.dart';
import 'package:flutter_bet_track/config/widgets/const/bet_edit_popup.dart';
import 'package:flutter_bet_track/config/widgets/split_popup.dart';
import 'package:intl/intl.dart';

class BetStatusItem extends StatelessWidget {
  final GameStatus gameStatusItem;
  BetStatusItem({this.gameStatusItem});

  Widget statusIcon(){
    if(gameStatusItem.status == 'Bet'){
      return Image.asset(
        'assets/icons/bet-icon.png',
      );
    }else if(gameStatusItem.status == 'Win'){
      return Image.asset(
        'assets/icons/win-icon.png',
      );
    }else if(gameStatusItem.status == 'Lose'){
      return Image.asset(
        'assets/icons/lose-icon.png',
      );
    }else if(gameStatusItem.status == 'Draw'){
      return Image.asset(
        'assets/icons/draw-icon.png',
      );
    }else if(gameStatusItem.status == 'Cancel'){
      return Image.asset(
        'assets/icons/cancel-icon.png',
      );
    }else if(gameStatusItem.status == 'Fund'){
      return Image.asset(
        'assets/icons/bet-icon.png',
      );
    }
    return Container();
  }

  Color textColor(){
    if(gameStatusItem.status == 'Bet'){
      return AppTheme.colorButtonBlue;
    }else if(gameStatusItem.status == 'Win'){
      return AppTheme.colorButtonGreen;
    }else if(gameStatusItem.status == 'Lose'){
      return AppTheme.colorButtonRed;
    }else if(gameStatusItem.status == 'Draw'){
      return AppTheme.colorButtonOrange;
    }else if(gameStatusItem.status == 'Cancel'){
      return AppTheme.colorButtonRed;
    }else if(gameStatusItem.status == 'Fund'){
      return AppTheme.colorButtonBlue;
    }
    return Colors.transparent;
  }

  Widget betTextIcon(){
    if(gameStatusItem.status == 'Bet'){
      return Icon(
        Icons.remove,
        size: 18,
        color: AppTheme.colorButtonBlue,
      );
    }else if(gameStatusItem.status == 'Win'){
      return Icon(
        Icons.add,
        size: 18,
        color: AppTheme.colorButtonGreen,
      );
    }else if(gameStatusItem.status == 'Lose'){
      return Icon(
        Icons.arrow_drop_down,
        size: 18,
        color: AppTheme.colorButtonRed,
      );
    }else if(gameStatusItem.status == 'Draw'){
      return Image.asset(
        'assets/icons/equal-icon.png',
        height: 18,
        color: AppTheme.colorButtonOrange,
      );
      /*Icon(
        Icons.menu,
        size: 18,
        color: AppTheme.colorButtonOrange,
      );*/
    }else if(gameStatusItem.status == 'Cancel'){
      return Icon(
        Icons.remove,
        size: 18,
        color: AppTheme.colorButtonRed,
      );
    }else if(gameStatusItem.status == 'Fund'){
      return Icon(
        Icons.add,
        size: 18,
        color: AppTheme.colorButtonBlue,
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: (){
        /*showDialog(
          useSafeArea: false,
          barrierDismissible: false,
          barrierColor: Colors.transparent,
          context: context,
          builder: (context){
            return BetEditPopup(
              currentHistoryStatus: gameStatusItem,
            );
          },);*/
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.colorDisableButtons,
              ),
              child: statusIcon(),
            ),
            SizedBox(width: 10,),
            Text(
              gameStatusItem.status,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            Spacer(),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    betTextIcon(),
                    Text(
                      ' RM ' + gameStatusItem.amount,
                      style: TextStyle(
                        fontSize: 18,
                        color: textColor(),
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 5,),
                Text(
                  DateFormat('hh:mm').format((gameStatusItem.time).toDate()).toString(),
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
