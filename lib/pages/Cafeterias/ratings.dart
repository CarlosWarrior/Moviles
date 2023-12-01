import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:proyecto/bloc/cafeterias/cafeterias_bloc.dart';
import 'package:proyecto/models/rating.dart';

class Ratings extends StatelessWidget {
  final String title;
  final List<Rating> ratings;
  const Ratings({required this.ratings, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.read<CafeteriasBloc>().add(ViewMenuEvent());
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: ratings.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Add starts
                            Column(
                              children: [
                                Text(ratings[index].food!,
                                    textAlign: TextAlign.left,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(fontWeight: FontWeight.bold)),
                                Row(
                                  children: [
                                    Text("Precio ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.bold)),
                                    RatingBarIndicator(
                                      itemSize: 20,
                                      rating: ratings[index].price!,
                                      direction: Axis.horizontal,
                                      itemCount: 5,
                                      itemPadding:
                                          EdgeInsets.symmetric(horizontal: 4.0),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Sabor  ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.bold)),
                                    RatingBarIndicator(
                                      itemSize: 20,
                                      rating: ratings[index].taste!,
                                      direction: Axis.horizontal,
                                      itemCount: 5,
                                      itemPadding:
                                          EdgeInsets.symmetric(horizontal: 4.0),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Spacer(),
                            if (ratings[index].image != null &&
                                ratings[index].image != '')
                              InkWell(
                                  child: Image.network(
                                    ratings[index].image!,
                                    width: 100,
                                    height: 100,
                                  ),
                                  onTap: () => _dialogBuilder(
                                      context, ratings[index].image!)),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Comentario",
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(fontWeight: FontWeight.bold)),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(ratings[index].comment!,
                              style: Theme.of(context).textTheme.bodyMedium),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context, String url) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Rating image'),
          content: Image.network(url),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
