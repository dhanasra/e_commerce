import 'package:e_commerce/bloc/auth/auth_bloc.dart';
import 'package:e_commerce/bloc/lawyers/lawyers_bloc.dart';
import 'package:e_commerce/pages/home/home_screen.dart';
import 'package:e_commerce/pages/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoutes {

  static const String login = 'auth';
  static const String home = 'home';

  Route getRoutes(RouteSettings routeSettings) {
    return MaterialPageRoute(
        settings: routeSettings,
        builder: (BuildContext context) => getWidget(routeSettings.name));
  }

  getWidget(String? appRouteName){
    switch(appRouteName) {
      case AppRoutes.home : return BlocProvider(
        create: (_)=>LawyersBloc()..add(GetLawyers()),
        child: const HomeScreen(),
      );
      case AppRoutes.login : return BlocProvider(
        create: (_)=>AuthBloc(),
        child: const LoginScreen(),
      );

      default: return Container();
    }
  }

}