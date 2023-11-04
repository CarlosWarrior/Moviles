import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto/bloc/cafeterias_bloc.dart';
import 'package:proyecto/models/cafeteria.dart';
import 'package:proyecto/pages/Cafeterias/rating_form.dart';

class Menu extends StatelessWidget {
  final Cafeteria cafeteria;
  const Menu({
    required this.cafeteria,
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    addToFavorite() {}

    context.read<CafeteriasBloc>().requestPermissions();
    return WillPopScope(
      onWillPop: () {
        context.read<CafeteriasBloc>().add(SelectCafeteriasEvent());
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Menu de ${cafeteria.title}"),
        ),
        body: Center(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: cafeteria.foods!.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => RatingForm(food: cafeteria.foods![index],))),
                //estrellas de favorito
                child: ListTile(
                  leading: IconButton(
                    icon: Icon(Icons.favorite_border),
                    color: Colors.red,
                    onPressed: addToFavorite,
                  ),
                  title: Text(cafeteria.foods![index].title!),
                  trailing:
                      Text("\$ ${cafeteria.foods![index].price!.toString()}"),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

