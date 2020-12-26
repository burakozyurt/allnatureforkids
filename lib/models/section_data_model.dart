class SectionDataModel {
  String name;
  bool isLocal;
  String photo;
  String audio;
  LanguageName languageName;

  SectionDataModel(
      {this.name, this.isLocal, this.photo, this.audio, this.languageName});

  SectionDataModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    isLocal = json['isLocal'];
    photo = json['photo'];
    audio = json['audio'];
    languageName = json['languageName'] != null
        ? new LanguageName.fromJson(json['languageName'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['isLocal'] = this.isLocal;
    data['photo'] = this.photo;
    data['audio'] = this.audio;
    if (this.languageName != null) {
      data['languageName'] = this.languageName.toJson();
    }
    return data;
  }
}

class LanguageName {
  String tr;
  String en;

  LanguageName({this.tr, this.en});

  LanguageName.fromJson(Map<String, dynamic> json) {
    tr = json['tr'];
    en = json['en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tr'] = this.tr;
    data['en'] = this.en;
    return data;
  }

}