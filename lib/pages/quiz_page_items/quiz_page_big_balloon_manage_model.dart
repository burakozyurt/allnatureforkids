import 'package:flutter/cupertino.dart';

class QuizPageBigBalloonManageModel extends ChangeNotifier{
  String _riveName = '0';

  QuizPageBigBalloonManageModel(this._riveName);

  String get riveName => _riveName;

  set riveName(String value) {
    _riveName = value;
    notifyListeners();
  }
}