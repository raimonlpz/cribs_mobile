import 'package:flutter/material.dart';

class User {
  final int id;
  final String username;
  final String phrase;
  final String urlImage;
  final List<int> favEvents;
  final List<int> createdEvents;

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
    username: '@raimonlpez',
    phrase: '"The supreme art of war is to subdue the enemy"',
    urlImage: 'https://robohash.org/dsss',
    favEvents: [],
    createdEvents: [],
  ),
  User(
    id: 1,
    username: '@fluxglowe',
    phrase: '"The supreme art of war is to subdue the enemy"',
    urlImage: 'https://robohash.org/sds',
  ),
  User(
    id: 2,
    username: '@crispromantic',
    phrase: '"The supreme art of war is to subdue the enemy"',
    urlImage: 'https://robohash.org/sdsd',
  ),
  User(
    id: 3,
    username: '@headpeak',
    phrase: '"The supreme art of war is to subdue the enemy"',
    urlImage: 'https://robohash.org/wsdsw',
  ),
  User(
    id: 4,
    username: '@matrixchi',
    phrase: '"The supreme art of war is to subdue the enemy"',
    urlImage: 'https://robohash.org/wsdwwwsw',
  ),
  User(
    id: 5,
    username: '@monkeybullet',
    phrase: '"The supreme art of war is to subdue the enemy"',
    urlImage: 'https://robohash.org/a',
  ),
  User(
    id: 6,
    username: '@hyperspra',
    phrase: '"The supreme art of war is to subdue the enemy"',
    urlImage: 'https://robohash.org/sa',
  ),
  User(
    id: 7,
    username: '@fourdyna',
    phrase: '"The supreme art of war is to subdue the enemy"',
    urlImage: 'https://robohash.org/sadd',
  ),
  User(
    id: 8,
    username: '@numeroce43',
    phrase: '"The supreme art of war is to subdue the enemy"',
    urlImage: 'https://robohash.org/saddddd',
  ),
  User(
    id: 9,
    username: '@babixkaz',
    phrase: '"The supreme art of war is to subdue the enemy"',
    urlImage: 'https://robohash.org/xxs',
  ),
];
