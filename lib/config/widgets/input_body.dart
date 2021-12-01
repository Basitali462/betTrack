import 'package:flutter/material.dart';
import 'package:flutter_bet_track/config/provider/bet_text_provider.dart';
import 'package:flutter_bet_track/config/theme/app_theme.dart';
import 'package:flutter_bet_track/config/widgets/const/container_shadow.dart';
import 'package:flutter_bet_track/config/widgets/input_body_widgets/balance.dart';
import 'package:flutter_bet_track/config/widgets/input_body_widgets/bet_buttons.dart';
import 'package:flutter_bet_track/config/widgets/input_body_widgets/betting_field.dart';
import 'package:flutter_bet_track/config/widgets/input_body_widgets/draw_buttons.dart';
import 'package:flutter_bet_track/config/widgets/input_body_widgets/number_buttons.dart';
import 'package:flutter_bet_track/config/widgets/input_body_widgets/number_input.dart';
import 'package:flutter_bet_track/config/widgets/input_body_widgets/win_buttons.dart';
import 'package:provider/provider.dart';

class InputBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final betProvider = Provider.of<BetTextProvider>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: containerShadow,
      ),
      child: Column(
        children: [
          BalanceSplitSheet(),
          SizedBox(height: 20,),
          /*TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Search here....',
            ),
          ),*/
          BettingTextField(
            textController: betProvider.betTextController,
            isReadOnly: false,
            isAutoFocus: false,
            bettingFieldStatus: betProvider.bettingStatus() == true ? '(Betting)' : '',
          ),
          SizedBox(height: 20,),
          NumberInput(),
          SizedBox(height: 20,),
          BetButtons(),
          SizedBox(height: 15,),
          WinButtons(),
          SizedBox(height: 15,),
          NumberButtons(),
          SizedBox(height: 15,),
          DrawButtons(),
        ],
      ),
    );
  }
}
