import 'package:flutter/material.dart';
import 'event.dart';

class User {
  final int id;
  final String username;
  final String phrase;
  final String urlImage;
  final List<Event> favEvents;
  final List<Event> createdEvents;

  User({
    Key key,
    @required this.id,
    @required this.username,
    @required this.phrase,
    @required this.urlImage,
    this.favEvents,
    this.createdEvents,
  });
}

List<User> users = [
  User(
    id: 0,
    username: '@fluxglowe',
    phrase: '"The supreme art of war is to subdue the enemy"',
    urlImage: 'https://robohash.org/sds',
  ),
  User(
    id: 1,
    username: '@crispromantic',
    phrase: '"The supreme art of war is to subdue the enemy"',
    urlImage: 'https://robohash.org/sdsd',
  ),
  User(
    id: 2,
    username: '@headpeak',
    phrase: '"The supreme art of war is to subdue the enemy"',
    urlImage: 'https://robohash.org/wsdsw',
  ),
  User(
    id: 3,
    username: '@matrixchi',
    phrase: '"The supreme art of war is to subdue the enemy"',
    urlImage: 'https://robohash.org/wsdwwwsw',
  ),
  User(
    id: 4,
    username: '@monkeybullet',
    phrase: '"The supreme art of war is to subdue the enemy"',
    urlImage: 'https://robohash.org/a',
  ),
  User(
    id: 5,
    username: '@hyperspra',
    phrase: '"The supreme art of war is to subdue the enemy"',
    urlImage: 'https://robohash.org/sa',
  ),
  User(
    id: 6,
    username: '@fourdyna',
    phrase: '"The supreme art of war is to subdue the enemy"',
    urlImage: 'https://robohash.org/sadd',
  ),
  User(
    id: 7,
    username: '@numeroce43',
    phrase: '"The supreme art of war is to subdue the enemy"',
    urlImage: 'https://robohash.org/saddddd',
  ),
  User(
    id: 8,
    username: '@babixkaz',
    phrase: '"The supreme art of war is to subdue the enemy"',
    urlImage: 'https://robohash.org/xxs',
  ),
];
