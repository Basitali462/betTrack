import 'package:flutter/material.dart';
import 'package:flutter_bet_track/config/model/game_status_model.dart';
import 'package:flutter_bet_track/config/provider/bet_text_provider.dart';
import 'package:flutter_bet_track/config/theme/app_theme.dart';
import 'package:provider/provider.dart';

class BetEditPopup extends StatefulWidget {
  final GameStatus currentHistoryStatus;
  BetEditPopup({this.currentHistoryStatus});
  @override
  _BetEditPopupState createState() => _BetEditPopupState();
}

class _BetEditPopupState extends State<BetEditPopup> {
  final states = [
    'Win',
    'Lose',
    'Bet',
    'Draw',
    'Cancel'
  ];

  String value;
  TextEditingController updateAmountController = TextEditingController();

  DropdownMenuItem buildMenuItem(String item){
    return DropdownMenuItem(
      value: item,
      child: Text(
        item,
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      value = widget.currentHistoryStatus.status;
      updateAmountController.text = widget.currentHistoryStatus.amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    final betProvider = Provider.of<BetTextProvider>(context);
    return Scaffold(
      backgroundColor: Color(0xFF373535).withOpacity(0.4),
      body: Container(
        //height: MediaQuery.of(context).size.height / 2.5,
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        margin: EdgeInsets.symmetric(vertical: 60, horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Edit Your Bet',
              style: TextStyle(
                color: Color(0xFF9D9D9D),
                fontSize: 18,
              ),
            ),
            SizedBox(height: 20,),
            DropdownButtonHideUnderline(
              child: DropdownButton(
                isExpanded: true,
                value: value,
                items: states.map(buildMenuItem).toList(),
                onChanged: (val){
                  setState(() {
                    value = val;
                  });
                },
              ),
            ),
            /*SizedBox(height: 20,),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Amount',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                Container(
                  width:80,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppTheme.greyColor,
                      width: 0.5
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextField(
                    controller: updateAmountController,
                    onChanged: (val){
                      print(val.toString());
                      betProvider.updateBetAmount(val);
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),*/
            //Spacer(),
            SizedBox(height: 50,),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      betProvider.updateBet(widget.currentHistoryStatus, value);
                      Navigator.of(context).pop();
                      /*if(updateAmountController.text.isNotEmpty){
                        betProvider.updateBet(widget.currentHistoryStatus, value);
                        if(widget.currentHistoryStatus.status == 'Bet'){
                          betProvider.betTextController.text = updateAmountController.text;
                        }
                        Navigator.of(context).pop();
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Amount Can\'t be Empty',
                            ),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }*/
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: AppTheme.colorButtonBlue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Update',
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
    );
  }
}
