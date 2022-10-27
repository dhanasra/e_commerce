import 'package:flutter/material.dart';

class LoginViewModel{
  static late LoginViewModel _instance;
  factory LoginViewModel() {
    _instance = LoginViewModel._internal();
    return _instance;
  }

  LoginViewModel._internal(){
    init();
  }

  late TextEditingController emailController;
  late TextEditingController passwordController;

  late ValueNotifier<bool> passwordViewState;
  late GlobalKey<FormState> formKey;

  void init(){
    formKey = GlobalKey<FormState>();
    passwordViewState = ValueNotifier(true);

    emailController = TextEditingController();
    passwordController = TextEditingController();
  }
}