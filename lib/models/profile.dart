class Profile {
  String token;
  String code;
  String uid;
  var theme;

  Profile(this.token, this.code, this.uid, this.theme);


  Profile.fromJson(Map<String, dynamic> json)
      : token = json['token'],
        code = json['code'],
        uid = json['uid'],
        theme = json['theme'];

  Map<String, dynamic> toJson() => {
        'token': token,
        'code': code,
        'uid': uid,
        'theme': theme,
      };

  @override
  String toString() {
    return 'Profile{token: $token, code: $code, uid: $uid, theme: $theme}';
  }

}
