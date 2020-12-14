import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  ImageInput(this.onSelectImage);
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;
  bool _selectedGallery = false;

  Future<void> _takePicture() async {
    final imageFile = _selectedGallery == true
        ? await ImagePicker.pickImage(
            source: ImageSource.gallery,
            maxWidth: 600,
          )
        : await ImagePicker.pickImage(
            source: ImageSource.camera,
            maxWidth: 600,
          );
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = imageFile;
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await imageFile.copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  void imagePickerSelector() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 100,
            padding: const EdgeInsets.all(10.0),
            color: Theme.of(context).accentColor,
            child: Column(children: [
              Text(
                'Choose Photo',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FlatButton.icon(
                      icon: Icon(Icons.camera),
                      label: Text('Camera'),
                      onPressed: () {
                        _selectedGallery = false;
                        _takePicture();
                        Navigator.of(context).pop();
                      }),
                  FlatButton.icon(
                    icon: Icon(FontAwesomeIcons.images),
                    label: Text('Gallery'),
                    onPressed: () {
                      _selectedGallery = true;
                      _takePicture();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              )
            ]),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'No Image Taken',
                ),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: FlatButton.icon(
            icon: Icon(
              Icons.image,
            ),
            label: Text(
              'Add Image',
            ),
            onPressed: imagePickerSelector,
          ),
        )
      ],
    );
  }
}
