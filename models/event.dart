import 'package:flutter/material.dart';

class Event {
  final int id;
  final String title;
  final String description;
  final int ownerId;
  final DateTime date;
  final String location;
  final String imageUrl;
  final double lat;
  final double long;

  Event({
    Key key,
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.ownerId,
    @required this.date,
    @required this.location,
    @required this.imageUrl,
    @required this.lat,
    @required this.long,
  });
}

Event getEventFromId(List<Event> events, int id) {
  return events.firstWhere((event) => event.id == id);
}

List<Event> events = [
  Event(
    id: 01,
    title: 'Resident Red Room',
    description:
        '343 describes itself as an artist-focused, feminist-led, queer arts space, housing recording studios, a practice space, a radio station and more. The pandemic forced 343 to close.',
    ownerId: 0,
    date: DateTime(2020, 5, 31),
    location: 'Paris, FR',
    lat: 41.501401,
    long: 2.1317263,
    imageUrl:
        'https://djanemag.com/sites/default/files/styles/full/public/p07j4ww0.jpg?itok=_WwDpV5y',
  ),
  Event(
    id: 02,
    title: 'Music Fest Phi Center',
    description:
        'Bandcamp has emerged as one of the most ethical platforms for buying music, with a favourable fee structure that means most money spent on Bandcamp goes directly to the artist or label.',
    ownerId: 0,
    date: DateTime(2020, 5, 4),
    location: 'Lisbon, PR',
    lat: 41.3893913,
    long: 2.1862896,
    imageUrl:
        'https://images.squarespace-cdn.com/content/588a35d4ff7c5080faead7ce/1585299883945-51P0QS3CD7O0KFFR9NX0/RA+Quarantine.png?content-type=image%2Fpng',
  ),
  Event(
    id: 03,
    title: 'Live Session DJ Kwan',
    description:
        'You might be familiar with aidnq, if not for his work with Truants then with Bandcloud, the weekly newsletter where he shares his favourite music from Bandcamp and SoundCloud.',
    ownerId: 0,
    date: DateTime(2020, 5, 1),
    location: 'Barcelona, SP',
    lat: 41.475914,
    long: 2.0952533,
    imageUrl:
        'https://www.residentadvisor.net/images/news/2020/matthew-w-calm-stiege-point-blank-resident-advisor-scholarship-2.jpg',
  ),
  Event(
    id: 04,
    title: 'New Baseline DJ',
    description:
        'The German is, by and large, a deep house producer. You can hear this in the synths, chords and atmospheres he has used in his music for the past ten years, and its there in the watercolour moods of "Slu Terms."',
    ownerId: 1,
    date: DateTime(2020, 5, 31),
    location: 'Berlin, GR',
    lat: 41.3957491,
    long: 2.1901236,
    imageUrl: 'https://m.media-amazon.com/images/I/81Cz0iNqYOL._SS500_.jpg',
  ),
  Event(
    id: 05,
    title: 'Longturn Night music',
    description:
        'In the second edition of Self-Isolation 101, a video series dreamt up for this strange era, DJs, producers and people across dance music world share their tips for making the most of all those hours at home.',
    ownerId: 1,
    date: DateTime(2020, 5, 21),
    location: 'London, UK',
    lat: 41.3977199,
    long: 2.1889168,
    imageUrl:
        'https://afemusicblog.files.wordpress.com/2020/03/e43abba3-a3b5-4bc8-901d-2c7c57d069c0.jpg?w=584',
  ),
  Event(
    id: 06,
    title: 'Berlin Atonal Techno',
    description:
        'Alongside Richard H. Kirk and Chris Watson, Stephen Mallinder was a founding member of Cabaret Voltaire. Like the pioneering Sheffield group themselves.',
    ownerId: 1,
    date: DateTime(2020, 5, 6),
    location: 'Berlin, GR',
    lat: 41.3780556,
    long: 2.1728113,
    imageUrl:
        'https://okdiario.com/img/2018/08/10/berlin-atonal-2018-655x368.jpg',
  ),
  Event(
    id: 07,
    title: 'Sónar Forum Barcelona',
    description:
        'In conversation, we hear of the cultural inputs that shaped Mallinders outlook and the germ cells of the musical movements in which he took part.',
    ownerId: 1,
    date: DateTime(2020, 5, 22),
    location: 'Barcelona, SP',
    lat: 41.3743992,
    long: 2.1673775,
    imageUrl:
        'https://images.theconversation.com/files/63840/original/3f6xbp4c-1415249107.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=926&fit=clip',
  ),
];
