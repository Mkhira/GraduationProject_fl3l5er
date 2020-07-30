import 'dart:io';

import 'package:company_task/provider/info_provider.dart';
import 'package:company_task/style/constent.dart';
import 'package:company_task/wedgit/main_drawer.dart';
import 'package:company_task/wedgit/radio_group.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

kGender selection;

class EditScreen extends StatelessWidget {
  static const String id = 'edit_screen';

  @override
  Widget build(BuildContext context) {
    String newName, newJop, newLocation, newBio, newEmail, newPhone, newID;
    // File file;
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: Container(
          margin: EdgeInsets.only(left: 25.0),
          child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        centerTitle: true,
        title: Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 250,
                width: MediaQuery.of(context).size.width,
//                decoration: BoxDecoration(
//                    color: Colors.deepPurple,
//                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30))
//                ),
              ),
              Positioned(
                top: 20.0,
                left: MediaQuery.of(context).size.width / 2 - 95,
                child: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                    width: 200.0,
                    height: 200.0,
                    child: Provider.of<InfoProvider>(context).pickedImage ==
                            null
                        ? Center(
                            child: Icon(
                              Icons.add,
                              size: 32.0,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.file(
                              Provider.of<InfoProvider>(context).pickedImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  onTap: () {
                    Alert(context: context).onTapped();
                  },
                ),
              ),
              Positioned(
                top: 203.0,
                left: MediaQuery.of(context).size.width / 2 - 31,
                child: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    Alert(context: context).onTapped();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    child: Icon(Icons.camera_alt),
                    width: 80,
                    height: 29,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                EditTextField(
                  title: 'Name',
                  hint: Provider.of<InfoProvider>(context).name,
                  onPressed: (newText) {
                    newName = newText;
                  },
                ),
                EditTextField(
                  title: 'Jop',
                  hint: Provider.of<InfoProvider>(context).jop,
                  onPressed: (newText) {
                    newJop = newText;
                  },
                ),
                EditTextField(
                  title: 'Address',
                  hint: Provider.of<InfoProvider>(context).location,
                  onPressed: (newText) {
                    newLocation = newText;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(1.0),
                          )
                        ],
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Phone Number',
                            style: KTitleTextStyle,
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          TextField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              WhitelistingTextInputFormatter.digitsOnly
                            ],
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                            ),
                            decoration: kTextFieldDecoration.copyWith(
                              hintText: Provider.of<InfoProvider>(context).phone,
                            ),
                            onChanged: (newText) {
                              newPhone = newText;
                            },
                          ),
                          SizedBox(
                            height: 10.0,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'ID',
                            style: KTitleTextStyle,
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          TextField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              WhitelistingTextInputFormatter.digitsOnly
                            ],
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                            ),
                            decoration: kTextFieldDecoration.copyWith(
                              hintText: Provider.of<InfoProvider>(context).id,
                            ),
                            onChanged: (newText) {
                              newID = newText;
                            },
                          ),
                          SizedBox(
                            height: 10.0,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                DropDownButton(),
                RadioGroup(
                  groupName: 'Marital Status',
                  firstText: 'Single',
                  secondText: 'Married',
                ),
                EditTextField(
                  title: 'Bio',
                  hint: Provider.of<InfoProvider>(context).bio,
                  lines: 3,
                  onPressed: (newText) {
                    newBio = newText;
                  },
                ),
                Material(
                  elevation: 5.0,
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15.0),
                  child: MaterialButton(
                    onPressed: () {
                      if (newName == null) {
                        newName =
                            Provider.of<InfoProvider>(context, listen: false)
                                .name;
                      }
                      if (newJop == null) {
                        newJop =
                            Provider.of<InfoProvider>(context, listen: false)
                                .jop;
                      }
                      if (newLocation == null) {
                        newLocation =
                            Provider.of<InfoProvider>(context, listen: false)
                                .location;
                      }
                      if (newEmail == null) {
                        newEmail =
                            Provider.of<InfoProvider>(context, listen: false)
                                .email;
                      }
                      if (newPhone == null) {
                        newPhone =
                            Provider.of<InfoProvider>(context, listen: false)
                                .phone;
                      }
                      if (newID == null) {
                        newID =
                            Provider.of<InfoProvider>(context, listen: false)
                                .id;
                      }
                      if (newBio == null) {
                        newBio =
                            Provider.of<InfoProvider>(context, listen: false)
                                .bio;
                      }

                      //update gender
                      Provider.of<InfoProvider>(context, listen: false)
                              .modifyUpdatedGender =
                          Provider.of<InfoProvider>(context, listen: false)
                              .gender;
                      //update status
                      Provider.of<InfoProvider>(context, listen: false)
                              .modifyUpdatedStatus =
                          Provider.of<InfoProvider>(context, listen: false)
                              .status;

                      //update Date of birth
                      Provider.of<InfoProvider>(context, listen: false)
                              .modifyUpdatedDay =
                          Provider.of<InfoProvider>(context, listen: false).day;
                      Provider.of<InfoProvider>(context, listen: false)
                              .modifyUpdatedMonth =
                          Provider.of<InfoProvider>(context, listen: false)
                              .month;
                      Provider.of<InfoProvider>(context, listen: false)
                              .modifyUpdatedYear =
                          Provider.of<InfoProvider>(context, listen: false)
                              .year;

                      //update Image
                      Provider.of<InfoProvider>(context, listen: false)
                              .modifyUpdatedImage =
                          Provider.of<InfoProvider>(context, listen: false)
                              .pickedImage;

                      Provider.of<InfoProvider>(context, listen: false)
                          .updateInfo(
                        newName: newName,
                        newJop: newJop,
                        newLocation: newLocation,
                        newBio: newBio,
                        newEmail: newEmail,
                        newID: newID,
                        newPhone: newPhone,
                      );
                      Navigator.pop(context);
                    },
                    minWidth: 180.0,
                    height: 55.0,
                    hoverColor: Colors.transparent,
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white, fontSize: 22.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Alert {
  BuildContext context;
  File file, cropped;

  Alert({@required this.context});

  flatButtonPressed(ImageSource source) async {
    file = await ImagePicker.pickImage(source: source);

    if (file != null) {
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
          lockAspectRatio: false,
        ),
        compressQuality: 100,
        maxHeight: 700,
        maxWidth: 700,
        compressFormat: ImageCompressFormat.jpg,
      );
    }

    Provider.of<InfoProvider>(context, listen: false).modifyImage =
        (cropped == null)
            ? Provider.of<InfoProvider>(context, listen: false).pickedImage
            : cropped;

    Navigator.pop(context);
  }

  onTapped() {
    AlertDialog alert = AlertDialog(
      title: Text('Choose Image from'),
      actions: <Widget>[
        FlatButton(
            child: Text('Gallery'),
            onPressed: () => flatButtonPressed(ImageSource.gallery)),
        FlatButton(
            child: Text('Camera'),
            onPressed: () => flatButtonPressed(ImageSource.camera)),
      ],
      elevation: 24.0,
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class EditTextField extends StatelessWidget {
  final Function onPressed;
  final String title, hint;
  final int lines;

  const EditTextField({this.onPressed, this.title, this.hint, this.lines});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow:[
            BoxShadow(
              color: Colors.grey.withOpacity(0.9),
              blurRadius: 7,
            ),
          ]
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: KTitleTextStyle,
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                //maxLength: 4,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
                decoration: kTextFieldDecoration.copyWith(
                  hintText: hint,
                ),
                maxLines: lines,
                onChanged: onPressed,
              ),
              SizedBox(
                height: 10.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DropDownButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Theme(
          data: ThemeData(
              unselectedWidgetColor: Colors.white, accentColor: Colors.white),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'BirthDate',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Row(
                        children: <Widget>[
                          Text(
                            'day :',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          DropdownButton<String>(
                            value: Provider.of<InfoProvider>(context).day,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.deepPurple,
                            ),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String newValue) {
                              Provider.of<InfoProvider>(context, listen: false)
                                  .modifyDay = newValue;
                            },
                            items: kDay.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Row(
                        children: <Widget>[
                          Text(
                            'month : ',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          DropdownButton<String>(
                            value: Provider.of<InfoProvider>(context).month,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.deepPurple,
                            ),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String newValue) {
                              Provider.of<InfoProvider>(context, listen: false)
                                  .modifyMonth = newValue;
                            },
                            items: kMonth.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'year :',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    DropdownButton<String>(
                      value: Provider.of<InfoProvider>(context).year,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.deepPurple,
                      ),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String newValue) {
                        Provider.of<InfoProvider>(context, listen: false)
                            .modifyYear = newValue;
                      },
                      items: kYear.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
