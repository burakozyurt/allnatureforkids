import 'package:allnatureforkids/locator.dart';
import 'package:allnatureforkids/sound_manager/sound_manager.dart';
import 'package:flutter/cupertino.dart';

class SectionListCardModel extends ChangeNotifier{

  String _sectionName;
  String _sectionCoverPhotoPath;
  String _sectionIdName;

  double _scale = 1.0;

  double get scale => _scale;

  set scale(double value) {
    _scale = value;
    notifyListeners();
  }
  resetVariables(){
    _scale = 1;

  }

  pressDetails(String pressInfo)async{
    print(pressInfo);
    if(pressInfo == 'DOWN'){
      _scale = 0.95;
      getIt.get<SoundManager>().playTap();
      notifyListeners();

    }else if(pressInfo == 'UP'){
      await Future.delayed(Duration(milliseconds: 50));
      _scale = 1;
    }else if(pressInfo == 'LP_START'){
      _scale = 0.95;
      getIt.get<SoundManager>().playSectionName(sectionIdName);

    }else if(pressInfo == 'LP_END'){
      _scale = 1;
    }else if(pressInfo == 'CANCEL'){
      _scale = 1;
    }
    notifyListeners();
  }

  SectionListCardModel(this._sectionName, this._sectionCoverPhotoPath, this._sectionIdName);

  String get sectionName => _sectionName;

  set sectionName(String value) {
    _sectionName = value;
    notifyListeners();
  }

  String get sectionCoverPhotoPath => _sectionCoverPhotoPath;

  String get sectionIdName => _sectionIdName;

  set sectionIdName(String value) {
    _sectionIdName = value;
    notifyListeners();
  }

  set sectionCoverPhotoPath(String value) {
    _sectionCoverPhotoPath = value;
    notifyListeners();
  }
}