import 'dart:io';

import 'package:e_commerce/bloc/splash/splash_bloc.dart';
import 'package:e_commerce/pages/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_routes.dart';
import 'app_style.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getMaterialApp(
        widget: BlocProvider(
            create: (_)=>SplashBloc()..add(CheckAuth()),
            child: const SplashScreen(),
        ),
        title: 'Launch',
        buildContext: context);
  }

  AppRoutes getAppRoutes() {
    return AppRoutes();
  }

  Widget getMaterialApp({required Widget widget, required String title, required BuildContext buildContext}) {
    return MaterialApp(
        title: title,
        debugShowCheckedModeBanner: false,
        theme: AppStyle.lightTheme(buildContext),
        home: widget,
        onGenerateRoute: getAppRoutes().getRoutes
    );
  }

  Future<dynamic> setNavigation(BuildContext context, String appRouteName,{dynamic args}) async {
    Future.delayed(const Duration(milliseconds: 10), () async {
      final info = await Navigator.pushNamed( context, appRouteName, arguments : args);
      return info;
    });
  }

  Future<dynamic> setClosedNavigation(BuildContext context, String appRouteName, String removeRoutName, {dynamic args}) async {
    Future.delayed(const Duration(milliseconds: 10), () async {
      final info = await Navigator.pushNamedAndRemoveUntil(
          context, appRouteName, ModalRoute.withName(removeRoutName),arguments : args);
      return info;
    });
  }

  void setBackNavigation(BuildContext context) {
    Navigator.pop(context, "true");
  }

  void closeApp() {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else {
      exit(0);
    }
  }
}
