import 'package:cloud_firestore/cloud_firestore.dart';

class FbService{
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final String path;
  final String uId;
  DocumentReference ref;

  FbService(this.path, this.uId){
    ref = db.collection(path).doc(uId);
  }

  Future<DocumentReference> addBalance(Map balance){
    return ref.collection('totalBalance').add(balance);
  }

  Future<void> updateBalance(String id, Map data){
    return ref.collection('totalBalance').doc(id).update(data);
  }

  Future<QuerySnapshot> getBalance() async{
    return await ref.collection('totalBalance').get();
  }

  Stream<QuerySnapshot> balanceStream(){
    return ref.collection('totalBalance').snapshots();
  }

  //Bets data

  Future<DocumentReference> addData(Map data){
    return ref.collection('bettingResult').add(data);
  }


  Future<QuerySnapshot> getBetData(){
    return ref.collection('bettingResult').get();
  }

  Stream<QuerySnapshot> getDataCollection(){
    return ref.collection('bettingResult').orderBy('time', descending: true).snapshots();
  }

  Future<void> deleteDoc(String id){
    return ref.collection('bettingResult').doc(id).delete();
  }
}