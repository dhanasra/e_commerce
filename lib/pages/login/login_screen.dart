import 'package:e_commerce/app/app.dart';
import 'package:e_commerce/app/app_routes.dart';
import 'package:e_commerce/bloc/auth/auth_bloc.dart';
import 'package:e_commerce/pages/login/login_view_model.dart';
import 'package:e_commerce/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginViewModel viewModel;

  @override
  void initState() {
    viewModel = LoginViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (_,state){
        if(state is LoginSuccess){
          const App().setNavigation(context, AppRoutes.home);
        }
      },
      child: Scaffold(
          body: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 50),
                child: Form(
                    key: viewModel.formKey,
                    child: LoginFields(viewModel: viewModel)
                ),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                    onPressed: (){
                      if(viewModel.formKey.currentState!.validate()){
                        context.read<AuthBloc>().add(Login(
                            email: viewModel.emailController.text,
                            password: viewModel.passwordController.text
                        ));
                      }
                    },
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        minimumSize: MaterialStateProperty.all(const Size(double.infinity, 50)),
                        shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero
                        ))
                    ),
                    child: const Text(
                      "LOGIN",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600
                      ),
                    )
                ),
              )
            ],
          )
      ),
    );
  }
}

class LoginFields extends StatelessWidget {
  final LoginViewModel viewModel;
  const LoginFields({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: Image.asset("${appAssets}logo.png", height: 200,),
        ),
        
        const Text("Welcome User", style: TextStyle(
            color: text,
            fontSize: 28,
            fontWeight: FontWeight.w600
        ),),

        const SizedBox(height: 8,),

        const Text("Enter your details to login to your account", style: TextStyle(
          color: promptColor,
          fontSize: 14,
          fontWeight: FontWeight.w600
        ),),

        const SizedBox(height: 32,),
        
        TextFormField(
          keyboardType: TextInputType.phone,
          autofocus: true,
          validator: (value){
            return value!=null && value.isEmpty
                ? "Email Id is required"
                : null;
          },
          onChanged: (val){
            viewModel.formKey.currentState?.validate();
          },
          decoration: const InputDecoration(
            hintText: "Enter Username / Email ID",
            prefixIcon: Icon(Icons.person)
          ),
          controller: viewModel.emailController,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600
          ),
        ),

        const SizedBox(height: 24,),

        ValueListenableBuilder(
            valueListenable: viewModel.passwordViewState,
            builder: (_,__,___){
              return TextFormField(
                keyboardType: TextInputType.phone,
                autofocus: true,
                onChanged: (val){
                  viewModel.formKey.currentState?.validate();
                },
                validator: (value){
                  return value!=null && value.isEmpty
                      ? "Password is required"
                      : null;
                },
                decoration: InputDecoration(
                  hintText: "Password",
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: GestureDetector(
                    onTap: ()=>viewModel.passwordViewState.value=!viewModel.passwordViewState.value,
                    child: viewModel.passwordViewState.value
                        ? const Icon(Icons.remove_red_eye) : const Icon(Icons.remove_red_eye_outlined),
                  )
                ),
                obscureText: viewModel.passwordViewState.value,
                controller: viewModel.passwordController,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600
                ),
              );
            }
        ),
        
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {  },
            child: const Text("Forgot Password ?", style: TextStyle(
              color: primary
            ),),),
        ),


      ],
    );
  }
}
