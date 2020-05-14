import 'package:flutter/material.dart';
import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  final User _user = User(
    id: 0,
    username: '@raimonlpez',
    phrase: '"The supreme art of war is to subdue the enemy"',
    urlImage: 'https://robohash.org/dsss',
    favEvents: [],
    createdEvents: [],
  );

  User get user => _user;

  void addEventToFavs(int id) {
    try {
      int oldID = _user.favEvents.firstWhere((_id) => _id == id);
      print('Event already added to favs. ID: $oldID');
    } catch (err) {
      _user.favEvents.add(id);
      print('LIST UPDATED:');
      _user.favEvents.forEach((event) => print(event));
      notifyListeners();
    }
  }

  bool isEventAlreadySaved(int id) {
    try {
      _user.favEvents.firstWhere((_id) => _id == id);
      return true;
    } catch (err) {
      return false;
    }
  }

  void removeEventFromFavs(int id) {
    _user.favEvents.removeWhere((_id) => _id == id);
    notifyListeners();
  }

  void addEventToCreated(int id) {
    _user.createdEvents.add(id);
    notifyListeners();
  }
}
