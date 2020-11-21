import 'dart:io';

import 'package:flutter/material.dart';
import 'package:maps_app/providers/great_places.dart';
import 'package:maps_app/screens/map_screen.dart';
import 'package:provider/provider.dart';

class PlaceDetailsScreen extends StatelessWidget {
  static const id = 'place_details_screen';

  @override
  Widget build(BuildContext context) {
    final id = (ModalRoute.of(context).settings.arguments
        as Map<String, String>)['id'];
    final place =
        Provider.of<GreatPlaces>(context, listen: false).fetchPlaceById(id);
    return Scaffold(
        appBar: AppBar(
          title: Text('Place Details'),
        ),
        body: Column(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              child: Image.file(
                place.image,
                fit: BoxFit.contain,
                width: double.infinity,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              width: double.infinity,
              child: Text(place.title),
            ),
            Container(
              height: 40,
              width: double.infinity,
              child: Text(place.location.address),
            ),
            SizedBox(
              height: 10,
            ),
            FlatButton.icon(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          MapScreen(initialLocation: place.location),
                      fullscreenDialog: true));
                },
                icon: Icon(Icons.map),
                label: Text('View on map')),
          ],
        ));
  }
}
