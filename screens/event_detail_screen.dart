import 'package:flutter/material.dart';
import '../models/event.dart';
import '../widgets/appbar_header.dart';
import 'calendar_screen.dart';
import 'map_screen.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import 'package:intl/intl.dart';

enum ToggleActionEvent {
  SaveEvent,
  RemoveEvent,
}

class EventDetailScreen extends StatefulWidget {
  static final routeName = '/event-detail-screen';
  createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  Event event;
  ToggleActionEvent eventAction;

  didChangeDependencies() {
    event = ModalRoute.of(context).settings.arguments;
    bool checkEvent = Provider.of<UserProvider>(context, listen: true)
            .user
            .favEvents
            .indexWhere((_id) => _id == event.id) !=
        -1;
    if (checkEvent) {
      eventAction = ToggleActionEvent.RemoveEvent;
    } else {
      eventAction = ToggleActionEvent.SaveEvent;
    }
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appbarHeader('Event details', Colors.black),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 70),
              width: 325,
              height: 265,
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
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 13, left: 10, right: 10),
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomRight,
                    colors: [Colors.white, Colors.pink[200]]),
                borderRadius: BorderRadius.circular(60),
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    spreadRadius: 5,
                    blurRadius: 8,
                    offset: Offset(1, 3),
                  ),
                ],
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: SizedBox(
                  child: Text(
                    '${event.title}',
                    maxLines: 1,
                    style: TextStyle(
                        fontFamily: 'Dead',
                        color: Colors.black,
                        fontSize: 25,
                        fontStyle: FontStyle.italic,
                        shadows: [
                          Shadow(
                              blurRadius: 7,
                              offset: Offset(2, 3),
                              color: Colors.black.withOpacity(0.3)),
                        ]),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 350, left: 13, right: 7.5),
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(event.description,
                      style: TextStyle(fontSize: 18), maxLines: 8),
                  SizedBox(
                      height: 30,
                      child: Text('...', style: TextStyle(fontSize: 20))),
                  Text(
                      'Loc: ${event.location} | Date: ${DateFormat('yyyy-MM-dd').format(event.date)}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.pinkAccent)),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 60),
              decoration: BoxDecoration(
                color: Colors.greenAccent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    spreadRadius: 5,
                    blurRadius: 8,
                    offset: Offset(1, 3),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(CalendarScreen.routeName, arguments: event);
                },
                icon: Icon(Icons.event),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 295),
              decoration: BoxDecoration(
                color: Colors.pink[200],
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    spreadRadius: 5,
                    blurRadius: 8,
                    offset: Offset(1, 3),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(MapScreen.routeName, arguments: event);
                },
                icon: Icon(Icons.location_on),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Builder(builder: (BuildContext ctx) {
        return FloatingActionButton.extended(
          label: eventAction == ToggleActionEvent.RemoveEvent
              ? Text('Unsave')
              : Text('Save Event'),
          elevation: 20,
          onPressed: () {
            if (eventAction == ToggleActionEvent.RemoveEvent) {
              Provider.of<UserProvider>(context, listen: false)
                  .removeEventFromFavs(event.id);
              setState(() {
                eventAction = ToggleActionEvent.SaveEvent;
              });
            } else {
              Provider.of<UserProvider>(context, listen: false)
                  .addEventToFavs(event.id);
              setState(() {
                eventAction = ToggleActionEvent.RemoveEvent;
              });
            }

            Scaffold.of(ctx).hideCurrentSnackBar();
            final snackBar = SnackBar(
              backgroundColor: Colors.black,
              duration: Duration(milliseconds: 800),
              elevation: 6.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              content: Text(
                eventAction == ToggleActionEvent.RemoveEvent
                    ? 'Adding Event to Favorites...'
                    : 'Removing Event from Favorites',
                style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Dead'),
              ),
              action: SnackBarAction(
                label: 'UNDO',
                textColor: Colors.pink[200],
                onPressed: () {
                  if (eventAction == ToggleActionEvent.RemoveEvent) {
                    Provider.of<UserProvider>(context, listen: false)
                        .removeEventFromFavs(event.id);
                    setState(() {
                      eventAction = ToggleActionEvent.SaveEvent;
                    });
                  } else {
                    Provider.of<UserProvider>(context, listen: false)
                        .addEventToFavs(event.id);
                    setState(() {
                      eventAction = ToggleActionEvent.RemoveEvent;
                    });
                  }
                },
              ),
            );

            Scaffold.of(ctx).showSnackBar(snackBar);
          },
          backgroundColor: Colors.black,
          icon: eventAction == ToggleActionEvent.RemoveEvent
              ? Icon(Icons.favorite, color: Colors.pink[100])
              : Icon(Icons.favorite_border, color: Colors.white),
        );
      }),
    );
  }
}
