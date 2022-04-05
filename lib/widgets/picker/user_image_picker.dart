import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File pickedImage) imagePickFn;

  UserImagePicker(this.imagePickFn);

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;

  void _pickImage() async {
    final picker = ImagePicker.platform;
    final pickedImage = await picker.pickImage(
        source: ImageSource.camera, imageQuality: 50, maxHeight: 150);
    setState(() {
      _pickedImage = File((pickedImage as PickedFile).path);
    });
    widget.imagePickFn(File((pickedImage as PickedFile).path));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage!) : null,
        ),
        FlatButton.icon(
            onPressed: _pickImage,
            icon: Icon(
              Icons.image,
              color: Theme.of(context).primaryColor,
            ),
            label: Text(
              'Add image',
              style: TextStyle(color: Theme.of(context).primaryColor),
            )),
      ],
    );
  }
}
