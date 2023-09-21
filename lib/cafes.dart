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
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              onChanged: context.watch<MainProvider>().search,
              controller: context.watch<MainProvider>().query,
              decoration: InputDecoration(
                labelText: "Buscar",
                hintText: "Buscar",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(25.0)))
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: context.watch<MainProvider>().cafes.length,
              itemBuilder: (context, index) =>
                Card(
                  margin: EdgeInsets.only(top:20),
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () => context.read<MainProvider>().goToCafe(context.read<MainProvider>().cafes[index]["id"], context),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children:[
                        ListTile(
                          title: Text(context.watch<MainProvider>().cafes[index]["title"]!),
                          leading: Image.network(context.watch<MainProvider>().cafes[index]["image"]!),
                          trailing: Column(
                            children: [
                              Icon(Icons.star, color: Colors.amber,)
                            ],
                          )
                        ),
                      ],
                    ),
                  ),
                ),
            ),
          ),
        ],
      ),
    );
  }
}