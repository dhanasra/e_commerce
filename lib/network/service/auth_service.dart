import 'package:dio/dio.dart';

class AuthService{

  Dio apiClient;
  AuthService({required this.apiClient});

  Future<dynamic> signInWithEmail({required String email, required String password})async{
    var data = {
      "phone_no" : email,
      "password" : password
    };
    Response response = await apiClient.post('/auth/login',data: data);
    return response.data;
  }


}