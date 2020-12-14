import 'package:http/http.dart' as http;
import 'dart:convert';

const GOOGLE_API_KEY = 'AIzaSyCt7ngx6mpo7GUTV7DgPnlJVj1K6U09Zv0';
const GOOGLE_API_KEY1 = 'AIzaSyDOhpEGceCXx0YOKoFmNHmGP2zWJE_J8v8';
const MAPBOX_API_KEY =
    'pk.eyJ1IjoiZGVsaW51eGlzdDEiLCJhIjoiY2tpbjNrbzQ1MHhycjJ2cDlsZWcyd294dSJ9.jr6RLvdOLW9sEemV3QHt1w';
const TOMTOM_API_KEY = 'afXtDAN3VAB0VJGCOGW2CqGE2Bq5GXE0';

class LocationHelper {
  static String generateLocationImage({double latitude, double longitude}) {
    // return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY1';
    // return 'https://api.mapbox.com/styles/v1/mapbox/light-v10/static/$longitude,$latitude,10/500x300?access_token=$MAPBOX_API_KEY';
    return 'http://api.tomtom.com/map/1/staticimage?key=$TOMTOM_API_KEY&zoom=14&center=$longitude,$latitude&format=jpg&layer=basic&style=main&width=1305&height=748&view=Unified&language=en-GB';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    // final url =
    //     'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY';

    final url =
        'https://api.mapbox.com/geocoding/v5/mapbox.places/$lng,$lat.json?access_token=$MAPBOX_API_KEY';

    final response = await http.get(url);
    return json.decode(response.body)['features'][0]['place_name'];
  }
}
