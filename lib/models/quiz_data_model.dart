import 'dart:math';

import 'package:allnatureforkids/models/section_data_model.dart';

class QuizDataModel{
  List<SectionDataModel> optionList;
  SectionDataModel _answer;
  QuizDataModel({this.optionList,}){
    optionList.shuffle();
    optionList.shuffle();
    optionList.shuffle();
    int random = Random().nextInt(4);
    _answer = optionList[random];
  }

  // ignore: unnecessary_getters_setters
  SectionDataModel get answer => _answer;

  // ignore: unnecessary_getters_setters
  set answer(SectionDataModel value) {
    _answer = value;
  }


}