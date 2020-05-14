import 'package:flutter/material.dart';
import 'create_screen.dart';
import '../widgets/event_list_home.dart';
import '../models/event.dart';
import '../providers/user_provider.dart';
import 'package:provider/provider.dart';

enum ChoiceOpt {
  Favorite,
  CreatedByUser,
}

class EventsScreen extends StatefulWidget {
  static final routeName = '/events-screen';
  createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  String titleChoice = 'Events saved';

  ChoiceOpt toggledEventsToDisplay = ChoiceOpt.Favorite;
  List<int> initFav;
  List<int> initCreated;

  @override
  void initState() {
    UserProvider initProvider =
        Provider.of<UserProvider>(context, listen: false);
    initFav = initProvider.user.favEvents;
    initCreated = initProvider.user.createdEvents;
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(
            'Events',
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(27.0),
        ),
        actions: <Widget>[
          PopupMenuButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            onSelected: (selectedOpt) {
              setState(() {
                if (selectedOpt == ChoiceOpt.Favorite) {
                  titleChoice = 'Events saved';
                  toggledEventsToDisplay = ChoiceOpt.Favorite;
                } else {
                  titleChoice = 'Events created';
                  toggledEventsToDisplay = ChoiceOpt.CreatedByUser;
                }
              });
            },
            icon: Icon(Icons.nature),
            color: Colors.pink[50],
            itemBuilder: (_) => [
              PopupMenuItem(
                  child: Text(
                    'Marked as Fav',
                    style: TextStyle(
                        fontFamily: 'Dead',
                        decoration: TextDecoration.underline),
                  ),
                  value: ChoiceOpt.Favorite),
              PopupMenuItem(
                  child: Text(
                    'Created by Me',
                    style: TextStyle(
                        fontFamily: 'Dead',
                        decoration: TextDecoration.underline),
                  ),
                  value: ChoiceOpt.CreatedByUser),
            ],
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomLeft,
              colors: [Colors.white, Colors.white, Colors.black54]),
        ),
        child: Column(
          children: <Widget>[
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 10),
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.black,
                    width: 0.5,
                  ),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.black,
                        Colors.blue[300],
                        Colors.pink[300],
                        Colors.green[300],
                        Colors.orange[300],
                        Colors.black
                      ]),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 35),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 35),
                    padding: EdgeInsets.only(left: 30, right: 30, top: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white,
                            Colors.white,
                            Colors.grey[200]
                          ]),
                      border: Border.all(
                        color: Colors.black,
                        width: 0.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.6),
                          spreadRadius: 5,
                          blurRadius: 8,
                          offset: Offset(1, 3),
                        ),
                      ],
                    ),
                    child: Text(
                      titleChoice,
                      style:
                          TextStyle(fontFamily: 'Wild', fontSize: 15, shadows: [
                        Shadow(
                            blurRadius: 4,
                            offset: Offset(1, 2),
                            color: Colors.black.withOpacity(0.1)),
                      ]),
                    ),
                  ),
                ),
              ),
            ),
            (initFav.length > 0 &&
                        toggledEventsToDisplay == ChoiceOpt.Favorite) ||
                    (initCreated.length > 0 &&
                        toggledEventsToDisplay == ChoiceOpt.CreatedByUser)
                ? Consumer<UserProvider>(
                    builder: (context, userBloc, _) => Container(
                      margin: EdgeInsets.only(top: 10),
                      height: MediaQuery.of(context).size.height - 205,
                      child: ListView.builder(
                        itemCount: toggledEventsToDisplay == ChoiceOpt.Favorite
                            ? userBloc.user.favEvents.length
                            : userBloc.user.createdEvents.length,
                        itemBuilder: (BuildContext context, i) {
                          List<Event> fullEventObj = [];
                          if (toggledEventsToDisplay == ChoiceOpt.Favorite) {
                            userBloc.user.favEvents.map((id) {
                              fullEventObj.add(getEventFromId(events, id));
                            }).toList();
                          } else {
                            userBloc.user.createdEvents.map((id) {
                              fullEventObj.add(getEventFromId(events, id));
                            }).toList();
                          }
                          return fullEventObj.length > 0
                              ? Center(child: EventListHome(fullEventObj[i]))
                              : SizedBox();
                        },
                      ),
                    ),
                  )
                : Center(
                    child: Container(
                        margin: EdgeInsets.only(top: 180),
                        child: Text('No Events to Display'))),
          ],
        ),
      ),
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
