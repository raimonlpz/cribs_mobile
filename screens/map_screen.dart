import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../widgets/appbar_header.dart';
import '../models/event.dart';

class MapScreen extends StatefulWidget {
  static final routeName = '/map-screen';
  createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Event event;
  Set<Circle> _circles = HashSet<Circle>();
  Completer<GoogleMapController> _controller = Completer();

  @override
  didChangeDependencies() {
    event = ModalRoute.of(context).settings.arguments;
    _setCircle();
    super.didChangeDependencies();
  }

  void _setCircle() {
    _circles.add(Circle(
        circleId: CircleId('00'),
        consumeTapEvents: true,
        center: LatLng(event.lat, event.long),
        radius: 200,
        fillColor: Color.fromRGBO(143, 254, 223, 0.7),
        strokeWidth: 2,
        onTap: () {
          print('hey');
        }));
  }

  void _onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);

    String style = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');

    controller.setMapStyle(style);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbarHeader('Location', Colors.black),
        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 70, right: 20, left: 20, bottom: 55),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white,
                      Colors.tealAccent,
                      Colors.white,
                      Colors.pink[100],
                      Colors.white,
                    ]),
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
                margin: EdgeInsets.only(top: 20, left: 35),
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
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(event.imageUrl),
                  ),
                  title: Text(event.location, style: TextStyle(fontSize: 15)),
                  trailing: Icon(Icons.location_on, color: Colors.black),
                ),
                height: 60,
                width: 250),
            Container(
              margin: EdgeInsets.only(top: 85, bottom: 70, right: 35, left: 35),
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
                  target: LatLng(event.lat, event.long),
                  zoom: 13.476,
                ),
                circles: _circles,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
              ),
            )
          ],
        ));
  }
}
