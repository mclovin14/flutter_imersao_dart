
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/local_storage_keys.dart';

class AuthInterceptor extends Interceptor{
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final RequestOptions(:headers, :extra) = options;
    
    const String authHeaderKey = 'Authorization';
    headers.remove(authHeaderKey);
    if(extra case {'DIO_AUTH_KEY': true}){// nesta linha ocorre a mesma coisa de utilizar um containskey e verificar se a key tem o valor true
      final sp = await  SharedPreferences.getInstance();
      headers.addAll({
        authHeaderKey: 'Bearer ${sp.getString(LocalStorageKeys.accessToken)}'
      });
    }
    handler.next(options);

    super.onRequest(options, handler);
  }
}