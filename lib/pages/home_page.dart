import 'package:flutter/material.dart';

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
              onTap: () async {
                Navigator.pop(context);
                await Navigator.of(context).pushNamed('/cafeterias');
              },
            ),
            ListTile(
              title: Text("Mis favoritos"),
              leading: Icon(Icons.favorite),
              onTap: () async {
                Navigator.of(context).pop();
                await Navigator.of(context).pushNamed('/favorites');
              },
            ),
            ListTile(
              title: Text("Mi perfil"),
              leading: Icon(Icons.person),
              onTap: () async {
                Navigator.of(context).pop();
                await Navigator.of(context).pushNamed('/my_profile');
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
    );
  }
}
