import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bet_track/config/provider/bet_text_provider.dart';
import 'package:flutter_bet_track/config/services/locator.dart';
import 'package:flutter_bet_track/config/theme/app_theme.dart';
import 'package:flutter_bet_track/screens/home_page.dart';
import 'package:provider/provider.dart';

import 'config/provider/bet_split_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final String deviceId = await getId();
  setUpLocator(deviceId);
  runApp(MyApp());
}

Future<String> getId() async{
  var deviceInfo = DeviceInfoPlugin();
  if(Platform.isIOS){
    var iOSDevice = await deviceInfo.iosInfo;
    return iOSDevice.identifierForVendor;
  }else{
    var androidDevice = await deviceInfo.androidInfo;
    return androidDevice.androidId;
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BetTextProvider()),
        ChangeNotifierProvider(create: (_) => BetSplitProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: AppTheme.appTheme,
        home: HomePage(),
      ),
    );
  }
}
