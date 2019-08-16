import 'package:dio/dio.dart';

import 'http.dart';
const _client_id = '384854747';
const _redirect_uri = 'https://javayuan.cn/microer.html';
const _client_secret = '16a73d2c899b47bc0062065603b7921c';


// 获取授权 https://open.weibo.com/wiki/index.php?title=Oauth2/access_token&action=edit&redlink=1
Future<Response> oauth2AccessToken(String code) async {
  return await dio.post('/oauth2/access_token', data: {
    'client_id': _client_id,
    'client_secret': _client_secret,
    'grant_type': 'authorization_code',
    'code': code,
    'redirect_uri': _redirect_uri
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


