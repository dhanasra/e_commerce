
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<CheckAuth>(onCheckAuth);
  }

  void onCheckAuth(CheckAuth event, Emitter emit)async{
    emit(SplashLoading());

    await Future.delayed(const Duration(seconds: 2));

    emit(Login());
  }
}
