
import 'package:bloc/bloc.dart';
import 'package:e_commerce/db/model/lawyer.dart';
import 'package:e_commerce/network/api_client.dart';
import 'package:e_commerce/network/service/laywers_service.dart';
import 'package:meta/meta.dart';

part 'lawyers_event.dart';
part 'lawyers_state.dart';

class LawyersBloc extends Bloc<LawyersEvent, LawyersState> {
  LawyersBloc() : super(LawyersInitial()) {
    on<GetLawyers>(onGetLawyers);
  }

  void onGetLawyers(GetLawyers event, Emitter emit) async{
    emit(LawyersLoading());

    final result = await LawyerService(apiClient: ApiClient().init()).getLawyersList();
    List<Lawyer> lawyers = Lawyer.getLawyersList(result["data"]);

    emit(LawyersFetched(lawyers: lawyers));
  }
}
