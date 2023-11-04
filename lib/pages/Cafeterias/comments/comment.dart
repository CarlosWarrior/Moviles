import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  final String user;
  final String comment;
  final String date;
  final String? userImage;
  final int rating;
  const Comment(
      {super.key,
      required this.user,
      required this.comment,
      required this.date,
      this.userImage,
      required this.rating});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: userImage == null ? null : NetworkImage(userImage!),
      ),
      title: Text(user),
      subtitle: Text(comment),
      trailing: Column(
        children: [
          Text(date),
          Icon(
            Icons.star,
            color: Colors.yellow,
          ),
          Text(rating.toString()),
        ],
      ),
    );
  }
}
