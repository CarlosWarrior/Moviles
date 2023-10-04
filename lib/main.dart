import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto/bloc/cafeterias_bloc.dart';
import 'package:proyecto/pages/Auth/login_page.dart';
import 'package:proyecto/pages/Cafeterias/cafeterias_page.dart';
import 'package:proyecto/pages/Favoritos/favorites_page.dart';
import 'package:proyecto/pages/home_page.dart';
import 'package:proyecto/pages/MyProfile/my_profile_page.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CafeteriasBloc()..add(GetCafeteriasEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'Cafeterias App',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          '/auth': (context) => LoginPage(),
          '/cafeterias': (context) => CafeteriasPage(),
          '/my_profile': (context) => MyProfilePage(),
          '/favorites': (context) => FavoritePage(),
        },
      ),
    );
  }
}
