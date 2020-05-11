import 'package:flutter/material.dart';
import '../widgets/navDrawer.dart';
import 'profile_screen.dart';
import '../widgets/users_list.dart';
import '../widgets/event_list_home.dart';
import '../models/user.dart';
import '../models/event.dart';

class Home extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(27.0),
        ),
        backgroundColor: Colors.black,
        title: Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(
            'Home',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'WILD',
              shadows: [
                Shadow(
                    blurRadius: 5.0, offset: Offset.zero, color: Colors.black),
              ],
              color: Colors.white,
            ),
          ),
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: IconButton(
              alignment: Alignment.centerRight,
              onPressed: () {
                Navigator.of(context).pushNamed(ProfileScreen.routeName);
              },
              icon: Icon(Icons.person_outline),
            ),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height / 2 + 20, top: 5),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: events.length,
              itemBuilder: (BuildContext context, i) {
                return EventListHome(events[i]);
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 2.5 - 20, left: 23),
            child: Text('Users activity', style: TextStyle(fontFamily: 'WILD')),
          ),
          Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 2.5, bottom: 5),
            //height: MediaQuery.of(context).size.height / 2.5,
            child: ListView.builder(
              itemCount: 8,
              itemBuilder: (BuildContext context, i) {
                return UsersList(users[i]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
