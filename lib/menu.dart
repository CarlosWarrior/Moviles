import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({
    super.key,
    required this.cafe,
  });

  final Map<String, dynamic> cafe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu de ${cafe['title']}"),
      ),
      body: Center(
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
    );
  }
}