import 'package:flutter/material.dart';
import 'dart:math';

import 'package:proyecto/cafe.dart';

class MainProvider extends ChangeNotifier{
  
  List<Map<String, dynamic>> _cafes = List<Map<String, dynamic>>.generate(20, (i) => {
    "id": "$i",
    "title": "Cafe $i",
    "image": "https://placehold.co/600x400.png",
    "foods": List<Map<String, dynamic>>.generate(10, (f) => {
      "title": "Food $f",
      "price": (Random().nextDouble() * 100).toStringAsFixed(2)
    })
  });
  
  bool contains(Map<String, dynamic> cafe){
    return cafe["title"].toString().toLowerCase().contains(query.text.toLowerCase());
  }
  List<Map<String, dynamic>> get cafes => _cafes.where(contains).toList();
  TextEditingController query = TextEditingController();
  search(String value){
    notifyListeners();
  }

  findCafeById(Map<String, dynamic> cafe, String id){
    return cafe['id'] == id;
  }
  goToCafe(String id, BuildContext context){
    Map<String, dynamic> cafe = _cafes.firstWhere((el) => findCafeById(el, id));
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Cafe(cafe:cafe)));
  }

}