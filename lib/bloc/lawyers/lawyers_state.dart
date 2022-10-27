part of 'lawyers_bloc.dart';

@immutable
abstract class LawyersState {}

class LawyersInitial extends LawyersState {}

class LawyersLoading extends LawyersState {}

class LawyersFetched extends LawyersState {
  final List<Lawyer> lawyers;

  LawyersFetched({required this.lawyers});
}
