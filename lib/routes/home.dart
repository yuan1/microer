import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:microer/models/user.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:microer/common/api.dart' as api;

const _client_id = '384854747';
const _redirect_uri = 'https://javayuan.cn/microer.html';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  StreamSubscription _sub;
  SharedPreferences _prefs;
  String _code;
  String _token;
  num _id;

  @override
  initState() {
    super.initState();
    initPlatformState();
    _initInfo();
  }

  @override
  dispose() {
    if (_sub != null) _sub.cancel();
    super.dispose();
  }

  void _initInfo() async {
    _prefs = await SharedPreferences.getInstance();
    _code = _prefs.getString('code') ?? null;
    _token = _prefs.getString('token') ?? null;
    _id = _prefs.getInt('id') ?? 0;
    if (_token != null) {
      _initTokenInfo();
      _initUser();
    }
    print(_code);
    print(_token);
    print(_id);
  }

  void _initUser() {
    api.usersShow(_token,_id).then((res) {
      if (res.statusCode == 200) {
        Map userMap = json.decode(res.body);
        var user = new User.fromJson(userMap);
        print(user.toJson());
      }
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    await initPlatformStateForUriUniLinks();
  }

  initPlatformStateForUriUniLinks() async {
    // Attach a listener to the Uri links stream
    _sub = getUriLinksStream().listen((Uri uri) {
      print('got uri: ${uri?.queryParameters}');
      var code = uri?.queryParameters['code'];
      if (code != null) {
        print('got code is $code');
        _code = code;
        _prefs.setString('code', code);
        _initAccessToken();
      }
      closeWebView();
      print('closed web view...');
    }, onError: (err) {
      print('got err: $err');
    });
  }

  // 显示提示信息
  void _displaySnackBar(String text) {
    final snackBar = SnackBar(
      content: Text(text),
      duration: Duration(milliseconds: 500),
    );
    _scaffoldKey.currentState.showSnackBar(
      snackBar,
    );
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, //点击遮罩不关闭对话框
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircularProgressIndicator(),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Text("正在加载，请稍后..."),
              )
            ],
          ),
        );
      },
    );
  }

  // 获取高级授权
  void _initAccessToken() {
    _displaySnackBar('开始获取高级授权');
    // 调取接口获取token
    _showLoadingDialog();
    api.oauth2AccessToken(_code).then((res) {
      Navigator.pop(context);
      if (res.statusCode == 200) {
        _displaySnackBar('高级授权获取成功');
        var body = jsonDecode(res.body);
        var token = body['access_token'];
        print('token: $token');
        _token = token;
        _prefs.setString('token', token);
        _initTokenInfo();
      } else {
        _displaySnackBar('高级授权获取失败,请重新授权, ${res.statusCode}');
      }
    });
  }

  void _initTokenInfo() {
    api.oauth2GetTokenInfo(_token).then((res) {
      if (res.statusCode == 200) {
        var body = jsonDecode(res.body);
        _id = body['uid'] ?? 0;
        _prefs.setInt('id', _id);
        print(_id);
      }
    });
  }

  // 打开授权页面
  void _launchOAuth2AuthorizeURL() async {
    const url =
        'https://api.weibo.com/oauth2/authorize?client_id=$_client_id&redirect_uri=$_redirect_uri';
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: new IconButton(
            icon: new Icon(Icons.menu),
            tooltip: 'Navigation menu',
            onPressed: () => _displaySnackBar('test')),
        title: Text(widget.title),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.search),
            tooltip: 'Search',
            onPressed: () => _showLoadingDialog(),
          ),
        ],
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'hello world:',
            ),
            Text(
              '$_client_id',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _launchOAuth2AuthorizeURL,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
