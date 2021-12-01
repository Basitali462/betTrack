import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BetSplitProvider with ChangeNotifier{
  final GlobalKey<FormState> splitFormId = GlobalKey<FormState>();

  String firstSplitTitle = 'Default';
  String firstSplitAmount = '1000';

  String secondSplitTitle;
  String secondSplitAmount;

  String thirdSplitTitle;
  String thirdSplitAmount;

  String forthSplitTitle;
  String forthSplitAmount;

  void splitBetMethod(String title, String titleName, String amount, String splitAmount){
    title = titleName;
    amount = splitAmount;
  }
}