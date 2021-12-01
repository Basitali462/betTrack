import 'package:flutter/material.dart';
import 'package:flutter_bet_track/config/theme/app_theme.dart';

class FundsInputField extends StatelessWidget {
  final TextEditingController textController;
  final bool isAutoFocus;

  FundsInputField({this.textController, this.isAutoFocus});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'INPUT FUNDS',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: textController,
            keyboardType: TextInputType.number,
            textAlignVertical: TextAlignVertical.center,
            autofocus: isAutoFocus,
            style: TextStyle(
              color: AppTheme.greyColor,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            //onChanged: betProvider.betTextChanges,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              //border: InputBorder.none,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 0.2,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
