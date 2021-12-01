import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bet_track/config/model/balance_model.dart';
import 'package:flutter_bet_track/config/provider/bet_text_provider.dart';
import 'package:flutter_bet_track/config/theme/app_theme.dart';
import 'package:flutter_bet_track/config/widgets/split_popup.dart';
import 'package:flutter_bet_track/config/widgets/split_textFields/split_input_field.dart';
import 'package:provider/provider.dart';

class BalanceSplitSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final betProvider = Provider.of<BetTextProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        StreamBuilder(
          stream: betProvider.fetchBalanceAsStream(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.connectionState == ConnectionState.active
                || snapshot.connectionState == ConnectionState.done){
              if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
                betProvider.addBalance(UserBalance(balance: 1000).toJson());
                return Container();
              }
              if(snapshot.data.docs.isEmpty){
                return Container();
              }
              betProvider.userCurrentBlnc = snapshot.data.docs
                  .map((doc) {
                    return UserBalance.fromMap(doc.data(), doc.id);
              }).toList(); /*=> UserBalance.fromMap(doc.data(), doc.id))
                  .toList();*/
              if(betProvider.currentTotalBalance == null){
                betProvider.currentTotalBalance = betProvider.userCurrentBlnc[0].balance;
              }
              return RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: 'Balance: ',
                    ),
                    TextSpan(
                      text: '\$${betProvider.currentTotalBalance}',
                      style: TextStyle(
                        color: AppTheme.colorGreen,
                      ),
                    ),
                  ],
                ),
              );
            }
            return Container();
          },
        ),
        GestureDetector(
          onTap: (){
            showDialog(
              useSafeArea: false,
              barrierDismissible: false,
              barrierColor: Colors.transparent,
              context: context,
              builder: (context){
                return SplitPopup();
                /*AlertDialog(
                  title: Text(
                    'How much do you want to split?',
                    style: TextStyle(
                      color: Color(0xFF9D9D9D),
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  content: TextField(
                    controller: betProvider.betNameController,
                    decoration: InputDecoration(
                      hintText: 'Bet Title',
                    ),
                  ),
                );*/
              },);
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: AppTheme.colorGreen,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Split',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
