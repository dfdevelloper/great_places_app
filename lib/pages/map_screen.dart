import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places_app/models/places.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initalLocation;
  final bool isReadonly;

  MapScreen({
    this.initalLocation = const PlaceLocation(
      latitude: -18.9113,
      longitude: -48.2622,
    ),
    this.isReadonly = false,
  });

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedPosition;

  void _selectPosition(LatLng position) {
    setState(() {
      _pickedPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecione...'),
        actions: <Widget>[
          if (!widget.isReadonly)
            IconButton(
              onPressed: _pickedPosition == null
                  ? null
                  : () => Navigator.of(context).pop(_pickedPosition),
              icon: Icon(Icons.check),
            )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initalLocation.latitude,
            widget.initalLocation.longitude,
          ),
          zoom: 13,
        ),
        onTap: widget.isReadonly ? null : _selectPosition,
        markers: {
          Marker(
            markerId: MarkerId('p1'),
            position: _pickedPosition ?? widget.initalLocation.toLatLng(),
          )
        },
      ),
    );
  }
}
