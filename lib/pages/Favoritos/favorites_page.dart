import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu de favoritos"),
      ),
      body: Column(
        children: [
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => {},
                //estrellas de favorito
                child: ListTile(
                  leading: IconButton(
                    icon: Icon(Icons.favorite),
                    color: Colors.red,
                    onPressed: () {},
                  ),
                  title: Text("Platillo ${index + 1}"),
                  trailing: Text("\$ ${(index + 1) * 3.25}"),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
