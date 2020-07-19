import 'package:flutter/foundation.dart';

import 'dart:io'; //enable us to use File type

class PlaceLocation {
  final double latitute;
  final double longitude;
  final String address;

  const PlaceLocation({
    @required this.latitute,
    @required this.longitude,
    this.address,
  });
}

class Place {
  final String id;
  final String title;
  final File image; //we store the image on our device, hence we use File
  final PlaceLocation location;

  Place({
    @required this.id,
    @required this.title,
    @required this.image,
    @required this.location,
  });
}
