

class JWTToken {
  String idToken;

  JWTToken({this.idToken});

  JWTToken.fromJson(Map<String, dynamic> json) {
    idToken = json['id_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_token'] = this.idToken;
    return data;
  }
}
