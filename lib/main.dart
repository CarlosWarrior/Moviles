import 'package:flutter/material.dart';
import 'package:proyecto/cafes.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/main_provider.dart';
import 'package:proyecto/pages/login_page.dart';
import 'package:proyecto/pages/sign_in_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cafeterias App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignInPage(),
    );
  }
}
