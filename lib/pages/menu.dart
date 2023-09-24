import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/main_provider.dart';

class Menu extends StatelessWidget {
  const Menu({
    super.key,
    required this.cafe,
  });
  final Map<String, dynamic> cafe;

  @override
  Widget build(BuildContext context) {
    TextEditingController commentController =
        context.watch<MainProvider>().foodComment;
    rateTaste(double rating) {
      context.read<MainProvider>().rateTaste(rating);
    }

    ratePrice(double rating) {
      context.read<MainProvider>().ratePrice(rating);
    }

    pushRating() {
      context.read<MainProvider>().pushFoodRating();
    }

    showComment(Map<String, dynamic> food) {
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
                Text("Calificar platillo ${food['title']}"),
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
        title: Text("Menu de ${cafe['title']}"),
      ),
      body: Center(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: cafe["foods"].length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => showComment(cafe["foods"][index]),
              //estrellas de favorito
              child: ListTile(
                leading: IconButton(
                  icon: Icon(Icons.favorite_border),
                  color: Colors.red,
                  onPressed: () {
                    context
                        .read<MainProvider>()
                        .addToFavorite(cafe["foods"][index]["id"].toString());
                  },
                ),
                title: Text(cafe["foods"][index]["title"]),
                trailing: Text("\$ ${cafe["foods"][index]["price"]}"),
              ),
            );
          },
        ),
      ),
    );
  }
}
