import 'dart:io';

import 'package:GreatPlacesApp/models/place.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/great_places.dart';
import '../widgets/location_input.dart';
import '../widgets/image_input.dart';

class AddPlaceScreen extends StatefulWidget {
  AddPlaceScreen({Key key}) : super(key: key);

  static const routeName = '/add-place';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();

  File _pickedImage;
  var _validate = false;
  PlaceLocation _pickedLocation;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _savePlace() {
    if (_titleController.text.isEmpty ||
        _pickedImage == null ||
        _pickedLocation == null) {
      return; //instead we should show an error message
    }
    Provider.of<GreatPlaces>(context,
            listen:
                false) //listen false as we are not interested in updates in this place
        .addPlace(_titleController.text, _pickedImage, _pickedLocation);
    Navigator.of(context).pop();
  }

  void _selectPlace(double lat, double long) {
    _pickedLocation = PlaceLocation(latitute: lat, longitude: long);
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a New place'),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: 'Title'),
                      controller: _titleController,
                    ),
                    SizedBox(height: 10),
                    ImageInput(_selectImage),
                    SizedBox(height: 10),
                    LocationInput(_selectPlace)
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            onPressed: _savePlace,
            icon: Icon(Icons.add),
            label: Text('Add place'),
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize
                .shrinkWrap, //remove the small padding that the button has, at the bottom
            color: Theme.of(context).accentColor,
          ),
        ],
      ),
    );
  }
}
