import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/components/map.dart';
import 'package:proyecto/main_provider.dart';
import 'package:proyecto/pages/menu.dart';

class Cafe extends StatelessWidget {
  final Map<String, dynamic> cafe;
  const Cafe({required this.cafe, super.key});

  @override
  Widget build(BuildContext context) {
    seeMenu(){
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => 
            ChangeNotifierProvider(
            create: (context) => MainProvider(),
            child: Menu(cafe: cafe),
          )
        )
      );
    }

    return Scaffold(
      appBar: AppBar(
        title:  Text(cafe["title"]),
      ),
      body:  Column(
        children: [
          Image.network(cafe["image"]),
          Expanded(child: 
            Padding(
              padding: EdgeInsets.all(8),
              child: Container(
                alignment: Alignment.topLeft,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(cafe["description"]),
                      ),
                      CafeMap(lat: cafe["lat"], lng: cafe["lng"])
                    ],
                  ),
                ),
              ),
            )
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 30),
            child: ElevatedButton(onPressed: seeMenu, child: Text("menu"),),
          )
        ],
      )
    );
  }
}