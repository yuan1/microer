import 'dart:async';

import 'package:flutter/material.dart';
import 'package:microer/common/api.dart' as api;
import 'package:microer/common/funs.dart';
import 'package:microer/common/global.dart';
import 'package:microer/common/logger.dart';
import 'package:microer/common/notifier.dart';
import 'package:microer/models/profile.dart';
import 'package:microer/models/user.dart';
import 'package:microer/widgets/status_list.dart';
import 'package:provider/provider.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  StreamSubscription _sub;
  int _selectedIndex = 0;

  String name = Global.user?.name ?? "hello world";

  String imgUrl = Global.user?.profileImageUrl ?? "https://avatars1.githubusercontent.com/u/17492753?s=460&v=4";

  @override
  initState() {
    super.initState();
    initPlatformStateForUriUniLinks();
    checkToken();
  }

  @override
  dispose() {
    if (_sub != null) _sub.cancel();
    super.dispose();
  }

  void checkToken() {
    api.oauth2GetTokenInfo().then((res) {
      showToast('授权正常！');
      Global.isLogin = true;
      // 获取用户信息
      _initUser();
    }).catchError((error) {
      showToast('授权过期！');
      Global.profile = Profile.fromJsonMap({});
      Global.user = User.fromJsonMap({});
      Global.isLogin = false;
      Global.saveProfile();
      Global.saveUser();
    });
  }

  void _initUser() {
    showLoading(context, '正在获取用户信息');
    api.usersShow(Global.profile.uid).then((res) {
      Global.user = User.fromJsonMap(res.data);
      showToast('欢迎，${Global.user.name}！');
      Global.saveUser();
      Navigator.pop(context);
      setState(() {
        name = Global.user.name;
      });
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
        // 获取用户信息
        _initUser();
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

  void openDrawer() {
    _scaffoldKey.currentState.openDrawer();
  }

  void _selectShowStatus() {
    showModalBottomSheet(
      context: context,
      builder:  (_) => Container(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            ListTile(
              title: Text('全部微博'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('我的微博'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: new IconButton(
            icon: new Icon(Icons.menu),
            onPressed: openDrawer),
        title: Row(
          children: <Widget>[
            Text(widget.title),
            new IconButton(
              icon: new Icon(Icons.arrow_drop_down),
              onPressed: () => _selectShowStatus(),
            ),
          ],
        ),
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
            icon: Icon(Icons.timeline),
            title: Text('timeline'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_answer),
            title: Text('question_answer'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.whatshot),
            title: Text('whatshot'),
          ),
        ],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: StatusList(),
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
                      child: Image(
                        image: NetworkImage(imgUrl),
                        width: 100.0,
                      ),
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
