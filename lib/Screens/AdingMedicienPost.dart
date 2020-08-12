
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
import 'package:company_task/wedgit/OurTextFeilds/MyMainTextField.dart';
import 'package:flutter/cupertino.dart';
import 'file:///E:/flater_projects/company_task/lib/wedgit/OurTextFeilds/MainTextFeild.dart';
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
 Bloc _bloc;
class _AddMedicinePostDataScreenState extends State<AddMedicinePostDataScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  bool  _loading=false;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AddPostMedicineProvider>(context);
    return SafeArea(
        child: Scaffold(
          backgroundColor: kMainColor,
          appBar: AppBar(
            leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {}),
            backgroundColor: kSecondColor,
            title: Text('إضافه دواء ',style: KBaseHeaders,),
          ),
          body: ModalProgressHUD(
            inAsyncCall: _loading,

            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[

                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "${Provider.of<InfoProvider>(context).nameProfile}",
                          style: TextStyle(
                              color: kSecondColor, fontWeight: FontWeight.bold,fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',fontSize: 20),
                        ),

                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: kSecondColor,
                          ),
                          height: 80,
                          width: 80,
                          child:
                          ClipRRect(
                            borderRadius:
                            BorderRadius.all(Radius.circular(120)),
                            child: CachedNetworkImage(
                              imageUrl: '${Provider.of<InfoProvider>(context).imageUrlProfile}',
                              height: 130,
                              width: MediaQuery.of(context).size.width/2.21,

                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget:
                                  (context, url, error) =>
                                  Icon(Icons.error),
                              placeholderFadeInDuration:
                              Duration(days: 30),
                              useOldImageOnUrlChange: true,
                              filterQuality:
                              FilterQuality.low,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),

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
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 3.5,
                          child: DropdownButton(
                            hint: Text('إختر الحاله ',style: TextStyle( fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic'),),
                            // Not necessary for Option 1
                            value: provider.selectedsState,
                            onChanged: (newValue) {
                              provider.ChosseState(newValue);
                            },
                            items: provider.dropState.map((state) {
                              return DropdownMenuItem(
                                child: new Text(state,style: TextStyle( fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic'),),
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
                            SizedBox(height: 35,),
                            Text(
                              " : إختر الحاله",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic'),
                            ),

                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: 15,),
                  Container(
                    width: MediaQuery.of(context).size.width,

                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text('مجهول',style: TextStyle( fontSize: 15,fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',fontWeight: FontWeight.bold),),

                        SizedBox(width: 8,),
                        Container(
                      height:35,
                          width: 70,

                          child: Switch(
                              activeColor: kSecondColor,
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              value: provider.value, onChanged: (value){
                            setState(() {
                              provider.value = value;

                            });
                          }),
                        ),
                        Text('استخدم الأسم',style: TextStyle( fontSize: 15,fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',fontWeight: FontWeight.bold),),

                        SizedBox(width: 30,),
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
                                    child:
                                    ClipRRect(
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
                        Container(width: MediaQuery.of(context).size.width,height: 2,color: Colors.white,),
                        SizedBox(height: 30,),
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
                                width: MediaQuery.of(context).size.width / 3.5,
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
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 15,
                              ),
                              MyMainTextField(
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
                                width: 15,
                              ),
                              MyMainTextField(
                                labelText: 'المده',
                                width: MediaQuery.of(context).size.width / 3.5,
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
                                text: "إختر الموقع الحالى",
                                onPressed: () async {
                                  //get current position using geolocator package
                                  setState(() {
                                    _loading=true;

                                  });
                                  Map<Permission, PermissionStatus> statuses = await [
                                    Permission.location,
                                  ].request();
                                  print(statuses[Permission.location]);
                                  if( await Permission.locationWhenInUse.isPermanentlyDenied &&(await Permission.location.serviceStatus.isDisabled ||await Permission.location.serviceStatus.isEnabled ||await Permission.location.isGranted != true) ){
                                    openAppSettings();
                                  }  else
                                  if(await Permission.locationWhenInUse.serviceStatus.isEnabled && await Permission.location.serviceStatus.isEnabled && await Permission.location.isGranted){
                                    Provider.of<MapProvider>(context).getCurrentLocation(context);

                                  }
                                  else if(
                                  await Permission.location.serviceStatus.isDisabled && await Permission.locationWhenInUse.isPermanentlyDenied != true){

//
                                    Provider.of<AddPostMedicineProvider>(context).checkGps();
                                  }

                                  _loading=false;

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
                                text: "   إختر موقع أخر   ",
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
                                    Provider.of<AddPostMedicineProvider>(context).checkGps();
                                  }



                                },
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width/2,
                          child: ButtonWidget(
                            height: 40,
                            color: kSecondColor,
                            textColor: Colors.white,
                            borderColor: kSecondColor,
                            text: "إضافه",
                            onPressed: (){
                              Provider.of<AddPostMedicineProvider>(context).createRecord(context);

//                            _bloc.fetchMedicine();
//                            _bloc.fetchMedicineFinish();


                            }
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        )
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

