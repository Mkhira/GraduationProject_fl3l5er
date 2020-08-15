


import 'package:cached_network_image/cached_network_image.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:company_task/Block/Block.dart';
import 'package:company_task/provider/AddPostMedicineProvider.dart';
import 'package:company_task/provider/AddPostfurnitureProvider.dart';
import 'package:company_task/provider/MapProvider.dart';
import 'package:company_task/provider/info_provider.dart';
import 'package:company_task/style/constent.dart';
import 'package:company_task/wedgit/ButtonWidget.dart';
import 'package:company_task/wedgit/OurTextFeilds/MyMainTextField.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class AddFurniturePostScreen extends StatefulWidget {
  @override
  _AddFurniturePostScreenState createState() => _AddFurniturePostScreenState();
}

class _AddFurniturePostScreenState extends State<AddFurniturePostScreen> {
  Bloc _bloc = Bloc();
  bool  _loading=false;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AddPostFurnitureProvider>(context);

    return SafeArea(
        child: Scaffold(
          backgroundColor: kMainColor,
          appBar: AppBar(
            backgroundColor: kSecondColor,
            title: Text('إضافه الأثاث ',style: KBaseHeaders,),
          ),
          body: ModalProgressHUD(
            inAsyncCall: _loading,

            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                 SizedBox(
                   height: 20,
                 ),
                 Material(
                   elevation: 3,
                   borderRadius: BorderRadius.circular(20),
                   child: Container(
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(20),
                       color: Colors.white
                     ),
                     child: Column(
                       children: <Widget>[
                         SizedBox(
                           height: 5,
                         ),
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
                                       child: provider.imageFileFurniture == null
                                           ? Container(
                                         height: 0,
                                         width: 0,
                                       )
                                           : Image.file(
                                         provider.imageFileFurniture,
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
                                         color: Colors.grey[200],
                                       ),
                                       onPressed: () {
                                         provider.onChoseImage(context);
                                       }),
                                 )
                               ],
                             )),


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
                         SizedBox(
                           height: 20,
                         ),


                       ],
                     ),
                   ),
                 ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Material(
                    elevation: 3,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.all(15),
                                  width: MediaQuery.of(context).size.width,
                                  child: StreamBuilder(
                                    stream: provider.furnitureDescriptionStream,
                                    builder: (context, snapshot) {
                                      return TextField(
                                        textAlign: TextAlign.right,

                                        onChanged: provider.furnitureDescriptionChange,
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
                                        labelText: 'اسم الأثاث',
                                        width: MediaQuery.of(context).size.width / 2.3,
                                        widget: Container(
                                          width: 0,
                                          height: 0,
                                        ),
                                        textChange: provider.furnitureChange,
                                        obscure: false,
                                        textStream: provider.furnitureStream,
                                        inputType: TextInputType.text,
                                        hintText: "اسم الأثاث",
                                      ),
                                      Spacer(
                                        flex: 2,
                                      ),
                                      MyMainTextField(
                                        labelText: 'الكميه',
                                        width: MediaQuery.of(context).size.width / 3,
                                        widget: Container(
                                          width: 0,
                                          height: 0,
                                        ),
                                        textChange: provider.furnitureAmountChange,
                                        obscure: false,
                                        textStream: provider.furnitureAmountStream,
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
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 15,
                                        ),
                                        MyMainTextFieldForm(
                                          inputController: provider.phoneController,
                                          val: (val){
                                            if(val.length==11){
                                              return null;

                                            } else{
                                              return "الهاتف خطاء";

                                            }
                                          },
                                          labelText: 'الهاتف',
                                          width: MediaQuery.of(context).size.width / 2.3,
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
                                          width: 7,
                                        ),
                                        MyMainTextFieldForm(
                                          inputController: provider.dayController,
                                          val: (val){
                                            if(val.length==1){
                                              return null;

                                            } else{
                                              return "المده طويله";

                                            }
                                          },

                                          labelText: 'المده',
                                          width: MediaQuery.of(context).size.width / 3,
                                          widget: Container(
                                            width: 0,
                                            height: 0,
                                          ),
                                          textChange: provider.durationChange,
                                          obscure: false,
                                          textStream: provider.durationStream,
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
                                          value: provider.selectedsStateType,
                                          onChanged: (newValue) {
                                            provider.ChosseStateType(newValue);
                                          },
                                          items: provider.dropStateType.map((state) {
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
                                            " : إختر حاله الأثاث",
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
                                          setState(() {
                                            _loading=true;

                                          });
                                          //get current position using geolocator package
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
                                      Spacer(
                                        flex: 3,
                                      ),

                                      MyMainTextFieldLocation(

                                        width: MediaQuery.of(context).size.width / 2,
                                        widget: Container(
                                          width: 0,
                                          height: 0,
                                        ),
                                        textChange: provider.dateChange,
                                        obscure: false,
                                        enable: false,
                                        textStream: provider.dateStream,
                                        labelText: Provider.of<InfoProvider>(context).postLocation == null
                                            ? "الموقع"
                                            : Provider.of<InfoProvider>(context).postLocation
                                            .toString(),
                                        inputType: TextInputType.phone,
                                        hintText: Provider.of<InfoProvider>(context).postLocation == null
                                            ? "الموقع"
                                            : Provider.of<InfoProvider>(context).postLocation
                                            .toString(),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(
                                  height: 20.0,
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

                                        setState(() {
                                          _loading=true;

//                                  _bloc.fetchFurniture();
//                                  _bloc.fetchFurnitureFinish();

                                        });
                                        Provider.of<AddPostFurnitureProvider>(context).createRecordFurniture(context);
                                        _loading=false;
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
                  SizedBox(
                    height: 20,
                  ),
                ],

              ),
            ),
          ),
        ));
  }
}
