import 'package:flutter/material.dart';
import '../screens/profile_screen.dart';
import '../screens/events_screen.dart';
import '../screens/create_screen.dart';
import '../screens/calendar_screen.dart';
import '../screens/search_screen.dart';

class NavDrawer extends StatelessWidget {
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.black38.withOpacity(0.7),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(75),
        ),
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Container(
                  margin: EdgeInsets.only(top: 105),
                  child: Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: 19,
                      color: Colors.white,
                      fontFamily: 'WILD',
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.pink[100],
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/img/giphy.gif'),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.person_outline, color: Colors.white),
                title: Text(
                  'Profile',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: 'Dead',
                      fontStyle: FontStyle.italic),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(ProfileScreen.routeName);
                },
              ),
              Divider(color: Colors.pink[100], thickness: 2, indent: 60),
              ListTile(
                leading: Icon(Icons.traffic, color: Colors.white),
                title: Text(
                  'My Events',
                  style: TextStyle(
                      fontSize: 16, color: Colors.white, fontFamily: 'Dead'),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(EventsScreen.routeName);
                },
              ),
              Divider(color: Colors.pink[100], thickness: 2, indent: 60),
              ListTile(
                leading: Icon(Icons.panorama_vertical, color: Colors.white),
                title: Text(
                  'Create New Event',
                  style: TextStyle(
                      fontSize: 16, color: Colors.white, fontFamily: 'Dead'),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(CreateScreen.routeName);
                },
              ),
              Divider(color: Colors.pink[100], thickness: 2, indent: 60),
              ListTile(
                leading: Icon(Icons.event, color: Colors.white),
                title: Text(
                  'Calendar',
                  style: TextStyle(
                      fontSize: 16, color: Colors.white, fontFamily: 'Dead'),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(CalendarScreen.routeName);
                },
              ),
              Divider(color: Colors.pink[100], thickness: 2, indent: 60),
              ListTile(
                leading: Icon(Icons.search, color: Colors.white),
                title: Text(
                  'Search',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: 'Dead',
                      fontStyle: FontStyle.italic),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(SearchScreen.routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
