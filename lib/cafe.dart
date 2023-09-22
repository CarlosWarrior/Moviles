import 'package:flutter/material.dart';
import 'package:proyecto/menu.dart';

class Cafe extends StatelessWidget {
  final Map<String, dynamic> cafe;
  const Cafe({required this.cafe, super.key});

  @override
  Widget build(BuildContext context) {
    seeMenu(){
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => Menu(cafe: cafe) )
      );
    }
    return Scaffold(
      appBar: AppBar(
        title:  Text(cafe["title"]),
      ),
      body:  Column(
        children: [
          Image.network(cafe["image"]),
          MaterialButton(onPressed: seeMenu, child: Text("menu"),)
        ],
      )
    );
  }
}