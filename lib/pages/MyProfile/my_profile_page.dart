import 'package:flutter/material.dart';
import 'package:proyecto/pages/MyProfile/change_password_alert.dart';

class MyProfilePage extends StatelessWidget {
  final String name = 'Usuario';
  final int comments = 3;
  final int coffeReviews = 2;
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
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
              name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Stack(
              children: [
                CircleAvatar(
                  radius: 96,
                  // TODO: Change this to the user's profile picture
                  backgroundImage: NetworkImage(
                      'https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_square.jpg'),
                ),
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
                      onPressed: () {},
                    ),
                  ),
                )
              ],
            ),
            Text(
              'Has comentado $comments platillos en $coffeReviews cafeterias',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
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
