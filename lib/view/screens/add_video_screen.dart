import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_firebase/core/constants.dart';
import 'package:tiktok_firebase/view/screens/confirm_screen.dart';

class AddVideoScreen extends StatelessWidget {
  const AddVideoScreen({super.key});
  pickVideo(ImageSource source, BuildContext ctx) async {
    final video = await ImagePicker().pickVideo(source: source);
    if (video != null) {
      Navigator.of(
        // ignore: use_build_context_synchronously
        ctx,
      ).push(
        MaterialPageRoute(
          builder: (context) =>
              ConfirmScreen(videoFile: File(video.path), videoPath: video.path),
        ),
      );
    }
  }

  showOptionsDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        children: [
          SimpleDialogOption(
            onPressed: () => pickVideo(ImageSource.gallery, context),
            child: Row(
              children: [
                Icon(Icons.image),

                Padding(padding: EdgeInsets.all(8), child: Text('Gallery')),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () => pickVideo(ImageSource.camera, context),
            child: Row(
              children: [
                Icon(Icons.camera),

                Padding(padding: EdgeInsets.all(8), child: Text('Camera')),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Row(
              children: [
                Icon(Icons.close),

                Padding(padding: EdgeInsets.all(8), child: Text('Cancel')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () => showOptionsDialog(context),
          child: Container(
            width: 190,
            height: 50,
            decoration: BoxDecoration(color: buttonColor),
            child: Center(
              child: Text(
                'Add Video',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
