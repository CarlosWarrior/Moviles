import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto/bloc/cafeterias_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:proyecto/models/food.dart';
import 'package:proyecto/models/food.dart';
import 'package:proyecto/models/rating.dart';
import 'package:proyecto/components/camera.dart';

class RatingForm extends StatefulWidget {
  const RatingForm({required this.food, super.key});
  final Food food;

  @override
  State<RatingForm> createState() => _RatingFormState();
}

class _RatingFormState extends State<RatingForm> {
  Widget? thumbnail;

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

    clearRating(){
      context.read<CafeteriasBloc>().clearRating();
    }

    addRating() {
      pushRating();
      Navigator.of(context).pop();
    }
    cancelRating(){
      clearRating();
      Navigator.of(context).pop();
    }

    pickImage()async{
      thumbnail = await context.read<CafeteriasBloc>().pickImage();
      setState((){});
    }
    requestThumbnail()async{
      thumbnail = await context.read<CafeteriasBloc>().sendThumbnail();
      setState((){});
    }

    return WillPopScope(
      onWillPop: () {
        clearRating();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title:Text(
            "Calificar platillo ${widget.food.title}",
            style: TextStyle(fontSize: 10),
          ),
        ),
        body: SingleChildScrollView(
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
                            itemSize: 20,
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
                            itemSize: 20,
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
                style: TextStyle(fontSize: 15),
                minLines: 3,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(hintText: "¿Algún comentario?"),
                controller: commentController,
              ),
              Visibility(
                visible:
                    context.watch<CafeteriasBloc>().permissionsAccepted,
                child: Column(
                  children: [
                    ElevatedButton(
                      child: Text("Seleccionar una foto"),
                      onPressed: pickImage,
                    ),
                    ElevatedButton(
                      child: Text("Toma una foto"),
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => CameraApp(camera: context.read<CafeteriasBloc>().camera))
                      ).then((value) => requestThumbnail()),
                    ),
                  ],
                ),
              ),
              Container(
                height: 100,
                padding: const EdgeInsets.all(8.0),
                color: Colors.white,
                child: thumbnail,
              ),
              Row(
              children:[
                TextButton(
                  child: const Text('Calificar'),
                  onPressed: addRating,
                ),
                TextButton(
                  child: const Text('Cancelar'),
                  onPressed: cancelRating,
                ),
              ]
            )
            ]
          ),
        ),
      ),
    );
  }
}