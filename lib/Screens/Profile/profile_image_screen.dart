import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_task/Utli/Common.dart';
import 'package:company_task/provider/info_provider.dart';
import 'package:company_task/style/constent.dart';
import 'package:company_task/wedgit/ButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileImageScreen extends StatelessWidget {
  static const String id = 'profile_image_screen';

  @override
  Widget build(BuildContext context) {
    File file, cropped;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: Container(
          margin: EdgeInsets.only(left: 20.0),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        actions: <Widget>[
          PopMenu(context: context).onTapped()
        ],
      ),
      backgroundColor: Color(0xFF04022B),
      body:
          Column(
            children: <Widget>[
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height-250,
                  child: Provider.of<InfoProvider>(context).pickedImage == null
                      ? Center(
                      child: Text(
                        'No image selected.',
                        style: TextStyle(color: Colors.white),
                      ))
                      : Image.file(
                    Provider.of<InfoProvider>(context).pickedImage,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              ButtonWidget(borderColor: kSecondColor ,color: kMainColor, height: 40,onPressed: (){},text: "تعديل الصوره",textColor: kSecondColor,)
            ],
          ),


    );
  }
}

class PopMenu{
  File file,cropped;
  BuildContext context;

  PopMenu({@required this.context});

  Widget onTapped(){
    return PopupMenuButton(
      padding: EdgeInsets.only(right: 20.0),
      onSelected: (kPickImage result) async {
        (result == kPickImage.gallery)
            ? file =
        await ImagePicker.pickImage(source: ImageSource.gallery)
            : file =
        await ImagePicker.pickImage(source: ImageSource.camera);

        if (file != null)  {


            Firestore.instance.collection("Users").document("${await Common.getUserIdToken()}").updateData({
              "image": file.path
            });

          cropped = await ImageCropper.cropImage(
            sourcePath: file.path,
            aspectRatio: CropAspectRatio(
              ratioX: 1,
              ratioY: 1,
            ),
            androidUiSettings: AndroidUiSettings(
                toolbarTitle: 'Cropper',
                toolbarColor: Colors.deepOrange,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: false),
            compressQuality: 100,
            maxHeight: 700,
            maxWidth: 700,
            compressFormat: ImageCompressFormat.jpg,
          );
        }
        Provider.of<InfoProvider>(context, listen: false).modifyImage =
        (cropped == null)
            ? Provider.of<InfoProvider>(context).pickedImage
            : cropped;

        Provider.of<InfoProvider>(context, listen: false)
            .modifyUpdatedImage =
            Provider.of<InfoProvider>(context, listen: false).pickedImage;
      },
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0)),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<kPickImage>>[
        PopupMenuItem<kPickImage>(
          value: kPickImage.gallery,
          child: Text('Choose existing photo'),
        ),
        PopupMenuItem<kPickImage>(
          value: kPickImage.camera,
          child: Text('Take photo'),
        ),
      ],
    );
  }
}