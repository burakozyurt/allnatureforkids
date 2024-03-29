import 'package:allnatureforkids/locator.dart';
import 'package:allnatureforkids/main_model.dart';
import 'package:allnatureforkids/main_repository.dart';
import 'package:allnatureforkids/models/section_data_model.dart';
import 'package:allnatureforkids/pages/home_page_items/home_page_manage_model.dart';
import 'package:allnatureforkids/pages/learning_page_items/learning_page_repository.dart';
import 'package:allnatureforkids/pages/quiz_page_items/rive_bomb_items/rive_bomb_game_screen.dart';
import 'file:///C:/dev/allnatureforkids/allnatureforkids/lib/pages/home_page_items/home_page.dart';
import 'package:allnatureforkids/sound_manager/sound_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';

import 'app_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocators();

  runApp(MyApp());

}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  HomePageManageModel homePageManageModel;
  final _soundManager = getIt.get<SoundManager>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homePageManageModel = HomePageManageModel();
    SystemChrome.setEnabledSystemUIOverlays([]);
    WidgetsBinding.instance.addObserver(this);
    _soundManager.playBackground();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
//_soundManager.stopBackground();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
       // print('RESUMED');
        _soundManager.resumeBackground();

        // widget is resumed
        //_soundManager.playBackground();
        break;
      case AppLifecycleState.inactive:
        //print('INACTIVE');
        _soundManager.pauseBackground();

// widget is inactive
        //_soundManager.stopBackground();
        break;
      case AppLifecycleState.paused:
       // print('PAUSED');
        _soundManager.stopBackground();

// widget is paused
        //_soundManager.stopBackground();
        break;
      case AppLifecycleState.detached:
       // print('DETACHED');

// widget is detached
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider.value(
      value: MainRepository.mainModel,
      child: Consumer<MainModel>(
        builder: (context, data,_) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'All Nature For Kids',
            theme: ThemeData(
              primarySwatch: Colors.yellow,
              fontFamily: 'Poppins',
            ),
            supportedLocales: [
              Locale('tr','TR'),
              Locale('en','EN'),
            ],
            locale:data.preferredLanguageCode==null ? null: Locale(data.preferredLanguageCode,data.preferredLanguageCode.toUpperCase()),
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            localeResolutionCallback: (locale, supportedLocales){
              for(var supportedLocale in supportedLocales){
                if(supportedLocale.languageCode == locale.languageCode && supportedLocale.countryCode == locale.countryCode){
                  return supportedLocale;
                }
              }
              return supportedLocales.first;
            },

            home: ChangeNotifierProvider.value(value:homePageManageModel,child: new HomePage()),
           // home: RiveGameInitial(),
          );
        }
      ),
    );
  }
}