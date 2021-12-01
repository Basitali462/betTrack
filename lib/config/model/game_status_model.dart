import 'package:cloud_firestore/cloud_firestore.dart';

class GameStatus{
  final String id;
  final String status;
  final String amount;
  final Timestamp time;
  //final int curBalance;

  GameStatus({this.id, this.status, this.amount, this.time});

  GameStatus.fromMap(dynamic snapshot, String id)
      : id = id ?? '',
        status = snapshot['status'] ?? '',
        amount = snapshot['amount'] ?? '',
        time = snapshot['time'] ?? '';
        //curBalance = snapshot['curBalance'] ?? '';

  toJson() {
    return {
      'status': status,
      'amount': amount,
      'time': time,
      //'curBalance': curBalance,
    };
  }
}