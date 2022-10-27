import 'package:dio/dio.dart';

import '../db/local_db.dart';

class ApiClient {

  Dio init(){
    Dio dio = Dio();
    dio.interceptors.add(ApiInterceptors(dio: dio));
    dio.options.baseUrl = "http://80.211.233.121/blacklight/blacklight/public/api";
    return dio;
  }

}

class ApiInterceptors extends Interceptor {
  final Dio dio;
  ApiInterceptors({required this.dio});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async{

    final accessToken = await LocalStorage.getAccessToken();
    options.headers["Authorization"] = "Bearer $accessToken";
    options.headers["Content-Type"] = "application/json";

    return handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async{
    if(err.response?.statusCode==401){
      RequestOptions? requestOptions = err.response?.requestOptions;

      var rToken = await LocalStorage.getRefreshToken();

      if(rToken==null){
        return;
      }

      return;
    }else {
      return handler.next(err);
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async{
    if(response.statusCode==200){

      var data = response.data;

      if(data!=null && data.containsKey("access_token")){
        await LocalStorage.saveAccessToken(data["access_token"]);
      }

      return handler.next(response);
    }

  }

}