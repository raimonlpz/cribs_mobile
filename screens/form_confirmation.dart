import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:robochat/providers/user_provider.dart';
import '../widgets/appbar_header.dart';
import '../services/geo_service.dart';
import '../providers/event_provider.dart';
import '../models/event.dart';

class EventProposal {
  String name;
  String location;
  DateTime date;
  String description;
  String imageUrl;

  EventProposal({
    Key key,
    this.name,
    this.location,
    this.date,
    this.description,
    this.imageUrl,
  });
}

class FormConfirmation extends StatefulWidget {
  static final routeName = '/confirmation-screen';
  createState() => _FormConfirmationState();
}

class _FormConfirmationState extends State<FormConfirmation> {
  EventProposal rawFormData;
  LocationResponse geoData;
  List<String> cleanTags = List();
  Event _defEvent;

  void didChangeDependencies() {
    final Map argumentsNav = ModalRoute.of(context).settings.arguments as Map;

    rawFormData = argumentsNav['rawFormData'];
    geoData = argumentsNav['geoInfo'];
    print(geoData.locationAddress);
    print(geoData.flag);
    print(geoData.tagsData);
    displayTags();

    _defEvent = Event(
        ownerId: 3,
        id: 2123,
        title: rawFormData.name,
        description: rawFormData.description,
        date: rawFormData.date,
        location: rawFormData.location,
        lat: geoData.latitude,
        long: geoData.longitude,
        imageUrl: rawFormData.imageUrl);

    super.didChangeDependencies();
  }

  void displayTags() {
    geoData.tagsData.map((tag) {
      if (tag != null && cleanTags.indexOf(tag) == -1 && tag != 'commerce') {
        cleanTags.add(tag);
      }
    }).toList();
  }

  Widget tagsRow() {
    return Container(
      margin: EdgeInsets.only(top: 105, left: 2.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: cleanTags
            .map(
              (tag) => new Container(
                margin: EdgeInsets.all(15),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.9),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: Offset(1, 2),
                    ),
                  ],
                ),
                child: Text('#$tag',
                    style:
                        TextStyle(fontSize: 12, fontStyle: FontStyle.italic)),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appbarHeader('Preview', Colors.black),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10, left: 10, right: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white,
                    Colors.white,
                    Colors.tealAccent,
                    Colors.white,
                  ]),
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
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 70),
              width: 285,
              height: 280,
              child: CachedNetworkImage(
                imageUrl: rawFormData.imageUrl,
                imageBuilder: (context, imageProvider) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 50),
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/img/lime4.png'),
                            fit: BoxFit.fitHeight),
                      ),
                    ),
                    Text('Image not found'),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 8,
                    offset: Offset(1, 3),
                  ),
                ],
              ),
            ),
          ),
          tagsRow(),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 13, left: 10, right: 10),
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomRight,
                    colors: [Colors.white, Colors.pink[200]]),
                borderRadius: BorderRadius.circular(60),
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    spreadRadius: 5,
                    blurRadius: 8,
                    offset: Offset(1, 3),
                  ),
                ],
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: SizedBox(
                  child: Text(
                    '${rawFormData.name}',
                    maxLines: 1,
                    style: TextStyle(
                        fontFamily: 'Dead',
                        color: Colors.black,
                        fontSize: 25,
                        fontStyle: FontStyle.italic,
                        shadows: [
                          Shadow(
                              blurRadius: 7,
                              offset: Offset(2, 3),
                              color: Colors.black.withOpacity(0.3)),
                        ]),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 340, left: 13, right: 7.5),
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Description:',
                      style: TextStyle(color: Colors.pinkAccent)),
                  Container(
                    height: 60,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Text(rawFormData.description,
                          style: TextStyle(fontSize: 14)),
                    ),
                  ),
                  Divider(
                    color: Colors.pink[100],
                  ),
                  Text(
                    'Location: ${rawFormData.location}',
                    style: TextStyle(color: Colors.pinkAccent, fontSize: 12),
                  ),
                  Divider(),
                  Text(
                      'Date: ${DateFormat('yyyy-MM-dd').format(rawFormData.date)}',
                      style: TextStyle(color: Colors.pinkAccent, fontSize: 12)),
                  Divider(
                    color: Colors.pink[100],
                  ),
                  Text('Details: ${geoData.flag} | ${geoData.locationAddress}',
                      style: TextStyle(color: Colors.grey, fontSize: 11)),
                ],
              ),
            ),
          ),
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height - 180),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    child: RaisedButton(
                      padding: EdgeInsets.all(18),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side:
                              BorderSide(color: Colors.pink[300], width: 0.5)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      color: Colors.black,
                      textColor: Colors.white,
                      child: Text(
                        'Edit',
                        style: TextStyle(
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(1.0, 1.0),
                                blurRadius: 3.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ],
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            fontFamily: 'WILD'),
                      ),
                    ),
                  ),
                  Builder(
                    builder: (ctx) => Container(
                      margin: EdgeInsets.all(10),
                      child: RaisedButton(
                        padding: EdgeInsets.all(18),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            side: BorderSide(
                                color: Colors.pink[300], width: 0.5)),
                        onPressed: () {
                          final snackBar = SnackBar(
                            backgroundColor: Colors.black,
                            duration: Duration(milliseconds: 800),
                            elevation: 6.0,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            content: Text(
                              'Adding Event to the Pool...',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                  fontFamily: 'Dead'),
                            ),
                            action: SnackBarAction(
                                label: 'UNDO',
                                textColor: Colors.pink[200],
                                onPressed: () {}),
                          );
                          Scaffold.of(ctx).showSnackBar(snackBar);

                          UserProvider user =
                              Provider.of<UserProvider>(context, listen: false);
                          user.addEventToCreated(_defEvent.id);

                          EventProvider event = Provider.of<EventProvider>(
                              context,
                              listen: false);
                          event.addEvent(_defEvent);
                        },
                        color: Colors.tealAccent,
                        textColor: Colors.white,
                        child: Text(
                          'Confirm',
                          style: TextStyle(
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(1.0, 1.0),
                                  blurRadius: 3.0,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ],
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              fontFamily: 'WILD'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
