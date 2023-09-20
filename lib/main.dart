import 'package:flutter/material.dart';
import 'package:proyecto/cafes.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/main_provider.dart';

void main() => runApp( MyApp());

class MyApp extends StatelessWidget {
   MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cafeterias App',
      home: Scaffold(
        appBar: AppBar(
          title:  Text('Cafeterias App'),
        ),
        body:  ChangeNotifierProvider(child: Cafes(), create: (context) => MainProvider(),)
      ),
    );
  }
}