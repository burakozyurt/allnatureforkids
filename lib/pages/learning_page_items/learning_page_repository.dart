import 'dart:convert';
import 'dart:io';

import 'package:allnatureforkids/models/section_data_model.dart';
import 'package:flutter/services.dart';

class LearningPageRepository {
  LearningPageRepository();

  Future<List<SectionDataModel>> getSectionDataModelList(String sectionIdName) async {
    String data = await rootBundle.loadString('assets/sections_data/${sectionIdName}.json');
    final parsed = json.decode(data).cast<Map<String, dynamic>>();
    List<SectionDataModel> sectionDataModelList =
        parsed.map<SectionDataModel>((data) => SectionDataModel.fromJson(data)).toList();

    return sectionDataModelList;
  }
}
