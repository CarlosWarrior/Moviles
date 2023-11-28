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
      onWillPop: (){
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
                  return ListTile(
                    title: Text(ratings[index].food!),
                    subtitle: Text(ratings[index].comment!),
                    leading: ratings[index].image != null && ratings[index].image != ''?IconButton(onPressed: () => _dialogBuilder(context, ratings[index].image!), icon: Icon(Icons.image)):Text(""),
                    trailing: Column(
                      children: [
                        Column(
                          children: [
                            Text("Precio"),
                            RatingBarIndicator(
                              itemSize: 10,
                              rating: ratings[index].price!,
                              direction: Axis.horizontal,
                              itemCount: 5,
                              itemPadding:EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Sabor"),
                            RatingBarIndicator(
                              itemSize: 10,
                              rating: ratings[index].taste!,
                              direction: Axis.horizontal,
                              itemCount: 5,
                              itemPadding:EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                            ),
                          ],
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