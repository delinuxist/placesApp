const GOOGLE_API_KEY = 'AIzaSyCt7ngx6mpo7GUTV7DgPnlJVj1K6U09Zv0';

class LocationHelper {
  static String generateLocationImage({double latitude, double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }
}
