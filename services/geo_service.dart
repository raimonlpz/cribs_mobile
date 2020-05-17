// API LAT/LONG https://opencagedata.com/
import 'dart:convert';
import 'package:http/http.dart' show Client;

class LocationResponse {
  String locationAddress;
  double latitude;
  double longitude;
  String flag;
  List<String> tagsData;

  LocationResponse({
    this.locationAddress,
    this.latitude,
    this.longitude,
    this.flag,
    this.tagsData,
  });
}

class GeoService {
  Client client = Client();
  String _url = 'https://api.opencagedata.com/geocode/v1/json';
  String _apiKey = 'cacc52710ee5489c95a5840b9cdf8631';

  Future<LocationResponse> fetchLocation(String location) async {
    final response = await client.get('$_url?q=$location&key=$_apiKey');
    final responseDecoded = json.decode(response.body);

    try {
      final shortTag = responseDecoded['results'][0]['components'];
      final locationObject = LocationResponse(
        locationAddress: responseDecoded['results'][0]['formatted'],
        latitude: responseDecoded['results'][0]['geometry']['lat'],
        longitude: responseDecoded['results'][0]['geometry']['lng'],
        flag: responseDecoded['results'][0]['annotations']['flag'],
        tagsData: [
          shortTag['_category'],
          shortTag['_type'],
          shortTag['city_district'],
          shortTag['neighbourhood']
        ],
      );
      return locationObject;
    } catch (err) {
      return null;
    }
  }
}
