import 'dart:io'; //to use data stored on device

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  ImageInput({Key key}) : super(key: key);

  @override
  _ImageInputState createState() => _ImageInputState();
}

Future<void> _takePicture() async {
  final picker =
      ImagePicker(); // Provides an easy way to pick an image/video from the image library or take a picture/vide with the camera
  final imageFile = await picker.getImage(
    source: ImageSource.camera,
    maxWidth: 600,
  );
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: Colors.grey,
            ),
          ),
          child: _storedImage != null
              ? Image.file(
                  //Image.file to acces image stored on the device
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'No image taken',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(width: 10),
        Expanded(
            child: FlatButton.icon(
          icon: Icon(Icons.camera),
          label: Text('Take picture'),
          textColor: Theme.of(context).primaryColor,
          onPressed: _takePicture,
        )),
      ],
    );
  }
}
