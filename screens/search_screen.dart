import 'package:flutter/material.dart';
import '../widgets/event_card.dart';
import '../widgets/appbar_header.dart';
import '../models/event.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

class SearchScreen extends StatefulWidget {
  static final routeName = '/search-screen';
  createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String valueSearch;
  List<Event> eventsFiltered = events;
  bool searchMode = false;

  @override
  void initState() {
    super.initState();
    KeyboardVisibilityNotification().addNewListener(onHide: () {
      FocusScope.of(context).requestFocus(new FocusNode());
    });
  }

  void _onChange(String value) {
    setState(() {
      valueSearch = value.toLowerCase();
      eventsFiltered = events.where((event) {
        return event.title.toLowerCase().contains(valueSearch);
      }).toList();

      valueSearch.length > 0 ? searchMode = true : searchMode = false;
    });
    if (valueSearch.length == 0) {
      Navigator.of(context).pop();
      Navigator.of(context).pushNamed(SearchScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appbarHeader('Search', Colors.black),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(5),
            child: TextFormField(
              onChanged: (val) => _onChange(val),
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 1.0, horizontal: 15.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.greenAccent, width: 2.0),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.pink[200], width: 2.0),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Search event',
              ),
              maxLines: 1,
              textInputAction: TextInputAction.search,
              //controller: _controller,
            ),
          ),
          eventsFiltered.length > 0
              ? new Container(
                  margin: EdgeInsets.only(top: 60, bottom: 5),
                  child: new ListView.builder(
                    itemCount: eventsFiltered.length,
                    itemBuilder: (BuildContext context, ind) {
                      return new EventCard(eventsFiltered[ind], searchMode);
                    },
                  ),
                )
              : Center(child: Text('Event Not Found')),
        ],
      ),
    );
  }
}
