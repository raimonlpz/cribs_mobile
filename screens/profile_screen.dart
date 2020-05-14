import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'event_detail_screen.dart';
import '../widgets/appbar_header.dart';
import 'package:geolocator/geolocator.dart';
import '../models/event.dart';

class ProfileScreen extends StatefulWidget {
  static final routeName = '/profile-screen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final List<Event> eventList = events;
  Position position;
  Set<Circle> _circles = HashSet<Circle>();
  Completer<GoogleMapController> _controller = Completer();
  String _infoEvent;
  String _imageEvent;
  Event _eventData;
  bool _isButtonDisabled;

  Future<Position> getLocation() async {
    Position _position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      position = _position;
    });
    return _position;
  }

  void _setCircles(position) {
    eventList.map((event) {
      _circles.add(
        Circle(
            circleId: CircleId('${event.id}'),
            center: LatLng(event.lat, event.long),
            radius: 300,
            fillColor: Color.fromRGBO(125, 224, 142, 0.4),
            strokeWidth: 2,
            consumeTapEvents: true,
            onTap: () {
              setState(() {
                _imageEvent = event.imageUrl;
                _infoEvent = event.title;
                _eventData = event;
                _isButtonDisabled = false;
              });
            }),
      );
    }).toList();

    _circles.add(
      Circle(
          circleId: CircleId('00'),
          consumeTapEvents: true,
          center: LatLng(position.latitude, position.longitude),
          radius: 600,
          fillColor: Color.fromRGBO(255, 124, 142, 0.5),
          strokeWidth: 2,
          onTap: () {
            setState(() {
              _imageEvent = 'https://robohash.org/gososds';
              _infoEvent = 'YOU ARE HERE!';
              _isButtonDisabled = true;
            });
          }),
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);

    String style = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');

    controller.setMapStyle(style);
  }

  @override
  initState() {
    getLocation().then((position) {
      _setCircles(position);
    });

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarHeader('Profile', Colors.black),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomRight,
              colors: [Colors.white, Colors.black45]),
        ),
        child: Stack(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 20, left: 20, right: 15),
                  width: 85,
                  height: 85,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/img/robo1.png'),
                    ),
                    border: Border.all(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 40),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.expand(width: 200, height: 80),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('@username777',
                            textAlign: TextAlign.start,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                        Text(
                          '"The supreme art of war is to subdue the enemy without fighting." 💀👽',
                          style: TextStyle(
                              fontSize: 12, fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 135),
              child: Text(
                'EVENTS NEAR YOU',
                style: TextStyle(
                    fontFamily: 'WILD',
                    fontSize: 12,
                    fontStyle: FontStyle.italic),
              ),
            ),
            position != null
                ? Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: 175,
                            right: 20,
                            left: 20,
                            bottom: 55), //MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 10,
                              blurRadius: 8,
                              offset: Offset(1, 3),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: 190, bottom: 70, right: 35, left: 35),
                        decoration: BoxDecoration(
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
                        height: MediaQuery.of(context).size.height - 160,
                        child: GoogleMap(
                          onMapCreated: _onMapCreated,
                          initialCameraPosition: CameraPosition(
                            target:
                                LatLng(position.latitude, position.longitude),
                            zoom: 13.476,
                          ),
                          circles: _circles,
                          myLocationEnabled: true,
                          myLocationButtonEnabled: true,
                        ),
                      )
                    ],
                  )
                : Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.black,
                    ),
                  ),
            _infoEvent != null && _imageEvent != null
                ? Center(
                    child: Container(
                        margin: EdgeInsets.only(bottom: 230, left: 95),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Colors.black,
                            width: 0.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 3,
                              offset: Offset(1, 3),
                            ),
                          ],
                        ),
                        child: ListTile(
                          onTap: () {
                            if (!_isButtonDisabled) {
                              Navigator.of(context).pushNamed(
                                  EventDetailScreen.routeName,
                                  arguments: _eventData);
                            }
                          },
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(_imageEvent),
                          ),
                          title:
                              Text(_infoEvent, style: TextStyle(fontSize: 15)),
                          trailing: Icon(Icons.keyboard_arrow_right,
                              color: Colors.black),
                        ),
                        height: 60,
                        width: 250),
                  )
                : SizedBox(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 20,
        onPressed: () {},
        backgroundColor: Colors.black,
        child: Icon(
          Icons.settings,
          color: Colors.white,
        ),
      ),
    );
  }
}
