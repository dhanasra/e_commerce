import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce/network/api_client.dart';
import 'package:e_commerce/network/service/auth_service.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<Login>(onLogin);
  }

  void onLogin(Login event, Emitter emit) async{
    emit(LoginLoading());

    AuthService authService = AuthService(apiClient: ApiClient().init());

    dynamic result = await authService.signInWithEmail(email: event.email, password: event.password);

    print(result);

    emit(LoginSuccess());
  }
}
