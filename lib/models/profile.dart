class Profile {

  String token;
  String code;
  String uid;
  int theme;

  Profile.fromJsonMap(Map<String, dynamic> map):
        token = map["token"],
        code = map["code"],
        uid = map["uid"],
        theme = map["theme"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = token;
    data['code'] = code;
    data['uid'] = uid;
    data['theme'] = theme;
    return data;
  }

  @override
  String toString() {
    return 'Profile{token: $token, code: $code, uid: $uid, theme: $theme}';
  }

}
