import 'dart:io';

import 'package:flutter/foundation.dart';

import '../models/place.dart';
import '../helpers/data_base_helper.dart';
import '../helpers/location_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items]; //return a copy of the items
  }

  Place findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future addPlace(
      String title, File image, PlaceLocation pickedLocation) async {
    final humanReadableAddress = await LocationHelper.getPlaceAddress(
        pickedLocation.latitute, pickedLocation.longitude);
    final updatedLocation = PlaceLocation(
        latitute: pickedLocation.latitute,
        longitude: pickedLocation.longitude,
        address: humanReadableAddress);
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      image: image,
      location: updatedLocation,
    );
    _items.add(newPlace);
    notifyListeners();
    DataBaseHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitute,
      'loc_long': newPlace.location.longitude,
      'address': newPlace.location.address
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DataBaseHelper.getData('user_places');
    _items = dataList
        .map(
          (item) => Place(
            id: item[
                'id'], //these are the keys created in DataBaseHelper, static Future<Database> dataBase() async and they have to match what wuth wath we insert above
            title: item['title'],
            image: File(item[
                'image']), //here we don't need just the path, but the file, hence we use File(path) which will create a file based on that path
            location: PlaceLocation(
              latitute: item['loc_lat'],
              longitude: item['loc_long'],
              address: item['address'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }
}
