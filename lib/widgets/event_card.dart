import 'package:flutter/material.dart';
import '../models/event.dart';

class EventCard extends StatelessWidget {
  final Event event;
  EventCard(this.event);

  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: <Widget>[
          Container(
            width: 90,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
              image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: NetworkImage(event.imageUrl),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 95, top: 10),
            child: ListTile(
              title: Text(event.title),
              subtitle: Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(right: 130, top: 10),
                child: Column(
                  children: [
                    Text(event.location),
                    Text(event.date),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 280),
            child: Column(
              children: <Widget>[
                FlatButton(
                  child: Icon(Icons.more, color: Colors.black),
                  onPressed: () {},
                ),
                FlatButton(
                  child: Icon(Icons.favorite_border, color: Colors.black),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
