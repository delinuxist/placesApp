import 'package:flutter/material.dart';
import 'package:placesApp/screens/place_detail_screen.dart';
import 'package:provider/provider.dart';

import './screens/places_list_screen.dart';
import './providers/great_places.dart';
import './screens/add_place_screen.dart';
import './screens/place_detail_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: GreatPlaces(),
        )
      ],
      child: MaterialApp(
        title: 'Places',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          accentColor: Colors.teal,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: PlacesList(),
        routes: {
          AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
          PlaceDetailScreen.routeName: (ctx) => PlaceDetailScreen(),
        },
      ),
    );
  }
}
