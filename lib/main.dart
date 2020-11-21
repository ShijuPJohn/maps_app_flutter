import 'package:flutter/material.dart';
import 'package:maps_app/screens/add_place_screen.dart';
import 'package:maps_app/screens/place_details_screen.dart';
import 'package:maps_app/screens/places_list_screen.dart';
import 'package:provider/provider.dart';

import './providers/great_places.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
        initialRoute: PlacesListScreen.id,
        routes: {
          AddPlaceScreen.id: (context) => AddPlaceScreen(),
          PlacesListScreen.id: (context) => PlacesListScreen(),
          PlaceDetailsScreen.id:(context)=>PlaceDetailsScreen(),
        },
        title: 'Great Places',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
        ),
      ),
    );
  }
}
