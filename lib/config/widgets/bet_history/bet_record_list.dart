import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bet_track/config/data_files/game_status_data.dart';
import 'package:flutter_bet_track/config/model/game_status_model.dart';
import 'package:flutter_bet_track/config/provider/bet_text_provider.dart';
import 'package:flutter_bet_track/config/widgets/const/bet_status_item.dart';
import 'package:provider/provider.dart';

class BetRecordList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final betProvider = Provider.of<BetTextProvider>(context);
    return StreamBuilder(
      stream: betProvider.getPreviousBets(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //betProvider.statusData = snapshot.data;
        if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
          return Container();
        }
        betProvider.statusData = snapshot.data.docs
            .map((doc) => GameStatus.fromMap(doc.data(), doc.id))
            .toList();
        return ListView.separated(
          //reverse: true,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: betProvider.statusData.length,
          itemBuilder: (context, int index) {
            if (betProvider.statusData.isEmpty ||
                betProvider.statusData == null) {
              return Container();
            }
            return BetStatusItem(
              gameStatusItem: betProvider.statusData[index],
            );
          },
          separatorBuilder: (context, int index) {
            return Divider();
          },
        );
      },
    );
  }
}
