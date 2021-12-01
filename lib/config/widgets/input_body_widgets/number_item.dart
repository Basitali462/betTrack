import 'package:flutter/material.dart';
import 'package:flutter_bet_track/config/theme/app_theme.dart';

class NumberItem extends StatelessWidget {
  final String itemText;
  final Function onItemTap;
  
  NumberItem({this.itemText, this.onItemTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onItemTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 0.2,
            color: AppTheme.greyColor.withOpacity(0.5),
          ),
          borderRadius: itemText == '1'
              ? BorderRadius.only(topLeft: Radius.circular(8))
              : itemText == '3' ? BorderRadius.only(topRight: Radius.circular(8))
              : itemText == 'Done' ? BorderRadius.only(bottomLeft: Radius.circular(8))
              : itemText == 'C' ? BorderRadius.only(bottomRight: Radius.circular(8))
              : BorderRadius.zero,
        ),
        alignment: Alignment.center,
        height: 70,
        child: Text(
          itemText,
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
