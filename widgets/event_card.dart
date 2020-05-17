import 'package:flutter/material.dart';
import '../models/event.dart';
import '../screens/event_detail_screen.dart';
import '../providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

enum ToggleActionEvent {
  SaveEvent,
  RemoveEvent,
}

class EventCard extends StatefulWidget {
  final Event event;
  final bool searchMode;
  EventCard(this.event, this.searchMode);
  createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  ToggleActionEvent eventAction;

  didChangeDependencies() {
    bool checkEvent = Provider.of<UserProvider>(context, listen: true)
            .user
            .favEvents
            .indexWhere((_id) => _id == widget.event.id) !=
        -1;
    if (checkEvent) {
      eventAction = ToggleActionEvent.RemoveEvent;
    } else {
      eventAction = ToggleActionEvent.SaveEvent;
    }
    super.didChangeDependencies();
  }

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
                image: NetworkImage(widget.event.imageUrl),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 95, top: 10),
            child: ListTile(
              title: Text(widget.event.title),
              subtitle: Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(right: 130, top: 10),
                child: Column(
                  children: [
                    Text(widget.event.location),
                    Text(DateFormat('yyyy-MM-dd').format(widget.event.date)),
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
                  onPressed: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                    Navigator.of(context).pushNamed(EventDetailScreen.routeName,
                        arguments: widget.event);
                  },
                ),
                !widget.searchMode
                    ? FlatButton(
                        child: eventAction == ToggleActionEvent.RemoveEvent
                            ? Icon(Icons.favorite, color: Colors.pink[200])
                            : Icon(Icons.favorite_border, color: Colors.black),
                        onPressed: () {
                          print(eventAction);
                          if (eventAction == ToggleActionEvent.SaveEvent) {
                            Provider.of<UserProvider>(context, listen: false)
                                .addEventToFavs(widget.event.id);
                            if (this.mounted) {
                              setState(() {
                                eventAction = ToggleActionEvent.RemoveEvent;
                              });
                            }
                          } else {
                            Provider.of<UserProvider>(context, listen: false)
                                .removeEventFromFavs(widget.event.id);
                            if (this.mounted) {
                              setState(() {
                                eventAction = ToggleActionEvent.SaveEvent;
                              });
                            }
                          }

                          Scaffold.of(context).hideCurrentSnackBar();
                          final snackBar = SnackBar(
                            backgroundColor: Colors.black,
                            duration: Duration(milliseconds: 800),
                            elevation: 6.0,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            content: Text(
                              eventAction == ToggleActionEvent.RemoveEvent
                                  ? 'Adding Event to Favorites...'
                                  : 'Removing Event from Favorites...',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                  fontFamily: 'Dead'),
                            ),
                            action: SnackBarAction(
                              label: 'UNDO',
                              textColor: Colors.pink[200],
                              onPressed: () {
                                if (eventAction ==
                                    ToggleActionEvent.SaveEvent) {
                                  Provider.of<UserProvider>(context,
                                          listen: false)
                                      .addEventToFavs(widget.event.id);
                                  if (this.mounted) {
                                    setState(() {
                                      eventAction =
                                          ToggleActionEvent.RemoveEvent;
                                    });
                                  }
                                } else {
                                  Provider.of<UserProvider>(context,
                                          listen: false)
                                      .removeEventFromFavs(widget.event.id);
                                  if (this.mounted) {
                                    setState(() {
                                      eventAction = ToggleActionEvent.SaveEvent;
                                    });
                                  }
                                }
                              },
                            ),
                          );
                          Scaffold.of(context).showSnackBar(snackBar);
                        },
                      )
                    : FlatButton(
                        child: Icon(Icons.favorite, color: Colors.grey[200]),
                        onPressed: null,
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
