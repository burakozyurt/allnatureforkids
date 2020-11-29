import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MainModel extends ChangeNotifier {
  String _preferredLanguageCode;

  String get preferredLanguageCode => _preferredLanguageCode;

  set preferredLanguageCode(String value) {
    _preferredLanguageCode = value;
    notifyListeners();
  }

  fetchData() async {
    FlutterSecureStorage flutterSecureStorage = new FlutterSecureStorage();
    String langCode = await flutterSecureStorage.read(
      key: 'langCode',
    );
    if (langCode == null) {
      preferredLanguageCode = 'tr';
    } else {
      preferredLanguageCode = langCode;
    }
  }

  MainModel() {
    fetchData();
  }
}
