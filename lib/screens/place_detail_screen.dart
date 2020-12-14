import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/great_places.dart';
import '../screens/map_screen.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = '/placeDetailScreen';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final place = Provider.of<GreatPlaces>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              place.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            place.location.address,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
          SizedBox(
            height: 10,
          ),
          FlatButton(
            textColor: Theme.of(context).primaryColor,
            child: Text('View on Map'),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (ctx) => MapScreen(
                          initialLocation: place.location,
                          isSelecting: false,
                        ),
                    fullscreenDialog: true),
              );
            },
          ),
        ],
      ),
    );
  }
}
