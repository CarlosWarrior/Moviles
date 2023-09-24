import 'package:flutter/material.dart';
import 'dart:math';

import 'package:proyecto/pages/cafe.dart';

class MainProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _cafes = List<Map<String, dynamic>>.generate(
      15,
      (i) => {
        "id": "$i",
        "title": "Cafe $i",
        "rating": "${(Random().nextDouble() * 5).toStringAsFixed(2)}",
        "image": "https://placehold.co/600x400.png",
        "description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        "schedule": "9:00 - 18:00",
        "lat":20.606931,
        "lng":-103.416727,
        "foods": List<Map<String, dynamic>>.generate(
            20,
            (f) => {
              "title": "Food $f",
              "price": (Random().nextDouble() * 100).toStringAsFixed(2)
            })
      });

  bool contains(Map<String, dynamic> cafe) {
    return cafe["title"]
        .toString()
        .toLowerCase()
        .contains(query.text.toLowerCase());
  }

  List<Map<String, dynamic>> get cafes => _cafes.where(contains).toList();
  TextEditingController query = TextEditingController();
  search(String value) {
    notifyListeners();
  }
  sort(){

  }

  findCafeById(Map<String, dynamic> cafe, String id) {
    return cafe['id'] == id;
  }

  goToCafe(String id, BuildContext context) {
    Map<String, dynamic> cafe = _cafes.firstWhere((el) => findCafeById(el, id));
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Cafe(cafe: cafe)));
  }

  double _foodTasteRating = 0.0;
  double _foodPriceRating = 0.0;
  TextEditingController foodComment = TextEditingController();
  rateTaste(double rating){
    _foodTasteRating = rating;
  }
  ratePrice(double rating){
    _foodPriceRating = rating;
  }

  pushFoodRating(){
    print("${foodComment.text} , ${_foodTasteRating.toString()}, ${_foodPriceRating.toString()}");
    _foodTasteRating = 0.0;
    _foodPriceRating = 0.0;

  }
}
