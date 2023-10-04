import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto/bloc/cafeterias_bloc.dart';
import 'package:proyecto/pages/Cafeterias/cafeteria_element.dart';
import 'package:proyecto/pages/Cafeterias/cafeterias_list.dart';
import 'package:proyecto/pages/Cafeterias/menu.dart';

class CafeteriasPage extends StatelessWidget {
  const CafeteriasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CafeteriasBloc, CafeteriasState>(
      builder: (context, state) {
        if(state is CafeteriasSuccessState)
          return CafeteriasList(cafeterias: state.cafeteriasList, query: state.query);
        else if(state is SelectCafeteriaState)
          return CafeteriaElement(cafeteria: state.cafeteria);
        else if(state is ViewMenuState)
          return Menu(cafeteria: state.cafeteria,);
        else if(state is CafeteriasLoadingState)
          return Container();
        else if(state is CafeteriasErrorState)
          return Container();
        else 
          return Container();
      },
    );
  }
}