import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto/bloc/auth/auth_bloc.dart';
import 'package:proyecto/bloc/cafeterias/cafeterias_bloc.dart';
import 'package:proyecto/bloc/profile_picture/profile_picture_bloc.dart';
import 'package:proyecto/firebase_options.dart';
import 'package:proyecto/pages/Auth/login_page.dart';
import 'package:proyecto/pages/Auth/register_page.dart';
import 'package:proyecto/pages/home_page.dart';
import 'package:proyecto/pages/MyProfile/my_profile_page.dart';
import 'package:camera/camera.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final camera = cameras.first;

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) =>
            CafeteriasBloc(camera: camera)..add(GetCafeteriasEvent()),
      ),
      BlocProvider(create: (context) => AuthBloc()..add(AuthCheckEvent())),
      BlocProvider(
        create: (context) => ProfilePictureBloc(),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // If current user is not logged in, redirect to login page
    return MaterialApp(
      title: 'Cafeterias App',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/auth': (context) => LoginPage(),
        '/my_profile': (context) => MyProfilePage(),
        '/register': (context) => RegisterPage(),
      },
    );
  }
}
