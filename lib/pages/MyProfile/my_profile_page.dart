import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto/bloc/auth/auth_bloc.dart';
import 'package:proyecto/bloc/cafeterias/cafeterias_bloc.dart';
import 'package:proyecto/bloc/profile_picture/profile_picture_bloc.dart';
import 'package:proyecto/models/cafeteria.dart';
import 'package:proyecto/pages/Auth/login_page.dart';
import 'package:proyecto/pages/Cafeterias/cafeteria_element_page.dart';
import 'package:proyecto/pages/MyProfile/change_password_alert.dart';

class MyProfilePage extends StatelessWidget {
  final int comments = 3;
  final int coffeReviews = 2;
  MyProfilePage({super.key});

  static const imagePlaceholder =
      'https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_square.jpg';

  final favoritesQuery = FirebaseFirestore.instance
      .collection('cafeterias')
      .where('favorites', arrayContains: FirebaseAuth.instance.currentUser!.uid)
      .withConverter(
        fromFirestore: (snapshot, options) =>
            Cafeteria.fromMap(snapshot.data()!),
        toFirestore: (cafeteria, options) => cafeteria.toMap(),
      );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is AuthSuccess) {
        return _buildProfile(context, state);
      } else {
        return LoginPage();
      }
    });
  }

  Widget _buildProfile(BuildContext context, AuthSuccess state) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi perfil'),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Hola de nuevo, ',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            Text(
              state.user.displayName!,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Stack(
              children: [
                BlocBuilder<ProfilePictureBloc, ProfilePictureState>(
                    builder: (context, profileState) {
                  if (profileState is ProfilePictureLoaded ||
                      profileState is ProfilePictureInitial) {
                    print(state.user.photoURL);
                    if (state.user.photoURL != null) {
                      return CircleAvatar(
                        radius: 96,
                        backgroundImage: NetworkImage(state.user.photoURL!),
                      );
                    }
                    return CircleAvatar(
                      radius: 96,
                      backgroundColor: Colors.grey[300],
                    );
                  } else {
                    // Circle with a loading indicator
                    return CircleAvatar(
                      radius: 96,
                      backgroundColor: Colors.grey[300],
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.deepOrangeAccent[100],
                      borderRadius: BorderRadius.circular(64),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        BlocProvider.of<ProfilePictureBloc>(context)
                            .add(UpdateProfilePictureEvent());
                        BlocProvider.of<AuthBloc>(context)
                            .add(AuthCheckEvent());
                      },
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: ExpansionTile(
                title: const Text("Mis favoritos"),
                children: [
                  FirestoreListView<Cafeteria>(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    query: favoritesQuery,
                    itemBuilder: (context, doc) {
                      var cafeteria = doc.data();
                      return InkWell(
                        onTap: () {
                          context
                              .read<CafeteriasBloc>()
                              .setCafeteria(cafeteria);
                          context
                              .read<CafeteriasBloc>()
                              .add(SelectCafeteriasEvent());
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CafeteriaElementPage(),
                          ));
                        },
                        child: ListTile(
                          title: Text(cafeteria.title!),
                          leading: Image.network(cafeteria.image!,
                              fit: BoxFit.cover),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => ChangePasswordAlert(id: 'id'));
              },
              child: Text('CAMBIAR CONTRASEÑA'),
            ),
          ],
        ),
      ),
    );
  }
}
