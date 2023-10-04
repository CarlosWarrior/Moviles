import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto/bloc/cafeterias_bloc.dart';
import 'package:proyecto/components/map.dart';
import 'package:proyecto/models/cafeteria.dart';

class CafeteriaElement extends StatelessWidget {
  final Cafeteria cafeteria;
  const CafeteriaElement({
    required this.cafeteria,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(cafeteria.title!),
          leading: IconButton(onPressed: () => context.read<CafeteriasBloc>().add(GetCafeteriasEvent()), icon: Icon(Icons.arrow_back_ios)),
        ),
        body: Column(
          children: [
            Image.network(cafeteria.image!),
            Expanded(
                child: Padding(
              padding: EdgeInsets.all(8),
              child: Container(
                alignment: Alignment.topLeft,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(cafeteria.schedule!),
                            Text(cafeteria.description!),
                          ],
                        ),
                      ),
                      CafeMap(lat: cafeteria.lat!, lng: cafeteria.lng!)
                    ],
                  ),
                ),
              ),
            )),
            Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: ElevatedButton(
                onPressed: () {
                  context.read<CafeteriasBloc>().setCafeteria(cafeteria);
                  context.read<CafeteriasBloc>().add(ViewMenuEvent());
                },
                child: Text("menu"),
              ),
            )
          ],
        ),
      );
  }
}
