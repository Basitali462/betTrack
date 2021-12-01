import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bet_track/config/data_files/game_status_data.dart';
import 'package:flutter_bet_track/config/enum/app_state.dart';
import 'package:flutter_bet_track/config/model/balance_model.dart';
import 'package:flutter_bet_track/config/model/game_status_model.dart';
import 'package:flutter_bet_track/config/services/firebase_services.dart';
import 'package:flutter_bet_track/config/services/locator.dart';

class BetTextProvider with ChangeNotifier{
  FbService fbService = locator<FbService>();
  AppStatesEnum currentAppState = AppStatesEnum.idle;

  TextEditingController betTextController = TextEditingController();
  TextEditingController customWinController = TextEditingController();
  TextEditingController newFundsInputController = TextEditingController();
  TextEditingController betNameController = TextEditingController();
  List<GameStatus> statusData = [];
  List<String> betAmountContainer = [];

  String updateAmount;
  String customWinAmount = '0';
  //String actualAmount;

  double updatedAmountHolder;
  double currentTotalBalance;
  List<UserBalance> userCurrentBlnc = [];
  //bool textBarStatus = false;
  bool updatingBalance  = false;
  bool showBetReport = false;
  final customAudioPlayer = AudioCache();

  void betNameHandler(String val){
    print('bet changes');
    betNameController.text = val;
    notifyListeners();
  }

  void updateBetAmount(String val){
    updateAmount = val;
    notifyListeners();
  }

  void clearTextField(){
    betTextController.clear();
    customWinNumber('0');
    notifyListeners();
  }

  void backSpace(){
    if(betTextController.text.isEmpty || betTextController.text == null){
      return ;
    }else{
      betAmountContainer.clear();
      List<String> result = betTextController.text.split('');
      betAmountContainer.addAll(result);
      betAmountContainer.removeAt(betAmountContainer.length - 1);
      betTextController.text = betAmountContainer.join('');
    }
    notifyListeners();
  }

  void updateBet(GameStatus status, String updateVal){
    var betToUpdate = statusData.where((element) => element.time == status.time);
    if(betToUpdate.isNotEmpty){
      statusData.removeWhere((element) => element.time == status.time);
      statusData.add(GameStatus(
        status: updateVal,
        amount: status.amount,
        time: status.time,
      ));
      /*if(int.parse(status.amount) > int.parse(updateAmount)){
        var difference = int.parse(status.amount) - int.parse(updateAmount);
        print('amount greater $difference');
        currentTotalBalance = currentTotalBalance - difference;
      }else if(int.parse(status.amount) < int.parse(updateAmount)){
        var difference = int.parse(updateAmount) - int.parse(status.amount);
        print('amount leser $difference');
        currentTotalBalance = currentTotalBalance - difference;
      }*/
    }
    notifyListeners();
  }

  void clearBet(){
    currentTotalBalance = currentTotalBalance + double.parse(betTextController.text);
    //updatedAmountHolder = double.parse(betTextController.text);
    updateFbBalance(currentTotalBalance);
    //updateUserAccountBalance(updatedAmountHolder);
    notifyListeners();
  }

