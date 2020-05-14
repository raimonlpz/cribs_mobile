import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import '../widgets/appbar_header.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;

class CalendarScreen extends StatelessWidget {
  static final routeName = '/calendar-screen';

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarHeader('Calendar', Colors.black),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 190),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
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
            margin: EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 200),
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
            child: CalendarCarousel<Event>(
              onDayPressed: (DateTime date, List<Event> events) {},
              weekendTextStyle: TextStyle(
                color: Colors.pink[100],
              ),
              daysTextStyle:
                  TextStyle(fontFamily: 'Carmorant', color: Colors.pink[100]),
              thisMonthDayBorderColor: Colors.grey,
              weekdayTextStyle:
                  TextStyle(color: Colors.pink[100], fontSize: 15),
              weekFormat: false,
              height: 420.0,
              daysHaveCircularBorder: true,
              todayButtonColor: Colors.pink[100],
              todayBorderColor: Colors.pink[100],
              todayTextStyle: TextStyle(color: Colors.black),
              headerTextStyle: TextStyle(
                  color: Colors.pink[100], fontSize: 22, fontFamily: 'WILD'),
            ),
          ),
        ],
      ),
    );
  }
}
