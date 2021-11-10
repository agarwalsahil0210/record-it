import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Center(
            child: ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Open Camera'),
              onTap: () => pickCameraMedia(context),
            ),
          ),
        ),
      ),
    );
  }

  Future pickCameraMedia(BuildContext context) async {
    // final MediaSource source = ModalRoute.of(context)!.settings.arguments;

    final getMedia = ImagePicker().getVideo;

    final media = await getMedia(source: ImageSource.camera);
    final file = File(media!.path);

    Navigator.of(context).pop(file);
  }
}
