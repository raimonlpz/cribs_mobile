import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../widgets/appbar_header.dart';
import 'package:geolocator/geolocator.dart';

class ProfileScreen extends StatefulWidget {
  static final routeName = '/profile-screen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Position position;
  Set<Circle> _circles = HashSet<Circle>();
  Completer<GoogleMapController> _controller = Completer();

  Future<Position> getLocation() async {
    Position _position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      position = _position;
    });
    return _position;
  }

  void _setCircles(position) {
    _circles.add(
      Circle(
        circleId: CircleId("0"),
        center: LatLng(position.latitude, position.longitude),
        radius: 600,
        fillColor: Color.fromRGBO(255, 124, 142, 0.5),
        strokeWidth: 2,
      ),
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
              margin: EdgeInsets.only(top: 130),
              child: Text(
                'YOUR LOCATION',
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
                          // border: Border.all(
                          //   color: Colors.black,
                          //   width: 4.5,
                          // ),
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
                          // myLocationEnabled: true,
                          // myLocationButtonEnabled: true,
                        ),
                      )
                    ],
                  )
                : Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.black,
                    ),
                  ),
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
