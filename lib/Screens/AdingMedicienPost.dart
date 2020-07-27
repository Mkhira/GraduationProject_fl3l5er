import 'package:android_intent/android_intent.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:company_task/Screens/Maps/user_location.dart';
import 'package:company_task/provider/AddPostProvider.dart';
import 'package:company_task/provider/MapProvider.dart';
import 'package:company_task/style/constent.dart';
import 'package:company_task/wedgit/ButtonWidget.dart';
import 'package:company_task/wedgit/MainTextFeild.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class AddMedicinePostDataScreen extends StatefulWidget {
  static const String id = 'AddPostScreen';
  PermissionStatus status;


  @override
  _AddMedicinePostDataScreenState createState() =>
      _AddMedicinePostDataScreenState();
}

class _AddMedicinePostDataScreenState extends State<AddMedicinePostDataScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  Future _checkGps() async {
    if (!(await Geolocator().isLocationServiceEnabled())) {
      if (Theme.of(context).platform == TargetPlatform.android) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Can't get gurrent location"),
                content:const Text('Please make sure you enable GPS and try again'),
                actions: <Widget>[
                  FlatButton(child: Text('Ok'),
                      onPressed: () {
                        final AndroidIntent intent = AndroidIntent(
                            action: 'android.settings.LOCATION_SOURCE_SETTINGS');
                        intent.launch();
                        Navigator.of(context, rootNavigator: true).pop();
                      })],
              );
            });
      }
    }
  }

  Future _gpsService() async {
    if (!(await Geolocator().isLocationServiceEnabled())) {
      _checkGps();
      return null;
    } else
      return true;
  }
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AddPostProvider>(context);

    return SafeArea(
        child: Scaffold(
          backgroundColor: kMainColor,
          appBar: AppBar(
            leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {}),
            backgroundColor: kSecondColor,
            title: Text('Add Post'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 20,
                      ),
                      CircleAvatar(
                        backgroundColor: kSecondColor,
                        radius: 40,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Mohamed Khaled Khaira",
                        style: TextStyle(
                            color: kSecondColor, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 5,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Choose Your State: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.2,
                        child: DropdownButton(
                          hint: Text('Chose Your State'),
                          // Not necessary for Option 1
                          value: provider.selectedsState,
                          onChanged: (newValue) {
                            provider.ChosseState(newValue);
                          },
                          items: provider.dropState.map((location) {
                            return DropdownMenuItem(
                              child: new Text(location),
                              value: location,
                            );
                          }).toList(),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: <Widget>[
                      Container(
                          height: 130,
                          width: 200,
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: 10,
                                left: 40,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: kSecondColor,
                                  ),
                                  height: 120,
                                  width: 120,
                                  child: ClipRRect(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(120)),
                                    child: provider.imagefile == null
                                        ? Container(
                                      height: 0,
                                      width: 0,
                                    )
                                        : Image.file(
                                      provider.imagefile,
                                      height: 120,
                                      width: 120,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 15,
                                right: 25,
                                child: IconButton(
                                    icon: Icon(
                                      CommunityMaterialIcons.camera_outline,
                                      size: 35,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      provider.onChoseImage(context);
                                    }),
                              )
                            ],
                          )),
                      Container(
                        margin: EdgeInsets.all(15),
                        width: MediaQuery.of(context).size.width,
                        child: StreamBuilder(
                          stream: provider.medicineDescriptionStream,
                          builder: (context, snapshot) {
                            return TextField(
                              onChanged: provider.medicineDescriptionChange,
                              textInputAction: TextInputAction.newline,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration.collapsed(
                                hintText: "Description ?",
                                hintStyle: TextStyle(fontSize: 20),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 15,
                            ),
                            MainTextField(
                              width: MediaQuery.of(context).size.width / 2.3,
                              widget: Container(
                                width: 0,
                                height: 0,
                              ),
                              textChange: provider.medicineNameChange,
                              obscure: false,
                              textStream: provider.medicineNameStream,
                              inputType: TextInputType.text,
                              hintText: "Medicine name",
                            ),
                            Spacer(
                              flex: 2,
                            ),
                            MainTextField(
                              width: MediaQuery.of(context).size.width / 4,
                              widget: Container(
                                width: 0,
                                height: 0,
                              ),
                              textChange: provider.medicineAmountChange,
                              obscure: false,
                              textStream: provider.medicineAmountStream,
                              inputType: TextInputType.number,
                              hintText: "  Amount",
                            ),
                            Spacer(
                              flex: 1,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 15,
                            ),
                            MainTextField(
                              width: MediaQuery.of(context).size.width / 2.7,
                              widget: Container(
                                width: 0,
                                height: 0,
                              ),
                              textChange: provider.phoneChange,
                              obscure: false,
                              textStream: provider.phoneStream,
                              inputType: TextInputType.phone,
                              hintText: "Phone ",
                            ),
                            Spacer(
                              flex: 2,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            MainTextField(
                              width: MediaQuery.of(context).size.width / 4,
                              widget: Container(
                                width: 0,
                                height: 0,
                              ),
                              textChange: provider.durationChange,
                              obscure: false,
                              textStream: provider.dateStream,
                              inputType: TextInputType.number,
                              hintText: '  Duration',
                            ),
                            Spacer(
                              flex: 1,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 15,
                            ),
                            ButtonWidget(
                              height: 40,
                              color: kSecondColor,
                              textColor: Colors.white,
                              borderColor: kSecondColor,
                              text: "Chosse Date",
                              onPressed: () {
                                provider.datePicker(context);
                              },
                            ),
                            Spacer(
                              flex: 3,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            MainTextField(
                              width: MediaQuery.of(context).size.width / 3,
                              widget: Container(
                                width: 0,
                                height: 0,
                              ),
                              textChange: provider.dateChange,
                              obscure: false,
                              enable: false,
                              textStream: provider.dateStream,
                              inputType: TextInputType.phone,
                              hintText: provider.dateTime == null
                                  ? "       Date"
                                  : DateFormat('dd/MM/yyyy ')
                                  .format(DateTime.parse(
                                  provider.dateTime.toString()))
                                  .toString(),
                            ),
                            Spacer(
                              flex: 1,
                            ),
                          ],
                        ),
                      ),
//                  SizedBox(
//                    height: 8.0,
//                  ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 15.0),
                        child: Row(
                          children: [
                            ButtonWidget(
                              height: 40,
                              color: kSecondColor,
                              textColor: Colors.white,
                              borderColor: kSecondColor,
                              text: "Get Current Location",
                              onPressed: () async {
                                //get current position using geolocator package
                                Map<Permission, PermissionStatus> statuses = await [
                                  Permission.location,
                                ].request();
                                print(statuses[Permission.location]);
                                if( await Permission.locationWhenInUse.isPermanentlyDenied &&(await Permission.location.serviceStatus.isDisabled ||await Permission.location.serviceStatus.isEnabled ||await Permission.location.isGranted != true) ){
                                  openAppSettings();
                                }  else
                                if(await Permission.locationWhenInUse.serviceStatus.isEnabled && await Permission.location.serviceStatus.isEnabled && await Permission.location.isGranted){
                                  Provider.of<MapProvider>(context).getCurrentLocation();

                                }
                                else if(
                                await Permission.location.serviceStatus.isDisabled && await Permission.locationWhenInUse.isPermanentlyDenied != true){

//
                                  Provider.of<AddPostProvider>(context).checkGps();
                                }


                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          children: [
                            ButtonWidget(
                              height: 40,
                              color: kSecondColor,
                              textColor: Colors.white,
                              borderColor: kSecondColor,
                              text: "Get Another Location",
                              onPressed: () async {


                                Map<Permission, PermissionStatus> statuses = await [
                                  Permission.location,
                                ].request();
                                print(statuses[Permission.location]);
                                if( await Permission.locationWhenInUse.isPermanentlyDenied &&(await Permission.location.serviceStatus.isDisabled ||await Permission.location.serviceStatus.isEnabled ||await Permission.location.isGranted != true) ){
                                  openAppSettings();
                                }  else
                                if(await Permission.locationWhenInUse.serviceStatus.isEnabled && await Permission.location.serviceStatus.isEnabled && await Permission.location.isGranted){
                                  Provider.of<MapProvider>(context).getAnotherLocation(context);

                                }
                                else if(
                                await Permission.location.serviceStatus.isDisabled && await Permission.locationWhenInUse.isPermanentlyDenied != true){

//
                                  Provider.of<AddPostProvider>(context).checkGps();
                                }



                              },
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      FlatButton(
                          onPressed: () {
                            provider.createRecord();
                          },
                          child: Text("Post")),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}