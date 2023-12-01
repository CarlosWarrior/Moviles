import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto/bloc/auth/auth_bloc.dart';
import 'package:proyecto/pages/Auth/login_page.dart';
import 'package:proyecto/pages/Cafeterias/cafeterias_list_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthSuccess) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Cafeterias App"),
            ),
            drawer: Sidenbar(),
            body: CafeteriasPage(),
          );
        }
        return LoginPage();
      },
    );
  }
}

class Sidenbar extends StatelessWidget {
  const Sidenbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                image: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/c/c5/Roasted_coffee_beans.jpg"),
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
              await Navigator.of(context).pushNamed('/');
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
              BlocProvider.of<AuthBloc>(context).add(AuthLogoutEvent());
            },
          ),
        ],
      ),
    );
  }
}