  void placeBetHandler(BuildContext context){
    if(betTextController.text.isEmpty || betTextController.text == null){
      return ;
    }
    if(int.parse(betTextController.text) > currentTotalBalance){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Can\'t bet more than ${currentTotalBalance}',
          ),
          duration: Duration(seconds: 2),
        ),
      );
      return ;
    }
    if(betTextController.text == '0'){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Bet must be greater than 0',
          ),
          duration: Duration(seconds: 2),
        ),
      );
      return ;
    }
    var previousBet = statusData.where((element) => element.status == 'Bet');
    buttonTapSound('sounds/bet_sound.mp3');
    if(previousBet.isEmpty){
      changeBalance(int.parse(betTextController.text));
      addBets(
        GameStatus(
          status: 'Bet',
          amount: betTextController.text,
          time: Timestamp.fromDate(DateTime.now()),
        ),
      );
    }else if(previousBet.isNotEmpty){
      addBets(
        GameStatus(
          status: 'Lose',
          amount: betTextController.text,
          time: Timestamp.fromDate(DateTime.now()),
        ),
      );
      changeBalance(int.parse(betTextController.text));
      addBets(
        GameStatus(
          status: 'Bet',
          amount: betTextController.text,
          time: Timestamp.fromDate(DateTime.now()),
        ),
      );
    }
  }

  void betTextChanges(String val, BuildContext context){
    if(val == 'C'){
      List<GameStatus> previousBet = statusData.where((element) => element.status == 'Bet').toList();
      if(previousBet.isNotEmpty){
        clearBet();
        removeBet(previousBet[0].id);
        //betProvider.statusData.removeWhere((element) => element.status == 'Bet');
        clearTextField();
      }else{
        clearTextField();
      }
      return ;
    }
    if(val == 'Done'){
      //placeBetHandler(context)
      if(statusData.isEmpty){
        return ;
      }
      var previousBet = statusData.where((element) => element.status == 'Bet');
      if(previousBet.isNotEmpty){
        addBets(
          GameStatus(
            status: 'Lose',
            amount: betTextController.text,
            time: Timestamp.fromDate(DateTime.now()),
          ),
        );
      }
      clearTextField();
      showBetReport = true;
      resetBetReports();
      betsReportGetter();
      return ;
    }
    var previousBet = statusData.where((element) => element.status == 'Bet');
    if(betTextController.text.isEmpty || betTextController.text == null){
      betTextController.text = val;
    }else{
      //betTextController.text = betTextController.text + val;
      if(previousBet.isEmpty){
        betTextController.text = betTextController.text + val;
      }else if(previousBet.isNotEmpty){
        addBets(
          GameStatus(
            status: 'Lose',
            amount: betTextController.text,
            time: Timestamp.fromDate(DateTime.now()),
          ),
        );
        clearTextField();
        betTextController.text = betTextController.text + val;
      }

    }
    notifyListeners();
  }

  void doubleBet(String val){
    betTextController.text = val;
    notifyListeners();
  }

  void changeBalance(int val){
    if(currentTotalBalance > 0){
      currentTotalBalance = currentTotalBalance - val;
      updateFbBalance(currentTotalBalance);
      notifyListeners();
    }
  }

  Future addBets(GameStatus status) async{
    changeAppState(AppStatesEnum.busy);
    if(status.status == 'Fund'){
      await addBetToFb(status.toJson());
    }
    if(statusData.isNotEmpty){
      List<GameStatus> contain = statusData.where((element) => element.status == 'Bet').toList();
      if(contain.isNotEmpty){
        await removeBet(contain[0].id);
        await addBetToFb(status.toJson());
      }else if(status.status == 'Bet'){
        await addBetToFb(status.toJson());
        customWinNumber('0');
      }
    }else if(status.status == 'Bet'){
      await addBetToFb(status.toJson());
    }
    changeAppState(AppStatesEnum.idle);
    notifyListeners();
  }


  void betWinHandler(){
    currentTotalBalance = currentTotalBalance + (double.parse(betTextController.text) + double.parse(betTextController.text));
    updateFbBalance(currentTotalBalance);
    notifyListeners();
  }

  void customWinHandler(String val){
    if(val == '1'){
      currentTotalBalance = currentTotalBalance + (double.parse(betTextController.text) * 1.5);
      customWinNumber('1');
    }else if(val == '2'){
      currentTotalBalance = currentTotalBalance + (double.parse(betTextController.text) * 3);
      customWinNumber('2');
    }else if(val == '3'){
      currentTotalBalance = currentTotalBalance + (double.parse(betTextController.text) * 5);
      customWinNumber('3');
    }else if(val == '4'){
      currentTotalBalance = currentTotalBalance + (double.parse(betTextController.text) * 10);
      customWinNumber('4');
    }else{
      currentTotalBalance = currentTotalBalance + (double.parse(betTextController.text) + int.parse(val));
    }
    updateFbBalance(currentTotalBalance);
    notifyListeners();
  }

  void customWinNumber(String val){
    customWinAmount = val;
    notifyListeners();
  }

  bool bettingStatus(){
    if(statusData != null && statusData.isNotEmpty){
      List<GameStatus> contain = statusData.where((element) => element.status == 'Bet').toList();
      if(contain.isNotEmpty && betTextController.text.isEmpty){
        updateUserAccountBalance(double.parse(contain[0].amount));
        removeBet(contain[0].id);
        return false;
      }else if(contain.isNotEmpty){
        return true;
      }
      return false;
    }
    return false;
  }

  Future updateUserAccountBalance(double amount) async{
    if(!updatingBalance){
      updatingBalance = true;
      currentTotalBalance = currentTotalBalance + amount;
      updateFbBalance(currentTotalBalance);
    }
  }

  Future removeBet(String id) async{
    statusData.removeWhere((element) => element.id == id);
    await fbService.deleteDoc(id);
  }

  Stream<QuerySnapshot> getPreviousBets(){
    return fbService.getDataCollection();
  }

  Future addBetToFb(Map data) async{
    return fbService.addData(data);
  }


  Future fetchBalance(double val) async{
    var resp = await fbService.getBalance();
    List<UserBalance> balanceList = resp.docs.map((doc){
      fbService.updateBalance(doc.id, UserBalance(balance: val).toJson());
    }).toList(); /*=> UserBalance.fromMap(doc.data(), doc.id)).toList();*/
    updatingBalance = false;
    return ;
  }

  Stream<QuerySnapshot> fetchBalanceAsStream(){
    return fbService.balanceStream();
  }

  Future addBalance(Map data) async{
    return fbService.addBalance(data);
    //notifyListeners();
  }

  void changeAppState(AppStatesEnum val){
    currentAppState = val;
    //notifyListeners();
  }

  Future updateFbBalance(double val) async{
    await fetchBalance(val);
    /*if(!updatingBalance){
      print('updating balance');
      updatingBalance = true;
      await fetchBalance(val);
    }*/
    /*var resp = await fbService.getBalance();
    List<UserBalance> balanceList = resp.docs.map((doc) => UserBalance.fromMap(doc.data(), doc.id)).toList();
    if(userCurrentBlnc.isNotEmpty){
      print('blnc id' + balanceList[0].id);
      await fbService.updateBalance(userCurrentBlnc[0].id, UserBalance(balance: val).toJson());
    }*/
    return ;
  }

  //Add New Funds
  void addFunds(double val){
    var previousBet = statusData.where((element) => element.status == 'Bet');
    if(previousBet.isNotEmpty){
      addBets(
        GameStatus(
          status: 'Lose',
          amount: betTextController.text,
          time: Timestamp.fromDate(DateTime.now()),
        ),
      );
    }
    updateUserAccountBalance(val);
    clearTextField();
    addBets(
      GameStatus(
        status: 'Fund',
        amount: newFundsInputController.text,
        time: Timestamp.fromDate(DateTime.now()),
      ),
    );
    newFundsInputController.clear();
    return ;
  }

  //Bet Report Scenarios
  String totalWinsCount = '0';
  String totalLostCount = '0';
  String totalDrawCount = '0';
  String totalWLCount = '0';
  String rounds = '0';
  String winTwos = '0';
  String winThrees = '0';
  String winFours = '0';
  String winFives = '0';
  String winAmount = '0';
  String loseAmount = '0';

  void resetBetReports(){
    totalWinsCount = '0';
    totalLostCount = '0';
    totalDrawCount = '0';
    totalWLCount = '0';
    rounds = '0';
    winTwos = '0';
    winThrees = '0';
    winFours = '0';
    winFives = '0';
    winAmount = '0';
    loseAmount = '0';
  }

  void betsReportGetter(){
    List<GameStatus> previousBetsWinList = statusData.where((element) => element.status == 'Win').toList();
    List<GameStatus> previousBetsLoseList = statusData.where((element) => element.status == 'Lose').toList();
    List<GameStatus> previousBetsDrawList = statusData.where((element) => element.status == 'Draw').toList();
    if(previousBetsWinList.isNotEmpty){
      totalWinsCount = (previousBetsWinList.length).toString();
    }
    if(previousBetsLoseList.isNotEmpty){
      totalLostCount = (previousBetsLoseList.length).toString();
    }
    if(previousBetsDrawList.isNotEmpty){
      totalDrawCount = (previousBetsDrawList.length).toString();
    }
    if(previousBetsWinList.isNotEmpty || previousBetsLoseList.isNotEmpty){
      totalWLCount = (previousBetsWinList.length).toString() + '/' + (previousBetsLoseList.length).toString();
    }
    totalWinAmountCounter(previousBetsWinList);
    totalLostAmountCounter(previousBetsLoseList);
    totalRoundsCounter();
    continuesTwosCounter();
    continuesThreesCounter();
    continuesFoursCounter();
    continuesFivesCounter();
    //continuesWinsLostCounter();
    notifyListeners();
  }

  void totalWinAmountCounter(List<GameStatus> winList){
    for(int i = 0; i < winList.length; i++){
      winAmount = (double.parse(winAmount) + double.parse(winList[i].amount)).toString();
    }
  }

  void totalLostAmountCounter(List<GameStatus> loseList){
    for(int i = 0; i < loseList.length; i++){
      loseAmount = (double.parse(loseAmount) + double.parse(loseList[i].amount)).toString();
    }
  }

  void totalRoundsCounter(){
    rounds = statusData.length.toString();
  }

  void continuesTwosCounter(){
    for(int i = 0; i < statusData.length; i++){
      if(i + 1 < statusData.length){
        if(statusData[i].status == 'Win' && statusData[i+1].status == 'Win'){
          winTwos = (int.parse(winTwos) + 1).toString();
          i++;
        }
      }
    }
  }

  void continuesThreesCounter(){
    for(int i = 0; i < statusData.length; i++){
      if(i + 2 < statusData.length){
        if(statusData[i].status == 'Win'
            && statusData[i+1].status == 'Win'
            && statusData[i+2].status == 'Win'){
          winThrees = (int.parse(winThrees) + 1).toString();
          i = i+2;
        }
      }
    }
  }

  void continuesFoursCounter(){
    for(int i = 0; i < statusData.length; i++){
      if(i + 3 < statusData.length){
        if(statusData[i].status == 'Win'
            && statusData[i+1].status == 'Win'
            && statusData[i+2].status == 'Win'
            && statusData[i+3].status == 'Win'){
          winFours = (int.parse(winFours) + 1).toString();
          i = i+3;
        }
      }
    }
  }

  void continuesFivesCounter(){
    for(int i = 0; i < statusData.length; i++){
      if(i + 4 < statusData.length){
        if(statusData[i].status == 'Win'
            && statusData[i+1].status == 'Win'
            && statusData[i+2].status == 'Win'
            && statusData[i+3].status == 'Win'){
          winFives = (int.parse(winFives) + 1).toString();
          i = i+4;
        }
      }
    }
  }

  /*void continuesWinsLostCounter(){
    for(int i = 0; i <= statusData.length; i++){
      if(i + 1 < statusData.length){
        if(statusData[i].status == 'Win' && statusData[i+1].status == 'Win'){
          if(i + 2 < statusData.length && statusData[i+1].status == 'Win' && statusData[i+2].status != 'Win'){
            winTwos = (int.parse(winTwos) + 1).toString();
          }
        }
        *//*if(statusData[i].status == 'Lose' && statusData[i+1].status == 'Lose'){
          winTwos = (int.parse(winTwos) + 1).toString();
        }*//*
      }
      if(i + 2 < statusData.length){
        if(statusData[i].status == 'Win'
            && statusData[i+1].status == 'Win' && statusData[i+2].status == 'Win'){
          winThrees = (int.parse(winThrees) + 1).toString();
        }
      }
    }
  }*/

//Button sound
  void buttonTapSound(String file){
    customAudioPlayer.play(file);
  }

}