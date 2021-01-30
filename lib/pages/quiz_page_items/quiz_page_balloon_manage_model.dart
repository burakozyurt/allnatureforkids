import 'package:flutter/cupertino.dart';

class QuizPageBalloonManageModel extends ChangeNotifier{
  String _riveName = '0';

  QuizPageBalloonManageModel(this._riveName);

  String get riveName => _riveName;

  set riveName(String value) {
    _riveName = value;
    notifyListeners();
  }
}