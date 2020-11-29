import 'package:allnatureforkids/main_repository.dart';
import 'package:allnatureforkids/sound_manager/sound_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;
FlutterSecureStorage flutterSecureStorage;
MainRepository  mainRepository;
//SharedPreferences sharedPreferences;
setupLocators(){

  //ApiClient().addDefaultHeader('Authorization', "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhZG1pbiIsImF1dGgiOiJST0xFX0FETUlOLFJPTEVfVVNFUiIsImV4cCI6MTU5ODA5NjE2N30.wayxyNj2GvbcCiGPoUySp6YYpfG2wznAGgyFvm2M_bFhHUUC_2ZjX141IRA4o6U99h1h5fCf-ERSf7BQgWnBeQ");
  flutterSecureStorage = FlutterSecureStorage();
  mainRepository = MainRepository();
  getIt.registerLazySingleton(() =>  SoundManager());
  //sharedPreferences = SharedPreferences.getInstance() as SharedPreferences;

}