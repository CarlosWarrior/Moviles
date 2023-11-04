import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto/bloc/cafeterias_bloc.dart';
import 'package:proyecto/components/map.dart';
import 'package:proyecto/models/cafeteria.dart';
import 'package:proyecto/pages/Cafeterias/comments/comment.dart';
import 'package:proyecto/pages/Cafeterias/menu_page.dart';

class CafeteriaElement extends StatelessWidget {
  final Cafeteria cafeteria;
  const CafeteriaElement({
    required this.cafeteria,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.read<CafeteriasBloc>().add(GetCafeteriasEvent());
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(cafeteria.title!),
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Container(
                  alignment: Alignment.topLeft,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 200,
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: Image.network(
                                    cafeteria.image!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: // Fill with blank circle
                                      Container(
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(50),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: IconButton(
                                    onPressed: () {},
                                    color: Colors.red,
                                    icon: Icon(Icons.favorite),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.access_time),
                                    Text(
                                      "Horario: ",
                                      // style title
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    Text(
                                      cafeteria.schedule!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                              fontWeight: FontWeight.normal),
                                    ),
                                    Expanded(
                                      child: Container(),
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          context
                                              .read<CafeteriasBloc>()
                                              .setCafeteria(cafeteria);
                                          context
                                              .read<CafeteriasBloc>()
                                              .add(ViewMenuEvent());
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) => MenuPage(),
                                          ));
                                        },
                                        child: Text("VER MENU"))
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.description),
                                    Text(
                                      "Descripcion: ",
                                      // style title
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                  ],
                                ),
                                Text(
                                  cafeteria.description!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                          CafeMap(lat: cafeteria.lat!, lng: cafeteria.lng!),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
