import 'dart:convert';
import 'dart:io';

import 'package:allnatureforkids/models/quiz_data_model.dart';
import 'package:allnatureforkids/models/section_data_model.dart';
import 'package:flutter/services.dart';

class QuizPageRepository {
  QuizPageRepository();

  Future<List<SectionDataModel>> getSectionDataModelList(String sectionIdName) async {
    String data = await rootBundle.loadString('assets/sections_data/${sectionIdName}.json');
    final parsed = json.decode(data).cast<Map<String, dynamic>>();
    List<SectionDataModel> sectionDataModelList =
        parsed.map<SectionDataModel>((data) => SectionDataModel.fromJson(data)).toList();
    return sectionDataModelList.toList();
  }

  Future<List<QuizDataModel>> getQuizDataModelList(String sectionIdName, {int length = 5}) async {
    List<SectionDataModel> sectionDataModelList = await getSectionDataModelList(sectionIdName);
    sectionDataModelList.shuffle();
    List<QuizDataModel> quizDataModelList = new List();
    for (int i = 0; i < length; i++) {
      List<SectionDataModel> sectionDataModelListTemp = sectionDataModelList.toList();
      sectionDataModelListTemp.shuffle();
      sectionDataModelListTemp.shuffle();
      sectionDataModelListTemp.shuffle();
      QuizDataModel quizDataModel;
      List<SectionDataModel> optionList = sectionDataModelListTemp.toList().getRange(0, 4).toList();
      quizDataModel = new QuizDataModel(optionList: optionList);
      quizDataModelList.add(quizDataModel);
    }
    quizDataModelList.shuffle();
    quizDataModelList.shuffle();
    quizDataModelList.shuffle();
    return quizDataModelList;
  }
}
