import 'package:flutter/material.dart';
import 'package:microer/routes/home.dart';
import 'package:provider/provider.dart';

import 'common/global.dart';
import 'common/notifier.dart';
import 'routes/theme.dart';
import 'common/http.dart' as http;

void main() => Global.init().then((e) => runApp(MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: ThemeModel()),
        ],
        child: Consumer<ThemeModel>(builder:
            (BuildContext context, ThemeModel themeModel, Widget child) {
          return MaterialApp(
            title: 'Microer',
            theme: ThemeData(primarySwatch: themeModel.theme),
            home: HomePage(title: 'Microer Home'),
            // 注册路由表
            routes: <String, WidgetBuilder>{
              "themes": (context) => ThemePage(),
            },
          );
        }));
  }
}
