part of 'cafeterias_bloc.dart';

@immutable
sealed class CafeteriasState extends Equatable {
  const CafeteriasState();

  @override
  List<Object> get props => [];
}

final class CafeteriasInitial extends CafeteriasState {}

final class CafeteriasLoadingState extends CafeteriasState {}

final class CafeteriasErrorState extends CafeteriasState {}

final class CafeteriasSuccessState extends CafeteriasState {
  final List<Cafeteria> cafeteriasList;
  CafeteriasSuccessState({required this.cafeteriasList});
  @override
  List<Object> get props => [cafeteriasList];
}

final class RatingsLoadingState extends CafeteriasState {}

final class RatingsErrorState extends CafeteriasState {}

final class RatingsSuccessState extends CafeteriasState {
  final List<Rating> ratingList;
  final String title;
  RatingsSuccessState({required this.ratingList, required this.title});
  @override
  List<Object> get props => [ratingList];
}



final class SelectCafeteriaState extends CafeteriasState {
  final Cafeteria cafeteria;
  SelectCafeteriaState({required this.cafeteria});
  @override
  List<Object> get props => [cafeteria];
}

final class ViewMenuState extends CafeteriasState {
  final Cafeteria cafeteria;
  ViewMenuState({required this.cafeteria});
  @override
  List<Object> get props => [cafeteria];
}
