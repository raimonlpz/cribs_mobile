import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/home.dart';
import 'screens/profile_screen.dart';
import 'screens/events_screen.dart';
import 'screens/create_screen.dart';
import 'screens/calendar_screen.dart';
import 'screens/search_screen.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black,
    statusBarColor: Colors.black,
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cybertea',
      theme: ThemeData(
        primaryIconTheme: IconThemeData(color: Colors.white),
        primarySwatch: Colors.pink,
        fontFamily: 'Cormorant',
      ),
      home: Home(),
      routes: {
        ProfileScreen.routeName: (ctx) => ProfileScreen(),
        EventsScreen.routeName: (ctx) => EventsScreen(),
        CreateScreen.routeName: (ctx) => CreateScreen(),
        CalendarScreen.routeName: (ctx) => CalendarScreen(),
        SearchScreen.routeName: (ctx) => SearchScreen(),
      },
    );
  }
}
