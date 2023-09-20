import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/main_provider.dart';

class Cafes extends StatelessWidget {
  Cafes({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        itemCount: context.watch<MainProvider>().items.length,
        itemBuilder: (context, index) {
          return Card(
            
            margin: EdgeInsets.only(top:20),
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () => context.read<MainProvider>().goToCafe(index, context),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children:[
                  ListTile(
                    title: Text(context.watch<MainProvider>().items[index]["title"]!),
                    leading: Image.network(context.watch<MainProvider>().items[index]["image"]!),
                    trailing: Column(
                      children: [
                        Icon(Icons.star, color: Colors.amber,)
                      ],
                    )
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}