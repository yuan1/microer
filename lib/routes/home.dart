import 'dart:async';

import 'package:flutter/material.dart';
import 'package:microer/common/api.dart' as api;
import 'package:microer/common/funs.dart';
import 'package:microer/common/global.dart';
import 'package:microer/common/logger.dart';
import 'package:microer/common/notifier.dart';
import 'package:microer/models/profile.dart';
import 'package:microer/models/user.dart';
import 'package:provider/provider.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';


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
  int _selectedIndex = 0;

  @override
  initState() {
    super.initState();
    checkToken();
    initPlatformStateForUriUniLinks();
  }

  @override
  dispose() {
    if (_sub != null) _sub.cancel();
    super.dispose();
  }

  // todo check error
  void checkToken(){
    print('check');
    api.oauth2GetTokenInfo().then((res){
      print('res');
      Global.isLogin = true;
    }).catchError((error){
      print('check error');
      Global.profile = Profile.fromJsonMap({});
      Global.user = User.fromJsonMap({});
      Global.isLogin= false;
      Global.saveProfile();
    });
  }

  void _initUser() {
    api.usersShow(Global.profile.uid).then((res) {
      if (res.statusCode == 200) {
        Map userMap = res.data;
        print(userMap);
      }
    });
  }

  initPlatformStateForUriUniLinks() async {
    _sub = getUriLinksStream().listen((Uri uri) {
      var code = uri?.queryParameters['code'];
      if (code != null) {
        logger.d('got code $code ');
        Global.profile.code = code;
        _initAccessToken();
      }
      closeWebView();
    }, onError: (err) {
      logger.e('got err: $err');
    });
  }

  // 获取高级授权
  void _initAccessToken() {
    showToast('开始获取高级授权');
    // 调取接口获取token
    showLoading(context);
    api.oauth2AccessToken(Global.profile.code).then((res) {
      Navigator.pop(context);
      if (res.statusCode == 200) {
        showToast('高级授权获取成功');
        var body = res.data;
        var token = body['access_token'];
        var uid = body['uid'];
        Global.profile.token = token;
        Global.profile.uid = uid;
        logger.d(Global.profile);
        Global.saveProfile();
      } else {
        showToast('高级授权获取失败,请重新授权, ${res.statusCode}');
      }
    });
  }

  // 打开授权页面
  void _launchOAuth2AuthorizeURL() async {
    var url =
        'https://api.weibo.com/oauth2/authorize?client_id=${Global.clientId}&redirect_uri=${Global.redirectUri}';
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _onItemTapped(int index) {
    showToast('test');
    setState(() {
      _selectedIndex = index;
    });
  }

  void openDrawer(){
    _scaffoldKey.currentState.openDrawer();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: new IconButton(
            icon: new Icon(Icons.menu),
            tooltip: 'Navigation menu',
            onPressed:openDrawer),
        title: Text(widget.title),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.search),
            tooltip: 'Search',
            onPressed: () => Navigator.pushNamed(context, "themes"),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Business'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('School'),
          ),
        ],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'hello world: $_selectedIndex',
            ),
            Text(
              'huahua',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      drawer: MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: ThemeModel()),
          ],
          child: Consumer<ThemeModel>(
            builder:
                (BuildContext context, ThemeModel themeModel, Widget child) {
              return Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    DrawerHeader(
                      child: Text('Drawer Header'),
                      decoration: BoxDecoration(color: themeModel.theme),
                    ),
                    ListTile(
                      title: Text('Item 1'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text('Item 2'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            },
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: _launchOAuth2AuthorizeURL,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
