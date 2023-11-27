import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto/bloc/cafeterias_bloc.dart';
import 'package:proyecto/components/loading.dart';
import 'package:proyecto/pages/Auth/ratings.dart';


class RatingsPage extends StatelessWidget {
  const RatingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CafeteriasBloc, CafeteriasState>(
      builder: (context, state) {
        if (state is RatingsSuccessState)
          return Ratings(ratings: state.ratingList, title: state.title);
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