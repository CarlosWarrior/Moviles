import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto/bloc/cafeterias_bloc.dart';
import 'package:proyecto/components/coffe_card.dart';
import 'package:proyecto/models/cafeteria.dart';

class CafeteriasList extends StatelessWidget {
  final TextEditingController query;
  final List<Cafeteria> cafeterias;
  const CafeteriasList({
    required this.query,
    required this.cafeterias,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de cafeterias"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(15.0),
                child: ListTile(
                  title: TextField(
                    onChanged: (_) => context.read<CafeteriasBloc>().add(SearchCafeteriasEvent()),
                    controller: this.query,
                    decoration: InputDecoration(
                        labelText: "Buscar",
                        hintText: "Buscar",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25.0))),
                        ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.sort),
                    onPressed: (){},
                  ),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _getGridCount(context),
                  ),
                  itemCount: cafeterias.length,
                  itemBuilder: (BuildContext context, int index) {
                    Cafeteria cafeteria = cafeterias[index];
                    return CoffeCardComponent(
                      onTap: () {
                        context.read<CafeteriasBloc>().setCafeteria(cafeteria);
                        context.read<CafeteriasBloc>().add(SelectCafeteriasEvent());
                      },
                      image: Ink.image(
                        image: NetworkImage(cafeteria.image!),
                        fit: BoxFit.cover
                      ),
                      title: cafeteria.title!,
                      rating: cafeteria.rating!.toString(),
                      id: cafeteria.id!,
                    );
                  },
                ),
              ),
            ],
          ),
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
