import 'package:allnatureforkids/app_localizations.dart';
import 'package:allnatureforkids/locator.dart';
import 'package:allnatureforkids/models/section_data_model.dart';
import 'package:allnatureforkids/sound_manager/sound_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:swipe_stack/swipe_stack.dart';

class LearningPageManageModel extends ChangeNotifier{
  double _startQuizScale = 1.0;

  double get startQuizScale => _startQuizScale;

  set startQuizScale(double value) {
    _startQuizScale = value;
    notifyListeners();
  }

  double _leftScale = 1.0;

  double get leftScale => _leftScale;

  set leftScale(double value) {
    _leftScale = value;
    notifyListeners();
  }

  double _rightScale = 1.0;

  double get rightScale => _rightScale;

  set rightScale(double value) {
    _rightScale = value;
    notifyListeners();
  }

  double _shuffleScale = 1.0;

  double get shuffleScale => _shuffleScale;

  set shuffleScale(double value) {
    _shuffleScale = value;
    notifyListeners();
  }

  int _currentIndex = 0;
  int _beforeCurrentIndex = 0;

  int get beforeCurrentIndex => _beforeCurrentIndex;

  set beforeCurrentIndex(int value) {
    _beforeCurrentIndex = value;
  }

  int get currentIndex => _currentIndex;

  set currentIndex(int value){
    _currentIndex = value;
    notifyListeners();

  }
  double _imageScale = 1;


  double get imageScale => _imageScale;

  set imageScale(double value) {
    _imageScale = value;
    notifyListeners();
  }

  bool _isAnimationEnabled = false;


  bool get isAnimationEnabled => _isAnimationEnabled;

  set isAnimationEnabled(bool value) {
    _isAnimationEnabled = value;
    notifyListeners();
  }

  resetVariables(){
    leftScale = 1;
    shuffleScale = 1;
    rightScale = 1;
    currentIndex = 0;
  }
  pressDetailsLeft(String pressInfo)async{
    //print(pressInfo);
    if(pressInfo == 'DOWN'){
      _leftScale = 0.95;
      getIt.get<SoundManager>().playTap();
      notifyListeners();

    }else if(pressInfo == 'UP'){
      await Future.delayed(Duration(milliseconds: 50));
      _leftScale = 1;
    }else if(pressInfo == 'LP_START'){
      _leftScale = 0.95;
      //getIt.get<SoundManager>().playSectionName(sectionIdName);

    }else if(pressInfo == 'LP_END'){
      _leftScale = 1;
    }else if(pressInfo == 'CANCEL'){
      _leftScale = 1;
    }
    notifyListeners();
  }
  pressDetailsRight(String pressInfo)async{
    //print(pressInfo);
    if(pressInfo == 'DOWN'){
      rightScale = 0.95;
      getIt.get<SoundManager>().playTap();
      notifyListeners();

    }else if(pressInfo == 'UP'){
      await Future.delayed(Duration(milliseconds: 50));
      rightScale = 1;
    }else if(pressInfo == 'LP_START'){
      rightScale = 0.95;
      //getIt.get<SoundManager>().playSectionName(sectionIdName);

    }else if(pressInfo == 'LP_END'){
      rightScale = 1;
    }else if(pressInfo == 'CANCEL'){
      rightScale = 1;
    }
    notifyListeners();
  }
  pressDetailsShuffle(String pressInfo)async{
    //print(pressInfo);
    if(pressInfo == 'DOWN'){
      shuffleScale = 0.95;
      getIt.get<SoundManager>().playTap();
      notifyListeners();

    }else if(pressInfo == 'UP'){
      await Future.delayed(Duration(milliseconds: 50));
      shuffleScale = 1;
    }else if(pressInfo == 'LP_START'){
      shuffleScale = 0.95;
      //getIt.get<SoundManager>().playSectionName(sectionIdName);

    }else if(pressInfo == 'LP_END'){
      shuffleScale = 1;
    }else if(pressInfo == 'CANCEL'){
      shuffleScale = 1;
    }
    notifyListeners();
  }
  pressDetailsStartQuiz(String pressInfo)async{
    //print(pressInfo);
    if(pressInfo == 'DOWN'){
      _startQuizScale = 0.95;
      getIt.get<SoundManager>().playTap();
      notifyListeners();

    }else if(pressInfo == 'UP'){
      await Future.delayed(Duration(milliseconds: 50));
      _startQuizScale = 1;
    }else if(pressInfo == 'LP_START'){
      _startQuizScale = 0.95;
      //getIt.get<SoundManager>().playSectionName(sectionIdName);

    }else if(pressInfo == 'LP_END'){
      _startQuizScale = 1;
    }else if(pressInfo == 'CANCEL'){
      _startQuizScale = 1;
    }
    notifyListeners();
  }
  pressDetails(String pressInfo)async{
    //print(pressInfo);
    if(pressInfo == 'DOWN'){
      _leftScale = 0.95;
      getIt.get<SoundManager>().playTap();
      notifyListeners();

    }else if(pressInfo == 'UP'){
      await Future.delayed(Duration(milliseconds: 50));
      _leftScale = 1;
    }else if(pressInfo == 'LP_START'){
      _leftScale = 0.95;
      //getIt.get<SoundManager>().playSectionName(sectionIdName);

    }else if(pressInfo == 'LP_END'){
      _leftScale = 1;
    }else if(pressInfo == 'CANCEL'){
      _leftScale = 1;
    }
    notifyListeners();
  }

  playSound(SectionDataModel sectionDataModel,String languageCode){
    getIt.get<SoundManager>().playItemLocal(sectionDataModel.audio+languageCode+'/names/${sectionDataModel.name}.wav');
  }
  stopSound(){
    getIt.get<SoundManager>().stopItemLocal();
  }
}