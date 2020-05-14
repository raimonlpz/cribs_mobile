import 'package:flutter/material.dart';
import '../models/event.dart';
import '../screens/event_detail_screen.dart';

class EventListHome extends StatelessWidget {
  final Event event;
  EventListHome(this.event);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(EventDetailScreen.routeName, arguments: event);
      },
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            height: 190,
            width: 290,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: NetworkImage(event.imageUrl), fit: BoxFit.cover),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 8,
                  offset: Offset(1, 3),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(12),
            width: 190,
            height: 60,
            margin: EdgeInsets.only(top: 160, left: 100),
            child: Column(
              children: [
                Text(
                  event.title,
                  style: TextStyle(
                      color: Colors.pinkAccent, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${event.location} | ${event.date}',
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 8,
                  offset: Offset(1, 3),
                ),
              ],
            ),
          ),
          Container(
            height: 35,
            margin: EdgeInsets.only(top: 190, left: 80),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 8,
                  offset: Offset(1, 3),
                ),
              ],
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EventDetailScreen.routeName, arguments: event);
              },
              icon: Icon(Icons.more),
              color: Colors.white,
              iconSize: 15,
            ),
          ),
        ],
      ),
    ));
  }
}
