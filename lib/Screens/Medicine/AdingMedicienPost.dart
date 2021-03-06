import 'package:android_intent/android_intent.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:company_task/Block/Block.dart';
import 'package:company_task/Screens/Maps/user_location.dart';
import 'package:company_task/provider/AddPostMedicineProvider.dart';
import 'package:company_task/provider/MapProvider.dart';
import 'package:company_task/provider/info_provider.dart';
import 'package:company_task/style/constent.dart';
import 'package:company_task/wedgit/ButtonWidget.dart';
import 'package:company_task/wedgit/OurTextFeilds/MainTextFeild.dart';
import 'package:company_task/wedgit/OurTextFeilds/MyMainTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
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
  Bloc _bloc;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AddPostMedicineProvider>(context);
    return SafeArea(
        child: Scaffold(
      backgroundColor: kMainColor,
      appBar: AppBar(
        backgroundColor: kSecondColor,
        title: Text(
          'إضافه دواء ',
          style: KBaseHeaders,
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _loading,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 5,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Material(
                      elevation: 3,
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,

                      child: Container(
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(20),
                         color: Colors.white

                       ),
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
                                           fit: BoxFit.fill,
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
                                           color: Colors.grey[200],
                                         ),
                                         onPressed: () {
                                           provider.onChoseImage(context);
                                         }),
                                   ),
                                 ],
                               )),

                           SizedBox(
                             height: 5,
                           ),
                           Container(
                             width: MediaQuery.of(context).size.width,
                             height: 80,
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.end,
                               children: <Widget>[
                                 SizedBox(
                                   width: 10,
                                 ),
                                 Container(
                                   width: MediaQuery.of(context).size.width / 3.5,
                                   child: DropdownButton(
                                     hint: Text(
                                       'إختر الحاله ',
                                       style: TextStyle(
                                           fontFamily: ArabicFonts.Amiri,
                                           package: 'google_fonts_arabic'),
                                     ),
                                     // Not necessary for Option 1
                                     value: provider.selectedsState,
                                     onChanged: (newValue) {
                                       provider.ChosseState(newValue);
                                     },
                                     items: provider.dropState.map((state) {
                                       return DropdownMenuItem(
                                         child: new Text(
                                           state,
                                           style: TextStyle(
                                               fontFamily: ArabicFonts.Amiri,
                                               package: 'google_fonts_arabic'),
                                         ),
                                         value: state,
                                       );
                                     }).toList(),
                                   ),
                                 ),
                                 SizedBox(
                                   width: 10,
                                 ),
                                 Column(
                                   children: <Widget>[
                                     SizedBox(
                                       height: 35,
                                     ),
                                     Text(
                                       " : إختر الحاله",
                                       style: TextStyle(
                                           fontWeight: FontWeight.bold,
                                           fontFamily: ArabicFonts.Amiri,
                                           package: 'google_fonts_arabic'),
                                     ),
                                   ],
                                 ),
                                 SizedBox(
                                   width: 20,
                                 ),
                               ],
                             ),
                           ),
                           SizedBox(
                             height: 15,
                           ),
                           Container(
                             width: MediaQuery.of(context).size.width,
                             child: Row(
                               crossAxisAlignment: CrossAxisAlignment.end,
                               mainAxisAlignment: MainAxisAlignment.end,
                               children: <Widget>[
                                 Text(
                                   'مجهول',
                                   style: TextStyle(
                                       fontSize: 15,
                                       fontFamily: ArabicFonts.Amiri,
                                       package: 'google_fonts_arabic',
                                       fontWeight: FontWeight.bold),
                                 ),
                                 SizedBox(
                                   width: 8,
                                 ),
                                 Container(
                                   height: 35,
                                   width: 70,
                                   child: Switch(
                                       activeColor: kSecondColor,
                                       materialTapTargetSize:
                                       MaterialTapTargetSize.shrinkWrap,
                                       value: provider.value,
                                       onChanged: (value) {
                                         setState(() {
                                           provider.value = value;
                                         });
                                       }),
                                 ),
                                 Text(
                                   'استخدم الأسم',
                                   style: TextStyle(
                                       fontSize: 15,
                                       fontFamily: ArabicFonts.Amiri,
                                       package: 'google_fonts_arabic',
                                       fontWeight: FontWeight.bold),
                                 ),
                                 SizedBox(
                                   width: 30,
                                 ),
                               ],
                             ),
                           ),
                           SizedBox(
                             height: 20,
                           ),

                         ],
                       ),
                     ),
                   ),
                    SizedBox(
                      height:25 ,
                    ),

                  Material(
                    elevation: 3,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,

                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(15),
                            width: MediaQuery.of(context).size.width,
                            child: StreamBuilder(
                              stream: provider.medicineDescriptionStream,
                              builder: (context, snapshot) {
                                return TextField(
                                  textAlign: TextAlign.right,
                                  onChanged: provider.medicineDescriptionChange,
                                  textInputAction: TextInputAction.newline,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  decoration: InputDecoration.collapsed(
                                    hintText: " الوصف",
                                    hintStyle: kPostStyleArabicTextHint,
                                  ),
                                );
                              },
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 2,
                            color: Colors.grey[200],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 15,
                                ),
                                MyMainTextField(
                                  labelText: 'اسم الدواء',
                                  width: MediaQuery.of(context).size.width / 2.3,
                                  widget: Container(
                                    width: 0,
                                    height: 0,
                                  ),
                                  textChange: provider.medicineNameChange,
                                  obscure: false,
                                  textStream: provider.medicineNameStream,
                                  inputType: TextInputType.text,
                                  hintText: "اسم الدواء",
                                ),
                                Spacer(
                                  flex: 2,
                                ),
                                MyMainTextField(
                                  labelText: 'الكميه',
                                  width: MediaQuery.of(context).size.width / 3.4,
                                  widget: Container(
                                    width: 0,
                                    height: 0,
                                  ),
                                  textChange: provider.medicineAmountChange,
                                  obscure: false,
                                  textStream: provider.medicineAmountStream,
                                  inputType: TextInputType.number,
                                  hintText: "  الكميه",
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
                            child: Form(
                              key: _form,
                              autovalidate: true,
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 15,
                                  ),
                                  MyMainTextFieldForm(
                                    inputController: provider.phoneController,
                                    val: (val) {
                                      if (val.length == 11) {
                                        return null;
                                      } else {
                                        return "الهاتف خطاء";
                                      }
                                    },
                                    labelText: 'الهاتف',
                                    width: MediaQuery.of(context).size.width / 2.35,
                                    widget: Container(
                                      width: 0,
                                      height: 0,
                                    ),
                                    textChange: provider.phoneChange,
                                    obscure: false,
                                    textStream: provider.phoneStream,
                                    inputType: TextInputType.phone,
                                    hintText: "الهاتف ",
                                  ),
                                  Spacer(
                                    flex: 2,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  MyMainTextFieldForm(
                                    inputController: provider.dayController,
                                    val: (val) {
                                      if (val.length == 1) {
                                        return null;
                                      } else {
                                        return "المده طويله";
                                      }
                                    },
                                    labelText: 'المده',
                                    width: MediaQuery.of(context).size.width / 3.4,
                                    widget: Container(
                                      width: 0,
                                      height: 0,
                                    ),
                                    textChange: provider.durationChange,
                                    obscure: false,
                                    textStream: provider.dateStream,
                                    inputType: TextInputType.number,
                                    hintText: '  المده',
                                  ),
                                  Spacer(
                                    flex: 1,
                                  )
                                ],
                              ),
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
                                  text: "إختر التاريخ",
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
                                MyMainTextField(
                                  width: MediaQuery.of(context).size.width / 2,
                                  widget: Container(
                                    width: 0,
                                    height: 0,
                                  ),
                                  textChange: provider.dateChange,
                                  obscure: false,
                                  enable: false,
                                  textStream: provider.dateStream,
                                  labelText: provider.dateTime == null
                                      ? "التاريخ"
                                      : DateFormat('dd/MM/yyyy ')
                                      .format(DateTime.parse(
                                      provider.dateTime.toString()))
                                      .toString(),
                                  inputType: TextInputType.phone,
                                  hintText: provider.dateTime == null
                                      ? "       التاريخ"
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
                                  text: "إختر الموقع الحالى",
                                  onPressed: () async {
                                    //get current position using geolocator package
                                    setState(() {
                                      _loading = true;
                                    });
                                    Map<Permission, PermissionStatus> statuses =
                                    await [
                                      Permission.location,
                                    ].request();
                                    print(statuses[Permission.location]);
                                    if (await Permission
                                        .locationWhenInUse.isPermanentlyDenied &&
                                        (await Permission
                                            .location.serviceStatus.isDisabled ||
                                            await Permission
                                                .location.serviceStatus.isEnabled ||
                                            await Permission.location.isGranted !=
                                                true)) {
                                      openAppSettings();
                                    } else if (await Permission.locationWhenInUse
                                        .serviceStatus.isEnabled &&
                                        await Permission
                                            .location.serviceStatus.isEnabled &&
                                        await Permission.location.isGranted) {
                                      Provider.of<MapProvider>(context)
                                          .getCurrentLocation(context);
                                    } else if (await Permission
                                        .location.serviceStatus.isDisabled &&
                                        await Permission.locationWhenInUse
                                            .isPermanentlyDenied !=
                                            true) {
//
                                      Provider.of<AddPostMedicineProvider>(context)
                                          .checkGps();
                                    }

                                    _loading = false;
                                  },
                                ),
                                Spacer(
                                  flex: 3,
                                ),
                                MyMainTextField(
                                  width: MediaQuery.of(context).size.width / 2,
                                  widget: Container(
                                    width: 0,
                                    height: 0,
                                  ),
                                  textChange: provider.dateChange,
                                  obscure: false,
                                  enable: false,
                                  textStream: provider.dateStream,
                                  labelText: Provider.of<InfoProvider>(context)
                                      .postLocation ==
                                      null
                                      ? "الموقع"
                                      : Provider.of<InfoProvider>(context)
                                      .postLocation
                                      .toString(),
                                  inputType: TextInputType.phone,
                                  hintText: Provider.of<InfoProvider>(context)
                                      .postLocation ==
                                      null
                                      ? "الموقع"
                                      : Provider.of<InfoProvider>(context)
                                      .postLocation
                                      .toString(),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                              ],
                            ),
                          ),
