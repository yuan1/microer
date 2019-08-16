import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:microer/models/profile.dart';
import 'package:microer/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'http.dart' as http;
import 'api.dart' as api;
import 'logger.dart';

const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red,
  Colors.pink
];

class Global {
  static SharedPreferences _prefs;
  static Profile profile;
  static User user;
  static bool isLogin;

  // 可选的主题列表
  static List<MaterialColor> get themes => _themes;

  // 是否为release版
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  //初始化全局信息，会在APP启动时执行
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
    var _profile = _prefs.getString("profile");
    if (_profile != null) {
      profile = Profile.fromJson(jsonDecode(_profile));
    } else {
      profile = Profile.fromJson({});
    }
    logger.d(profile);

    var _user = _prefs.getString("user");
    if(_user!=null){
      user = User.fromJson(jsonDecode(_user));
    }
    logger.d(user);
    // 初始化http
   http.init();
    // 检测token 是否过期
  }
  // 持久化Profile信息
  static saveProfile() =>
      _prefs.setString("profile", jsonEncode(profile.toJson()));
  // 持久化User信息
  static saveUser() =>
      _prefs.setString("user", jsonEncode(user.toJson()));
}
