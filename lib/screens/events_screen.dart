import 'package:flutter/material.dart';
import '../widgets/appbar_header.dart';
import 'create_screen.dart';

class EventsScreen extends StatelessWidget {
  static final routeName = '/events-screen';

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarHeader('Events', Colors.black),
      body: Center(child: Text('Hey')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(CreateScreen.routeName);
        },
        backgroundColor: Colors.black,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
