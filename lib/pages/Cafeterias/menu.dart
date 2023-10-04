import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:proyecto/bloc/cafeterias_bloc.dart';
import 'package:proyecto/models/cafeteria.dart';
import 'package:proyecto/models/food.dart';

class Menu extends StatelessWidget {
  final Cafeteria cafeteria;
  const Menu({
    required this.cafeteria,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController commentController = context.watch<CafeteriasBloc>().foodComment;
    rateTaste(double rating) {
      context.read<CafeteriasBloc>().rateTaste(rating);
    }

    ratePrice(double rating) {
      context.read<CafeteriasBloc>().ratePrice(rating);
    }

    pushRating() {
      context.read<CafeteriasBloc>().pushFoodRating();
    }


    addToFavorite() {
      
    }

    showComment(Food food) {
      return showDialog(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          addRating() {
            pushRating();
            Navigator.of(context).pop();
          }

          return AlertDialog(
            title: Row(
              children: [
                Text("Calificar platillo ${food.title}"),
              ],
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('¿Cuantas estrellas le das a este platillo?'),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Text("Sabor"),
                              RatingBar.builder(
                                initialRating: 0,
                                minRating: 1,
                                maxRating: 5,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: rateTaste,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text("Precio"),
                              RatingBar.builder(
                                initialRating: 0,
                                minRating: 1,
                                maxRating: 5,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: ratePrice,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  TextField(
                    minLines:
                        6, // any number you need (It works as the rows for the textarea)
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(hintText: "¿Algún comentario?"),
                    controller: commentController,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Calificar'),
                onPressed: addRating,
              ),
              TextButton(
                child: const Text('Cancelar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu de ${cafeteria.title}"),
        leading: IconButton(onPressed: () => context.read<CafeteriasBloc>().add(SelectCafeteriasEvent()), icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Center(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: cafeteria.foods!.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => showComment(cafeteria.foods![index]),
              //estrellas de favorito
              child: ListTile(
                leading: IconButton(
                  icon: Icon(Icons.favorite_border),
                  color: Colors.red,
                  onPressed: addToFavorite,
                ),
                title: Text(cafeteria.foods![index].title!),
                trailing: Text("\$ ${cafeteria.foods![index].price!.toString()}"),
              ),
            );
          },
        ),
      ),
    );
  }
}
