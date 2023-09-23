import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/components/cafes.dart';
import 'package:proyecto/main_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cafeterias App"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Cafeterias App",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.white),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                  image: NetworkImage("https://picsum.photos/300/200"),
                  fit: BoxFit.cover,
                  opacity: 0.5,
                ),
              ),
            ),
            ListTile(
              title: Text("Ver cafeterias"),
              leading: Icon(Icons.coffee),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Mis favoritos"),
              leading: Icon(Icons.favorite),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Mi perfil"),
              leading: Icon(Icons.person),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Cerrar sesion"),
              leading: Icon(Icons.logout),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: ChangeNotifierProvider(
        create: (context) => MainProvider(),
        child: Cafes(),
      ),
    );
  }
}
