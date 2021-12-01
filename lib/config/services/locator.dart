import 'package:flutter_bet_track/config/services/firebase_services.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setUpLocator(String id){
  locator.registerLazySingleton(() => FbService('BetTracker', id));
}