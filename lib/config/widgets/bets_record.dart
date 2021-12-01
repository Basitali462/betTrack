import 'package:flutter/material.dart';
import 'package:flutter_bet_track/config/widgets/bet_history/bet_record_list.dart';
import 'package:flutter_bet_track/config/widgets/bet_history/bet_title_bar.dart';

class BetsRecord extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
      child: Column(
        children: [
          BetTitleBar(),
          SizedBox(height: 20,),
          BetRecordList(),
        ],
      ),
    );
  }
}
