import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto/bloc/cafeterias_bloc.dart';
import 'package:proyecto/components/coffe_card.dart';
import 'package:proyecto/models/cafeteria.dart';
import 'package:proyecto/pages/Cafeterias/cafeteria_element_page.dart';

class CafeteriasList extends StatefulWidget {
  final List<Cafeteria> cafeterias;
  const CafeteriasList({
    required this.cafeterias,
    super.key,
  });

  @override
  State<CafeteriasList> createState() => _CafeteriasListState();
}

class _CafeteriasListState extends State<CafeteriasList> {
  TextEditingController _query = TextEditingController();
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
                    onChanged: (_) => BlocProvider.of<CafeteriasBloc>(context)
                        .add(SearchCafeteriasEvent(query: _query.text)),
                    controller: _query,
                    decoration: InputDecoration(
                      labelText: "Buscar",
                      hintText: "Buscar",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0))),
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.sort),
                    onPressed: () {},
                  ),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _getGridCount(context),
                  ),
                  itemCount: widget.cafeterias.length,
                  itemBuilder: (BuildContext context, int index) {
                    Cafeteria cafeteria = widget.cafeterias[index];
                    return CoffeCardComponent(
                      onTap: () {
                        context.read<CafeteriasBloc>().setCafeteria(cafeteria);
                        context
                            .read<CafeteriasBloc>()
                            .add(SelectCafeteriasEvent());
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CafeteriaElementPage(),
                        ));
                      },
                      image: Ink.image(
                          image: NetworkImage(cafeteria.image!),
                          fit: BoxFit.cover),
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
