import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto/bloc/cafeterias_bloc.dart';
import 'package:proyecto/components/loading.dart';
import 'package:proyecto/pages/Cafeterias/cafeterias_list.dart';

class CafeteriasPage extends StatelessWidget {
  const CafeteriasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CafeteriasBloc, CafeteriasState>(
      builder: (context, state) {
        if(state is CafeteriasSuccessState)
          return CafeteriasList(cafeterias: state.cafeteriasList, query: state.query);
        else if(state is CafeteriasLoadingState)
          return Loading();
        else if(state is CafeteriasErrorState)
          return Loading();
        else 
          return Loading();
      },
    );
  }
}