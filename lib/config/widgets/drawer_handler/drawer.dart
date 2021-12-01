import 'package:flutter/material.dart';
import 'package:flutter_bet_track/config/provider/bet_text_provider.dart';
import 'package:flutter_bet_track/config/widgets/drawer_handler/add_fund_button.dart';
import 'package:flutter_bet_track/config/widgets/drawer_handler/funds_input_field.dart';
import 'package:provider/provider.dart';

class CustomDrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final betProvider = Provider.of<BetTextProvider>(context);
    return Drawer(
      child: ListView(
        children: [
          SizedBox(height: 48,),
          FundsInputField(
            textController: betProvider.newFundsInputController,
            isAutoFocus: false,
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: AddFundsButton(),
          ),
          SizedBox(height: 20,),
          Divider(
            thickness: 2,
          ),

        ],
      ),
    );
  }
}
