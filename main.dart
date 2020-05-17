import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'screens/home.dart';
import 'screens/profile_screen.dart';
import 'screens/events_screen.dart';
import 'screens/create_screen.dart';
import 'screens/calendar_screen.dart';
import 'screens/search_screen.dart';
import 'screens/event_detail_screen.dart';
import 'screens/form_confirmation.dart';
import 'screens/map_screen.dart';
import 'providers/user_provider.dart';
import 'providers/event_provider.dart';

void main() {
  runApp(MyApp());

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: UserProvider(),
        ),
        ChangeNotifierProvider.value(
          value: EventProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cribs',
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
          EventDetailScreen.routeName: (ctx) => EventDetailScreen(),
          FormConfirmation.routeName: (ctx) => FormConfirmation(),
          MapScreen.routeName: (ctx) => MapScreen(),
        },
      ),
    );
  }
}
