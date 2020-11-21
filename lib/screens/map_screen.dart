import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;
  static const id = 'map_screen';

  MapScreen(
      {this.initialLocation =
          const PlaceLocation(latitude: 37.42, longitude: -122.084),
      this.isSelecting = false});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
        actions: [
          widget.isSelecting
              ? IconButton(
                  icon: Icon(Icons.check),
                  onPressed: _pickedLocation == null
                      ? null
                      : () {
                          Navigator.of(context).pop(_pickedLocation);
                        })
              : null
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
            zoom: 16,
            target: LatLng(widget.initialLocation.latitude,
                widget.initialLocation.longitude)),
        onTap: widget.isSelecting ? _selectLocation : null,
        markers: _pickedLocation == null
            ? null
            : {Marker(markerId: MarkerId('m1'), position: _pickedLocation)},
      ),
    );
  }
}
