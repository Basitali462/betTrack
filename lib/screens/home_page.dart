import 'package:flutter/material.dart';
import 'package:flutter_bet_track/config/enum/app_state.dart';
import 'package:flutter_bet_track/config/provider/bet_text_provider.dart';
import 'package:flutter_bet_track/config/widgets/bet_reports/bet_reports.dart';
import 'package:flutter_bet_track/config/widgets/bets_record.dart';
import 'package:flutter_bet_track/config/widgets/bottom_navigation_bar.dart';
import 'package:flutter_bet_track/config/widgets/drawer_handler/drawer.dart';
import 'package:flutter_bet_track/config/widgets/floating_button.dart';
import 'package:flutter_bet_track/config/widgets/input_body.dart';
import 'package:flutter_bet_track/config/widgets/top_bar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final betProvider = Provider.of<BetTextProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: TopBar(),
      ),
      drawer: CustomDrawerMenu(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                //betProvider.textBarStatus ? BetStatus() : Container(),
                InputBody(),
                SizedBox(height: 20,),
                BetReports(),
                //SizedBox(height: 20,),
                BetsRecord(),
              ],
            ),
            betProvider.currentAppState == AppStatesEnum.idle
                ? Container()
                : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.transparent,
              child: Center(
                child: CircularProgressIndicator(),
              ),),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
      floatingActionButton: FloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
