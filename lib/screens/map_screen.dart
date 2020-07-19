import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;

  final bool isSelecting;

  MapScreen(
      {this.initialLocation =
          const PlaceLocation(latitute: 37.422, longitude: -122.084),
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
        title: Text('Your Map'),
        actions: <Widget>[
          if (widget.isSelecting)
            IconButton(
              icon: Icon(Icons.check),
              onPressed: _pickedLocation == null
                  ? null
                  : () {
                      Navigator.of(context).pop(
                          _pickedLocation); //we return the pickedLocaiton when dismissing the screen
                    },
            )
        ],
      ),
      body: GoogleMap(
        //GoofleMap assumes the width and height of the parrent widget
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitute,
            widget.initialLocation.longitude,
          ),
          zoom: 16,
        ),
        onTap: widget.isSelecting ? _selectLocation : null,
        markers: (_pickedLocation == null &&
                widget.isSelecting) //markers returns a SET = similar to Map?dicitonary withouth a key, so like an array but won't add the same value twice (can't have duplications)
            ? null
            : {
                Marker(
                  // is a maker on the map
                  markerId: MarkerId('m1'),
                  position: _pickedLocation ?? LatLng(widget.initialLocation.latitute, widget.initialLocation.longitude), // ?? = if null, then what is after ??
                ),
              },
      ),
    );
  }
}
