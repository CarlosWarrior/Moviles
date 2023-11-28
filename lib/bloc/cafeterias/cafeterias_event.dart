part of 'cafeterias_bloc.dart';

@immutable
sealed class CafeteriasEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetCafeteriasEvent extends CafeteriasEvent {}

class GetRatingsEvent extends CafeteriasEvent {}

class SearchCafeteriasEvent extends CafeteriasEvent {
  final String query;

  SearchCafeteriasEvent({required this.query});

  @override
  List<Object> get props => [query];
}

class SelectCafeteriasEvent extends CafeteriasEvent {}

class ViewMenuEvent extends CafeteriasEvent {}
