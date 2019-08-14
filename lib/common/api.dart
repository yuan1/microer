import 'package:http/http.dart' as http;

const _client_id = '384854747';
const _redirect_uri = 'https://javayuan.cn/microer.html';
const _client_secret = '16a73d2c899b47bc0062065603b7921c';

// 获取授权 https://open.weibo.com/wiki/index.php?title=Oauth2/access_token&action=edit&redlink=1
Future<http.Response> oauth2AccessToken(String code) async {
  var response =
      await http.post('https://api.weibo.com/oauth2/access_token', body: {
    'client_id': _client_id,
    'client_secret': _client_secret,
    'grant_type': 'authorization_code',
    'code': code,
    'redirect_uri': _redirect_uri
  });
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
  return response;
}

// 授权查询 https://open.weibo.com/wiki/Oauth2/get_token_info
Future<http.Response> oauth2GetTokenInfo(String token) async {
  var response = await http.post('https://api.weibo.com/oauth2/get_token_info',
      body: {'access_token': token});
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
  return response;
}

// 根据用户ID获取用户信息 https://open.weibo.com/wiki/2/users/show
Future<http.Response> usersShow(String token, num id) async {
  var response = await http.get('https://api.weibo.com/2/users/show.json?access_token=$token&uid=$id');
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
  return response;
}
