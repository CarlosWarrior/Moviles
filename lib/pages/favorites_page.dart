import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/main_provider.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({
    super.key,
    required this.cafe,
  });
  final Map<String, dynamic> cafe;

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
                    onPressed: () {
                      //no lo presionen
                      // context
                      //     .read<MainProvider>()
                      //    .addToFavorite(cafe["foods"][index]["id"].toString());
                    },
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
