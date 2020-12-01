import 'package:flutter/cupertino.dart';

class HomePageManageModel extends ChangeNotifier{

  bool _isOpenLanguageWidget = false;

  bool get isOpenLanguageWidget => _isOpenLanguageWidget;

  set isOpenLanguageWidget(bool value) {
    _isOpenLanguageWidget = value;
    notifyListeners();
  }
}