import 'package:flutter/material.dart';

class Cafe extends StatelessWidget {
  final Map<String, dynamic> cafe;
  const Cafe({required this.cafe, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(cafe["title"]),
      ),
      body:  Column(
        children: [
          Image.network(cafe["image"]),
          Expanded(
            child: Center(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: cafe["foods"].length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.star, color: Colors.amber,),
                    title: Text(cafe["foods"][index]["title"]),
                    trailing: Text("\$ ${cafe["foods"][index]["price"]}"),
                  );
                },
              ),
            ),
          ) 
        ],
      )
    );
  }
}