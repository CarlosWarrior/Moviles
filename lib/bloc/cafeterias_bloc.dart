import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:proyecto/models/cafeteria.dart';

part 'cafeterias_event.dart';
part 'cafeterias_state.dart';

String cafeteriasUrl = "https://us-west1-appsmoviles-proyecto.cloudfunctions.net/cafeterias";
class CafeteriasBloc extends Bloc<CafeteriasEvent, CafeteriasState> {
  CafeteriasBloc() : super(CafeteriasInitial()) {
    on<GetCafeteriasEvent>(_getCafeterias);
    on<SearchCafeteriasEvent>(_searchCafeterias);
    on<SelectCafeteriasEvent>(_selectCafeteria);
    on<ViewMenuEvent>(_viewMenu);
  }

  List<Cafeteria> _cafeterias = [];
  Cafeteria? _cafeteria = null;
  void setCafeteria(Cafeteria value) => _cafeteria = value;
  bool _contains(Cafeteria cafe) {
    return cafe.title
        .toString()
        .toLowerCase()
        .contains(_query.text.toLowerCase());
  }
  TextEditingController _query = TextEditingController();

  double _foodTasteRating = 0.0;
  double _foodPriceRating = 0.0;
  TextEditingController foodComment = TextEditingController();
  rateTaste(double rating) {
    _foodTasteRating = rating;
  }
  ratePrice(double rating) {
    _foodPriceRating = rating;
  }
  pushFoodRating() {
    print(
        "${foodComment.text} , ${_foodTasteRating.toString()}, ${_foodPriceRating.toString()}");
    _foodTasteRating = 0.0;
    _foodPriceRating = 0.0;
  }


  Future<void> _getCafeterias(GetCafeteriasEvent event, Emitter emit) async {
    emit(CafeteriasLoadingState());
    var res = await get(Uri.parse(cafeteriasUrl));
    if(res.statusCode == 200){
      _cafeterias = (jsonDecode(res.body) as List).map((e) => Cafeteria.fromMap(e)).toList();
    }
    emit(CafeteriasSuccessState(query: _query, cafeteriasList: _cafeterias.where(_contains).toList()));
  }

  void _searchCafeterias(SearchCafeteriasEvent event, Emitter emit){
    emit(CafeteriasSuccessState(query: _query, cafeteriasList: _cafeterias.where(_contains).toList()));
  }

  void _selectCafeteria(SelectCafeteriasEvent event, Emitter emit){
    emit(SelectCafeteriaState(cafeteria: _cafeteria!));
  }

  void _viewMenu(ViewMenuEvent event, Emitter emit){
    emit(ViewMenuState(cafeteria: _cafeteria!));
  }
}
