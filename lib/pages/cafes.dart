import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/components/coffe_card.dart';
import 'package:proyecto/main_provider.dart';

class Cafes extends StatelessWidget {
  Cafes({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(15.0),
              child: TextField(
                onChanged: context.watch<MainProvider>().search,
                controller: context.watch<MainProvider>().query,
                decoration: InputDecoration(
                    labelText: "Buscar",
                    hintText: "Buscar",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _getGridCount(context),
                ),
                itemCount: context.watch<MainProvider>().cafes.length,
                itemBuilder: (BuildContext context, int index) {
                  var coffe = context.read<MainProvider>().cafes[index];
                  return CoffeCardComponent(
                    image: Ink.image(
                        image: NetworkImage(coffe["image"]!),
                        fit: BoxFit.cover),
                    title: coffe["title"]!,
                    rating: coffe["rating"]!,
                    id: coffe["id"]!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _getGridCount(BuildContext context) {
    if (MediaQuery.of(context).size.width > 600) {
      return 3;
    } else if (MediaQuery.of(context).size.width > 400) {
      return 2;
    } else {
      return 1;
    }
  }
}
