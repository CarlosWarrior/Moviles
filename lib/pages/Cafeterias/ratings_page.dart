import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto/bloc/cafeterias/cafeterias_bloc.dart';
import 'package:proyecto/components/loading.dart';
import 'package:proyecto/models/cafeteria.dart';
import 'package:proyecto/pages/Cafeterias/ratings.dart';


class RatingsPage extends StatelessWidget {
  final Cafeteria cafeteria;
  const RatingsPage({required this.cafeteria, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CafeteriasBloc, CafeteriasState>(
      builder: (context, state) {
        if (state is RatingsSuccessState)
          return Ratings(ratings: state.ratingList.where((element) => element.cafeteria == cafeteria.id).toList(), title: state.title);
        else if (state is RatingsLoadingState)
          return Loading();
        else if (state is RatingsErrorState)
          return Loading();
        else
          return Loading();
      },
    );
  }
}