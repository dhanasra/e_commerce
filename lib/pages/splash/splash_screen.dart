import 'package:e_commerce/app/app.dart';
import 'package:e_commerce/app/app_routes.dart';
import 'package:e_commerce/bloc/splash/splash_bloc.dart';
import 'package:e_commerce/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
        listener: (_, state) {
          if (state is Login) {
            const App().setNavigation(context, AppRoutes.login);
          }
        },
        child: Scaffold(
          body: Center(
            child: Image.asset(
              "${appAssets}logo.png", width: 200, height: 200,),
          ),
        )
    );
  }
}
