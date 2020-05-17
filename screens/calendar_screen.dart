import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../widgets/appbar_header.dart';
import '../models/event.dart';
import 'package:intl/intl.dart';
import 'event_detail_screen.dart';

class CalendarScreen extends StatefulWidget {
  static final routeName = '/calendar-screen';
  createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarController _calendarController;
  List<Event> _eventSelected;
  Map<DateTime, List> _events = Map();
  bool _entryScreenToggle;

  void initState() {
    _entryScreenToggle = true;
    _calendarController = CalendarController();
    getDateEvents();
    super.initState();
  }

  void didChangeDependencies() {
    if (_entryScreenToggle) {
      _eventSelected = ModalRoute.of(context).settings.arguments != null
          ? new List.from(
              [ModalRoute.of(context).settings.arguments],
            )
          : new List.from(
              events,
            );
    }

    super.didChangeDependencies();
  }

  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  void getDateEvents() {
    events.map((event) {
      if (_events.containsKey(event.date)) {
        _events.update(event.date, (oldEvent) {
          return oldEvent = new List.from(oldEvent)..addAll([event.title]);
        });
      } else {
        _events.addAll({
          event.date: [event.title]
        });
      }
    }).toList();
  }

  void changeEventSelected(List<dynamic> eventReceived) {
    _eventSelected = [];
    setState(() {
      eventReceived.map((eventTitle) {
        for (var _event in events) {
          if (_event.title == eventTitle) {
            _eventSelected.add(_event);
          }
        }
      }).toList();
    });
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        setState(() {
          _entryScreenToggle = false;
        });
        return Future.value(true);
      },
      child: Scaffold(
        appBar: appbarHeader('Calendar', Colors.black),
        body: Stack(
          children: [
            Container(
              margin:
                  EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 190),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                image: DecorationImage(
                    image: AssetImage('assets/img/lime.png'),
                    fit: BoxFit.contain),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 10,
                    blurRadius: 8,
                    offset: Offset(1, 3),
                  ),
                ],
              ),
            ),
            Container(
              margin:
                  EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 200),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 10,
                    blurRadius: 8,
                    offset: Offset(1, 3),
                  ),
                ],
              ),
              child: TableCalendar(
                calendarController: _calendarController,
                startingDayOfWeek: StartingDayOfWeek.monday,
                events: _events,
                headerStyle: HeaderStyle(
                  titleTextStyle:
                      TextStyle(color: Colors.white, fontFamily: 'Dead'),
                  formatButtonTextStyle: TextStyle(color: Colors.white),
                  formatButtonDecoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  rightChevronIcon: Icon(
                    Icons.arrow_right,
                    size: 30.0,
                    color: Colors.white,
                  ),
                  leftChevronIcon: Icon(
                    Icons.arrow_left,
                    size: 30.0,
                    color: Colors.white,
                  ),
                ),
                initialSelectedDay: _eventSelected.length == events.length
                    ? DateTime.now()
                    : _eventSelected[0].date,
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyle(color: Colors.white),
                  weekendStyle: TextStyle(color: Colors.pink[400]),
                ),
                calendarStyle: CalendarStyle(
                  todayColor: Colors.greenAccent,
                  todayStyle: TextStyle(
                      color: Colors.pink, fontWeight: FontWeight.bold),
                  weekdayStyle: TextStyle(color: Colors.white),
                  weekendStyle: TextStyle(color: Colors.pink[200]),
                  markersColor: Colors.pink[300],
                ),
                onDaySelected: (date, event) {
                  if (event.length > 0) {
                    changeEventSelected(event);
                  }
                },
              ),
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 10,
                      blurRadius: 8,
                      offset: Offset(1, 3),
                    ),
                  ],
                ),
                margin: EdgeInsets.only(top: 350, bottom: 10.5),
                width: 280,
                child: ListView.builder(
                  itemCount: _eventSelected.length,
                  itemBuilder: (BuildContext ctx, i) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            EventDetailScreen.routeName,
                            arguments: _eventSelected[i]);
                      },
                      child: Stack(children: [
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10, top: 15),
                          height: 190,
                          width: 290,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage(_eventSelected[i].imageUrl),
                                fit: BoxFit.cover),
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
                          padding:
                              EdgeInsets.only(top: 10, left: 10, right: 10),
                          width: 190,
                          height: 50,
                          margin:
                              EdgeInsets.only(top: 190, left: 30, bottom: 20),
                          child: Column(
                            children: [
                              Text(
                                _eventSelected[i].title,
                                style: TextStyle(
                                    color: Colors.pinkAccent,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${_eventSelected[i].location} | ${DateFormat('yyyy-MM-dd').format(_eventSelected[i].date)}',
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
                          height: 32,
                          margin: EdgeInsets.only(top: 215, left: 195),
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
                              Navigator.of(context).pushNamed(
                                  EventDetailScreen.routeName,
                                  arguments: _eventSelected[i]);
                            },
                            icon: Icon(Icons.more),
                            color: Colors.white,
                            iconSize: 13,
                          ),
                        ),
                      ]),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
