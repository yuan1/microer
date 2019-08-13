import 'package:http/http.dart';

const _client_id = '384854747';
const _redirect_uri = 'microer://javayuan.cn';
const _client_secret = '16a73d2c899b47bc0062065603b7921c';

Future<Response> oauth2Authorize() async {
  var response = await get('https://api.weibo.com/oauth2/authorize', headers: {
    'client_id': _client_id,
    'redirect_uri': _redirect_uri,
  });
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
  return response;
}

Future<Response> oauth2AccessToken(String code) async {
  var response = await post('https://api.weibo.com/oauth2/authorize', body: {
    'client_id': _client_id,
    'client_secret':_client_secret,
    'grant_type':{
      'redirect_uri': _redirect_uri,
      'code':code
    }
  });
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
  return response;

}
