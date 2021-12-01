import 'package:flutter/material.dart';
import 'package:flutter_bet_track/config/provider/bet_text_provider.dart';
import 'package:flutter_bet_track/config/theme/app_theme.dart';
import 'package:flutter_bet_track/config/widgets/const/container_shadow.dart';
import 'package:flutter_bet_track/config/widgets/input_body_widgets/number_item.dart';
import 'package:provider/provider.dart';

class NumberInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final betProvider = Provider.of<BetTextProvider>(context);
    return Container(
      decoration: BoxDecoration(
        //color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              color: AppTheme.greyColor.withOpacity(0.5),
              offset: Offset(0.5, 0.5),
              blurRadius: 0.5
          ),
          BoxShadow(
              color: AppTheme.greyColor.withOpacity(0.5),
              offset: Offset(-0.5, -0.5),
              blurRadius: 0.5
          ),
        ],
      ),
      child: Table(
        children: [
          TableRow(
            children: [
              NumberItem(
                itemText: '1',
                onItemTap: (){
                  betProvider.buttonTapSound('sounds/soft_button.wav');
                  betProvider.betTextChanges('1', context);
                },
              ),
              NumberItem(
                itemText: '2',
                onItemTap: (){
                  betProvider.buttonTapSound('sounds/soft_button.wav');
                  betProvider.betTextChanges('2', context);
                },
              ),
              NumberItem(
                itemText: '3',
                onItemTap: (){
                  betProvider.buttonTapSound('sounds/soft_button.wav');
                  betProvider.betTextChanges('3', context);
                },
              ),
            ],
          ),
          TableRow(
            children: [
              NumberItem(
                itemText: '4',
                onItemTap: (){
                  betProvider.buttonTapSound('sounds/soft_button.wav');
                  betProvider.betTextChanges('4', context);
                },
              ),
              NumberItem(
                itemText: '5',
                onItemTap: (){
                  betProvider.buttonTapSound('sounds/soft_button.wav');
                  betProvider.betTextChanges('5', context);
                },
              ),
              NumberItem(
                itemText: '6',
                onItemTap: (){
                  betProvider.buttonTapSound('sounds/soft_button.wav');
                  betProvider.betTextChanges('6', context);
                },
              ),
            ],
          ),
          TableRow(
            children: [
              NumberItem(
                itemText: '7',
                onItemTap: (){
                  betProvider.buttonTapSound('sounds/soft_button.wav');
                  betProvider.betTextChanges('7', context);
                },
              ),
              NumberItem(
                itemText: '8',
                onItemTap: (){
                  betProvider.buttonTapSound('sounds/soft_button.wav');
                  betProvider.betTextChanges('8', context);
                },
              ),
              NumberItem(
                itemText: '9',
                onItemTap: (){
                  betProvider.buttonTapSound('sounds/soft_button.wav');
                  betProvider.betTextChanges('9', context);
                },
              ),
            ],
          ),
          TableRow(
            children: [
              NumberItem(
                itemText: 'Done',
                onItemTap: (){
                  betProvider.buttonTapSound('sounds/soft_button.wav');
                  betProvider.betTextChanges('Done', context);
                },
              ),
              NumberItem(
                itemText: '0',
                onItemTap: (){
                  betProvider.buttonTapSound('sounds/soft_button.wav');
                  betProvider.betTextChanges('0', context);
                },
              ),
              NumberItem(
                itemText: 'C',
                onItemTap: (){
                  betProvider.buttonTapSound('sounds/soft_button.wav');
                  betProvider.betTextChanges('C', context);
                },
              ),
            ],
          ),
        ],
      ),
      /*GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        childAspectRatio: 1.3,
        shrinkWrap: true,
        children: List.generate(12, (index){
          return Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 12),
            alignment: Alignment.center,
            height: 30,
            child: Text(
              index.toString(),
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          );
        }),
      ),*/
    );
  }
}
