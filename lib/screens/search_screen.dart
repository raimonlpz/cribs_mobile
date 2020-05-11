import 'package:flutter/material.dart';
import '../widgets/event_card.dart';
import '../widgets/appbar_header.dart';
import '../models/event.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';

class SearchScreen extends StatelessWidget {
  static final routeName = '/search-screen';

  Future<List<Event>> search(String search) async {
    await Future.delayed(Duration(seconds: 2));
    return List.generate(search.length, (int index) {
      return Event(
          id: 0,
          title: '',
          imageUrl: '',
          location: '',
          date: '',
          ownerId: 1,
          description: '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarHeader('Search', Colors.black),
      body: Stack(
        children: [
          SearchBar(
            onSearch: search,
            onItemFound: (Event post, int index) {
              return ListTile(
                title: Text(post.title),
                subtitle: Text(post.description),
              );
            },
          ),
          Container(
            margin: EdgeInsets.only(top: 75, bottom: 5),
            child: ListView.builder(
              itemCount: events.length,
              itemBuilder: (BuildContext context, i) {
                return EventCard(events[i]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