//                  SizedBox(
//                    height: 8.0,
//                  ),
                          SizedBox(
                            height: 20,
                          ),
//                          Padding(
//                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
//                            child: Row(
//                              children: [
//                                ButtonWidget(
//                                  height: 40,
//                                  color: kSecondColor,
//                                  textColor: Colors.white,
//                                  borderColor: kSecondColor,
//                                  text: "   إختر موقع أخر   ",
//                                  onPressed: () async {
//                                    Map<Permission, PermissionStatus> statuses =
//                                    await [
//                                      Permission.location,
//                                    ].request();
//                                    print(statuses[Permission.location]);
//                                    if (await Permission
//                                        .locationWhenInUse.isPermanentlyDenied &&
//                                        (await Permission
//                                            .location.serviceStatus.isDisabled ||
//                                            await Permission
//                                                .location.serviceStatus.isEnabled ||
//                                            await Permission.location.isGranted !=
//                                                true)) {
//                                      openAppSettings();
//                                    } else if (await Permission.locationWhenInUse
//                                        .serviceStatus.isEnabled &&
//                                        await Permission
//                                            .location.serviceStatus.isEnabled &&
//                                        await Permission.location.isGranted) {
//                                      Provider.of<MapProvider>(context)
//                                          .getAnotherLocation(context);
//                                    } else if (await Permission
//                                        .location.serviceStatus.isDisabled &&
//                                        await Permission.locationWhenInUse
//                                            .isPermanentlyDenied !=
//                                            true) {
////
//                                      Provider.of<AddPostMedicineProvider>(context)
//                                          .checkGps();
//                                    }
//                                  },
//                                ),
//                              ],
//                            ),
//                          ),

                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: ButtonWidget(
                                height: 40,
                                color: kSecondColor,
                                textColor: Colors.white,
                                borderColor: kSecondColor,
                                text: "إضافه",
                                onPressed: () {
                                  setState(() {
//                            _bloc.fetchMedicine();
//                            _bloc.fetchMedicineFinish();
                                    _loading = true;
                                  });

                                  Provider.of<AddPostMedicineProvider>(context)
                                      .createRecord(context);

                                  _loading = false;
                                }),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                    SizedBox(height: 20,)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
