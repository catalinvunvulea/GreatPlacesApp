import 'dart:io'; //to use data stored on device

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as sysPath;


class ImageInput extends StatefulWidget {
  
  final Function onSelectImage;

  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}



class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> _takePicture() async {
  final picker =
      ImagePicker(); // Provides an easy way to pick an image/video from the image library or take a picture/vide with the camera
  final imageFile = await picker.getImage( //the palce when the picture will be stored once taken, for now; this is just the virtual memory
    source: ImageSource.camera,
    maxWidth: 600,
  );
  if (imageFile == null) { //as the image file will return null if we open the camer and don't take a picture, we need to stop the code here
    return;
  }
 setState(() {
   _storedImage = File(imageFile.path); //File(x.path) converts the picked file to a regular file
 });
  final appDirectory = await sysPath.getApplicationDocumentsDirectory(); //we set the path where the data should be saved
  final fileName = path.basename(imageFile.path); //we store the name of the picture,
  final savedImage = await File(imageFile.path).copy('${appDirectory.path}/$fileName'); //we copy the file (image in our case) on the device, first the location ${} and then name /$
  widget.onSelectImage(savedImage);
}


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
