import 'package:flutter/material.dart';
import 'package:proyecto/pages/favorites_page.dart';
import 'package:proyecto/pages/home_page.dart';
import 'package:proyecto/pages/my_profile/my_profile_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Cafeterias App',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        routes: {
          '/my_profile': (context) => MyProfilePage(),
          '/favorites': (context) => FavoritePage(cafe: {})
        },
        home: HomePage());
  }
}
