import 'package:allnatureforkids/locator.dart';
import 'package:allnatureforkids/models/quiz_data_model.dart';
import 'package:allnatureforkids/models/section_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:allnatureforkids/sound_manager/sound_manager.dart';

class QuizPageManageModel extends ChangeNotifier{

  List<QuizDataModel> defaultList;
  QuizDataModel _currentQuizDataModel;
  QuizDataModel _nextQuizDataModel;
  List<int> wrongAnswerItems = new List();
  QuizPageManageModel();
  List<QuizDataModel> correctList = new List();
  bool _correctVisibility = false;
  String _nameRive = '0';
  String _nextRive = '1';
  bool _onTapped = false;
  int _period = 0;

  int get period => _period;

  set period(int value) {
    _period = value;
    notifyListeners();
  }

  bool get onTapped => _onTapped;

  set onTapped(bool value) {
    _onTapped = value;
    notifyListeners();
  }

  String get nameRive => _nameRive;

  set nameRive(String value) {
    _nameRive = value;
    notifyListeners();
  }
  String get nextRive => _nextRive;

  set nextRive(String value) {
    _nextRive = value;
    notifyListeners();
  }

  fetchData(List<QuizDataModel> list){
    defaultList = list;
    _currentQuizDataModel = defaultList[0];
    _nextQuizDataModel = defaultList[correctList.length+1];
  }

  QuizDataModel get currentQuizDataModel => _currentQuizDataModel;

  set currentQuizDataModel(QuizDataModel value) {
    _currentQuizDataModel = value;
    notifyListeners();
  }
  bool get correctVisibility => _correctVisibility;

  set correctVisibility(bool value) {
    _correctVisibility = value;
    notifyListeners();
  }
  QuizDataModel get nextQuizDataModel => _nextQuizDataModel;

  set nextQuizDataModel(QuizDataModel value) {
    _nextQuizDataModel = value;
    notifyListeners();
  }

  addWrongAnswer(int i){
    wrongAnswerItems.add(i);
    notifyListeners();
  }
  addCorrectAnswer(QuizDataModel quizDataModel) async {
    correctList.add(quizDataModel);
    notifyListeners();
    resetVariables();

  }
  resetVariables(){
    wrongAnswerItems.clear();
    notifyListeners();
    if(correctList.length == 5 && period == 0){
      if(nameRive != '0'){
        playSuccess();
      }
      correctList.clear();
      _currentQuizDataModel = defaultList[correctList.length%5];
      _nextQuizDataModel = defaultList[correctList.length%5];
      period = 1;
    }else if(correctList.length == 4 && period == 1){

    }else{
      _currentQuizDataModel = defaultList[correctList.length%5];
      _nextQuizDataModel = defaultList[correctList.length%5];
      nameRive = correctList.length.toString();
      if(correctList.length == defaultList.length){
        nameRive = (defaultList.length + 1).toString();
      }
      if(nameRive != '0'){
        playSuccess();
      }
    }

    notifyListeners();

  }

  playSound(SectionDataModel sectionDataModel,String languageCode){
    getIt.get<SoundManager>().playItemLocal(sectionDataModel.audio+languageCode+'/names/${sectionDataModel.name}.wav',);
  }
  playCommon(String languageCode){
    getIt.get<SoundManager>().playItemLocal('environment/common/'+languageCode+'/exam/right/Brilliant.wav');
  }
  playWrong(String languageCode){
    getIt.get<SoundManager>().playItemLocal('environment/sound_effect/sound_wrong.wav');
  }

  playSuccess(){
    getIt.get<SoundManager>().playSuccess();
  }
  playQuestion(SectionDataModel sectionDataModel,String languageCode){
    getIt.get<SoundManager>().playItemLocal(sectionDataModel.questionAudio+languageCode+'/questions/${sectionDataModel.name}.wav');
  }
}