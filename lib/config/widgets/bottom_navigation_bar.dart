import 'package:flutter/material.dart';
import 'package:flutter_bet_track/config/theme/app_theme.dart';
import 'package:flutter_bet_track/config/widgets/bottom_nav_items.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BottomAppBar(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: /*[
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 4,
              itemBuilder: (context, i){
                return BottomNavItems(
                  number: '33321',
                  title: 'Default',
                );
              },
            ),
          ],*/
          [
            BottomNavItems(
              number: '33321',
              title: 'Default',
            ),
            BottomNavItems(
              number: '421',
              title: 'Risk Bet',
            ),
            SizedBox(width: size.width / 12,),
            BottomNavItems(
              number: '32',
              title: 'Bonus Bet',
            ),
            BottomNavItems(
              number: '33321',
              title: 'Risk Bet',
            ),
          ],
        ),
      ),
    );
  }
}
