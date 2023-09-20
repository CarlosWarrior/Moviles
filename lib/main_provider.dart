import 'package:flutter/material.dart';
import 'dart:math';

import 'package:proyecto/cafe.dart';

class MainProvider extends ChangeNotifier{
  
  final List<Map<String, dynamic>> _items = List<Map<String, dynamic>>.generate(20, (i) => {
    "title": "Cafe $i",
    "image": "https://placehold.co/600x400.png",
    "foods": List<Map<String, dynamic>>.generate(10, (f) => {
      "title": "Food $f",
      "price": (Random().nextDouble() * 100).toStringAsFixed(2)
    })
  });

  List<Map<String, dynamic>> get items => _items;

  goToCafe(int index, BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Cafe(cafe:_items[index])));
  }
}