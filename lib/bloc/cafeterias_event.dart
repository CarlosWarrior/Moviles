part of 'cafeterias_bloc.dart';

@immutable
sealed class CafeteriasEvent {}

class GetCafeteriasEvent extends CafeteriasEvent{}

class SearchCafeteriasEvent extends CafeteriasEvent{}

class SelectCafeteriasEvent extends CafeteriasEvent{}

class ViewMenuEvent extends CafeteriasEvent{}