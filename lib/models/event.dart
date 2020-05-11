import 'package:flutter/material.dart';

class Event {
  final int id;
  final String title;
  final String description;
  final int ownerId;
  final String date;
  final String location;
  final String imageUrl;

  Event({
    Key key,
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.ownerId,
    @required this.date,
    @required this.location,
    @required this.imageUrl,
  });
}

List<Event> events = [
  Event(
    id: 01,
    title: 'Resident Red Room',
    description: 'Tech musician from Hong Kong live concert',
    ownerId: 0,
    date: '02/05/2020',
    location: 'Paris, FR',
    imageUrl:
        'https://djanemag.com/sites/default/files/styles/full/public/p07j4ww0.jpg?itok=_WwDpV5y',
  ),
  Event(
    id: 02,
    title: 'Music Fest Phi Center',
    description: 'Tech musician from Hong Kong live concert',
    ownerId: 0,
    date: '30/09/2019',
    location: 'Lisbon, PR',
    imageUrl:
        'https://images.squarespace-cdn.com/content/588a35d4ff7c5080faead7ce/1585299883945-51P0QS3CD7O0KFFR9NX0/RA+Quarantine.png?content-type=image%2Fpng',
  ),
  Event(
    id: 03,
    title: 'Live Session DJ Kwan',
    description: 'Tech musician from Hong Kong live concert',
    ownerId: 0,
    date: '12/04/2020',
    location: 'Barcelona, SP',
    imageUrl:
        'https://www.residentadvisor.net/images/news/2020/matthew-w-calm-stiege-point-blank-resident-advisor-scholarship-2.jpg',
  ),
  Event(
    id: 04,
    title: 'New Baseline DJ',
    description: 'Tech musician from Hong Kong live concert',
    ownerId: 1,
    date: '09/12/2022',
    location: 'Berlin, GR',
    imageUrl: 'https://m.media-amazon.com/images/I/81Cz0iNqYOL._SS500_.jpg',
  ),
  Event(
    id: 05,
    title: 'Longturn Night music',
    description: 'Tech musician from Hong Kong live concert',
    ownerId: 1,
    date: '12/03/2021',
    location: 'London, UK',
    imageUrl:
        'https://afemusicblog.files.wordpress.com/2020/03/e43abba3-a3b5-4bc8-901d-2c7c57d069c0.jpg?w=584',
  ),
  Event(
    id: 06,
    title: 'Berlin Atonal Technno',
    description: 'Tech musician from Hong Kong live concert',
    ownerId: 1,
    date: '04/09/2021',
    location: 'Berlin, GR',
    imageUrl:
        'https://okdiario.com/img/2018/08/10/berlin-atonal-2018-655x368.jpg',
  ),
  Event(
    id: 07,
    title: 'Sonar Forum 20',
    description: 'Tech musician from Hong Kong live concert',
    ownerId: 1,
    date: '31/04/2022',
    location: 'Barcelon, SP',
    imageUrl:
        'https://images.theconversation.com/files/63840/original/3f6xbp4c-1415249107.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=926&fit=clip',
  ),
];
