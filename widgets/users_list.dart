import 'package:flutter/material.dart';
import '../models/user.dart';

class UsersList extends StatelessWidget {
  final User user;

  UsersList(this.user);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 20, right: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.black,
          width: 0.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 8,
            offset: Offset(1, 3),
          ),
        ],
      ),
      child: ListTile(
        onTap: () {},
        leading: CircleAvatar(
          backgroundImage: NetworkImage(user.urlImage),
        ),
        title: Text(user.username),
        subtitle: Text(
          user.phrase,
          style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
        ),
        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.black),
      ),
    );
  }
}
