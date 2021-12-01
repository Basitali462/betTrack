import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bet_track/config/model/game_status_model.dart';
import 'package:flutter_bet_track/config/provider/bet_split_provider.dart';
import 'package:flutter_bet_track/config/provider/bet_text_provider.dart';
import 'package:flutter_bet_track/config/theme/app_theme.dart';
import 'package:flutter_bet_track/config/widgets/input_body_widgets/betting_field.dart';
import 'package:flutter_bet_track/config/widgets/split_textFields/split_input_field.dart';
import 'package:flutter_bet_track/config/widgets/top_bar.dart';
import 'package:provider/provider.dart';

import 'bottom_navigation_bar.dart';
import 'floating_button.dart';

class SplitPopup extends StatefulWidget {
  @override
  _SplitPopupState createState() => _SplitPopupState();
}

class _SplitPopupState extends State<SplitPopup> {
  TextEditingController betNameController = TextEditingController();
  TextEditingController betAmountController = TextEditingController();

  /*onTextChanged(String val){
    setState(() {
      betNameController.text = val;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    //final betProvider = Provider.of<BetTextProvider>(context);
    final splitProvider = Provider.of<BetSplitProvider>(context);
    return SafeArea(
      bottom: false,
      child: Scaffold(
        backgroundColor: Color(0xFF373535).withOpacity(0.4),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: TopBar(),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          margin: EdgeInsets.symmetric(vertical: 60, horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Form(
            key: splitProvider.splitFormId,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'How much do you want to split?',
                  style: TextStyle(
                    color: Color(0xFF9D9D9D),
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 20,),
                SplitInputField(
                  textController: betNameController,
                  isAutoFocus: false,
                  labelText: 'Split Title',
                  inputType: TextInputType.text,
                  splitFormValidate: (value){
                    if(value.isEmpty || value == null){
                      return 'Please Enter split title';
                    }
                    return null;
                  },
                  //onEdit: betProvider.betNameHandler,
                ),
                SizedBox(height: 20,),
                SplitInputField(
                  textController: betAmountController,
                  isAutoFocus: false,
                  labelText: 'Split Amount',
                  inputType: TextInputType.number,
                  splitFormValidate: (value){
                    if(value.isEmpty || value == null){
                      return 'Please Enter split amount';
                    }
                    return null;
                  },
                  //onEdit: betProvider.betNameHandler,
                ),
                /*BettingTextField(
                  textController: betProvider.customWinController,
                  isReadOnly: false,
                  isAutoFocus: true,
                  bettingFieldStatus: '',
                ),*/
                SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          if(splitProvider.splitFormId.currentState.validate()){
                            Navigator.of(context).pop();
                          }
                          /*if(betProvider.customWinController.text.isEmpty || betProvider.betTextController.text == null){
                            return ;
                          }
                          betProvider.customWinHandler(betProvider.customWinController.text);
                          betProvider.addBets(
                            GameStatus(
                              status: 'Win',
                              amount: betProvider.betTextController.text,
                              time: Timestamp.fromDate(DateTime.now()),
                            ),
                          );
                          Navigator.of(context).pop();*/
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: Color(0xFF1DCE98),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Split',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: AppTheme.colorButtonRed,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        /*bottomNavigationBar: BottomNavBar(),
        floatingActionButton: FloatingButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,*/
      ),
    );
  }
}
