import 'package:flutter/material.dart';
import 'package:flutter_bet_track/config/provider/bet_text_provider.dart';
import 'package:flutter_bet_track/config/theme/app_theme.dart';
import 'package:flutter_bet_track/config/widgets/bet_history/bet_record_list.dart';
import 'package:flutter_bet_track/config/widgets/bet_reports/bet_report_items.dart';
import 'package:provider/provider.dart';

class BetReports extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final betReportProvider = Provider.of<BetTextProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bet Report',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black.withOpacity(0.7),
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 20,),
          betReportProvider.showBetReport ? GridView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 4,
              mainAxisSpacing: 10,
            ),
            children: [
              BetReportItems(
                itemColor: AppTheme.colorButtonGreen,
                itemTitle: 'Win:',
                itemCount: betReportProvider.totalWinsCount,
              ),
              BetReportItems(
                itemColor: AppTheme.colorButtonRed,
                itemTitle: 'Lose:',
                itemCount: betReportProvider.totalLostCount,
              ),
              BetReportItems(
                itemColor: AppTheme.colorButtonOrange,
                itemTitle: 'Draw:',
                itemCount: betReportProvider.totalDrawCount,
              ),
              BetReportItems(
                itemColor: AppTheme.colorButtonOrange,
                itemTitle: 'Rounds:',
                itemCount: betReportProvider.rounds,
              ),
              BetReportItems(
                itemColor: AppTheme.colorButtonOrange,
                itemTitle: 'Win RM :',
                itemCount: betReportProvider.winAmount+' RM',
              ),
              BetReportItems(
                itemColor: AppTheme.colorButtonOrange,
                itemTitle: 'Lose RM:',
                itemCount: betReportProvider.loseAmount+' RM',
              ),
              //Container(),
              BetReportItems(
                itemColor: AppTheme.colorButtonOrange,
                itemTitle: 'Win/Lose 2s:',
                itemCount: betReportProvider.winTwos,
              ),
              BetReportItems(
                itemColor: AppTheme.colorButtonOrange,
                itemTitle: 'Win/Lose 3s:',
                itemCount: betReportProvider.winThrees,
              ),
              BetReportItems(
                itemColor: AppTheme.colorButtonOrange,
                itemTitle: 'Win/Lose 4s:',
                itemCount: betReportProvider.winFours,
              ),
              BetReportItems(
                itemColor: AppTheme.colorButtonOrange,
                itemTitle: 'Win/Lose 5s:',
                itemCount: betReportProvider.winFives,
              ),
            ],
          ) : Container(
            padding: EdgeInsets.symmetric(vertical: 12),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppTheme.colorDisableButtons,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              'Press Done To Get Report Summary',
              style: TextStyle(
                color: AppTheme.greyColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          /*Row(
            children: [
              BetReportItems(
                itemColor: AppTheme.colorButtonGreen,
                itemTitle: 'Win:',
                itemCount: '20',
              ),
              BetReportItems(
                itemColor: AppTheme.colorButtonRed,
                itemTitle: 'Lose:',
                itemCount: '20',
              ),
            ],
          ),*/
        ],
      ),
    );
  }
}
