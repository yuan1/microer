import 'package:dio/dio.dart';

import 'global.dart';
import 'http.dart';


// 获取授权 https://open.weibo.com/wiki/index.php?title=Oauth2/access_token&action=edit&redlink=1
Future<Response> oauth2AccessToken(String code) async {
  return await dio.post('/oauth2/access_token', data: {
    'client_id': Global.clientId,
    'client_secret': Global.clientSecret,
    'grant_type': 'authorization_code',
    'code': code,
    'redirect_uri': Global.redirectUri
  });
}

// 授权查询 https://open.weibo.com/wiki/Oauth2/get_token_info
Future<Response> oauth2GetTokenInfo() async {
  return await dio.post('/oauth2/get_token_info');
}

// 根据用户ID获取用户信息 https://open.weibo.com/wiki/2/users/show
Future<Response> usersShow(String id) async {
  return await dio.get('/2/users/show.json', queryParameters: {'uid': id});
}
Future<Response> homeTimeline() async {
  return await dio.get('/2/statuses/home_timeline.json', queryParameters: {'count': 5});
}


