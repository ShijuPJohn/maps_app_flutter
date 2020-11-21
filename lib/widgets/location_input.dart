import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:maps_app/helpers/location_helper.dart';
import 'package:maps_app/screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function selectplace;

  const LocationInput({Key key, this.selectplace}) : super(key: key);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;

  Future<void> _getCurrentUserLocation() async {
    final locationData = await Location().getLocation();
    setState(() {
      _previewImageUrl = LocationHelper.generateLocationPreviewImage(
          longitude: locationData.longitude, latitude: locationData.latitude);
    });
    widget.selectplace(locationData.latitude, locationData.longitude);
  }

  Future<void> _selectOnMap() async {
    final LatLng selectedLocation = await Navigator.of(context).push(
        MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => MapScreen(isSelecting: true)));
    if (selectedLocation == null) {
      return;
    }
    setState(() {
      _previewImageUrl = LocationHelper.generateLocationPreviewImage(
          longitude: selectedLocation.longitude, latitude: selectedLocation.latitude);
    });
    print(selectedLocation.latitude);
    widget.selectplace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            decoration: BoxDecoration(
                border: Border.all(
              width: 1,
              color: Colors.grey,
            )),
            height: 170,
            alignment: Alignment.center,
            width: double.infinity,
            child: _previewImageUrl == null
                ? Text('No location chosen', textAlign: TextAlign.center)
                : Image.network(
                    _previewImageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: Icon(Icons.location_on),
              label: Text('Current Location'),
              textColor: Theme.of(context).primaryColor,
            ),
            FlatButton.icon(
              onPressed: _selectOnMap,
              icon: Icon(Icons.map),
              label: Text('Select Location'),
              textColor: Theme.of(context).primaryColor,
            )
          ],
        )
      ],
    );
  }
}
