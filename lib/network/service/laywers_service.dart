import 'package:dio/dio.dart';

class LawyerService{

  Dio apiClient;
  LawyerService({required this.apiClient});

  Future<dynamic> getLawyersList()async{
    Response response = await apiClient.get('/lawyers/index');
    return response.data;
  }


}