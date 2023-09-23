import 'package:flutter/material.dart';
import 'dart:math';

import 'package:proyecto/pages/cafe.dart';

class MainProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _cafes = List<Map<String, dynamic>>.generate(
      10,
      (i) => {
            "id": "$i",
            "title": "Cafe $i",
            "rating": "${(Random().nextDouble() * 5).toStringAsFixed(2)}",
            "image": "https://placehold.co/600x400.png",
            "lat":20.606931,
            "lng":-103.416727,
            "description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "foods": List<Map<String, dynamic>>.generate(
                10,
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

  findCafeById(Map<String, dynamic> cafe, String id) {
    return cafe['id'] == id;
  }

  goToCafe(String id, BuildContext context) {
    Map<String, dynamic> cafe = _cafes.firstWhere((el) => findCafeById(el, id));
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Cafe(cafe: cafe)));
  }
}
