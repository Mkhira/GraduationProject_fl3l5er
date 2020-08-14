



import 'package:company_task/provider/AddPostMedicineProvider.dart';
import 'package:company_task/provider/AddingBloodPostProvider.dart';
import 'package:company_task/provider/MapProvider.dart';
import 'package:company_task/style/constent.dart';
import 'package:company_task/wedgit/ButtonWidget.dart';
import 'package:company_task/wedgit/OurTextFeilds/MyMainTextField.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class AddBloodPostScreen extends StatefulWidget {
  @override
  _AddBloodPostScreenState createState() => _AddBloodPostScreenState();
}

class _AddBloodPostScreenState extends State<AddBloodPostScreen> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  bool  _loading=false;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BloodPostProvider>(context);


    return SafeArea(child:
     Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondColor,
        title: Row(
          textDirection: TextDirection.rtl,
          children: <Widget>[
            Text("اضافه بوست دم",style: TextStyle( fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic'),)
          ],
        ),
      ),

      body: ModalProgressHUD(
        inAsyncCall: _loading,

        child: SingleChildScrollView(
          child:  Column(
              crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),

                  Container(
                    margin: EdgeInsets.all(15),
                    width: MediaQuery.of(context).size.width,
                    child: StreamBuilder(
                      stream: provider.patientDescriptionStream,
                      builder: (context, snapshot) {
                        return TextField(
                          textAlign: TextAlign.right,

                          onChanged: provider.patientDescriptionChange,
                          textInputAction: TextInputAction.newline,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration.collapsed(
                            hintText: "   الوصف   ",
                            hintStyle: kPostStyleArabicTextHint,
                          ),
                        );
                      },
                    ),
                  ),
                  Divider(
                    color: kSecondColor,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right:12.0),
                    child: MyMainTextField(
                      labelText: 'اسم المريض',
                      width: MediaQuery.of(context).size.width / 1.1,
                      widget: Container(
                        width: 0,
                        height: 0,
                      ),
                      textChange: provider.patientChange,
                      obscure: false,
                      textStream: provider.patientStream,
                      inputType: TextInputType.text,
                      hintText: "اسم المريض",
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(right:12.0),
                    child: MyMainTextFieldForm(
                      labelText: 'حساب بنك الدم',
                      width: MediaQuery.of(context).size.width / 1.1,
                      widget: Container(
                        width: 0,
                        height: 0,
                      ),
                      textChange: provider.bloodBankChange,
                      obscure: false,
                      textStream: provider.bloodBankStream,
                      inputType: TextInputType.text,
                      hintText: "حساب بنك الدم",
                    ),
                  ),

                  SizedBox(height: 15,),

                  Padding(
                    padding: const EdgeInsets.only(right:8.0),
                    child: MyMainTextField(
                      labelText: 'اسم المستشفى',
                      width: MediaQuery.of(context).size.width / 1.1,
                      widget: Container(
                        width: 0,
                        height: 0,
                      ),
                      textChange: provider.hospitalNameChange,
                      obscure: false,
                      textStream: provider.hospitalNameStream,
                      inputType: TextInputType.text,
                      hintText: "اسم المستشفى",
                    ),
                  ),

                  SizedBox(
                    height: 15,
                  ),

                        Form(
                          key: _form,
                          autovalidate: true,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: MyMainTextFieldForm(
                                  inputController: provider.bloodNeededController,
                                  val: (val){
                                    if(val.length==1){
                                      return null;

                                    } else{
                                      return "لايمكن طلب هذه الكميه";

                                    }
                                  },
                                  labelText: 'عدد اكياس الدم المطلوبه',
                                  width: MediaQuery.of(context).size.width / 1.1,
                                  widget: Container(
                                    width: 0,
                                    height: 0,
                                  ),
                                  textChange: provider.bloodNeededAmountChange,
                                  obscure: false,
                                  textStream: provider.bloodNeededAmountStream,
                                  inputType: TextInputType.number,
                                  hintText: "عدد اكياس الدم المظلوبه",
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),

                              Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: MyMainTextFieldForm(
                                  inputController: provider.ageController,
                                  val: (val){
                                    if(val.length<=2){
                                      return null;

                                    } else{
                                      return "عمر خطاء";

                                    }
                                  },
                                  labelText: 'سن المريض',
                                  width: MediaQuery.of(context).size.width / 1.1,
                                  widget: Container(
                                    width: 0,
                                    height: 0,
                                  ),
                                  textChange: provider.patientAgeChange,
                                  obscure: false,
                                  textStream: provider.patientAgeStream,
                                  inputType: TextInputType.number,
                                  hintText: "سن المريض",
                                ),
                              ),

                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: MyMainTextFieldForm(
                                  val: (val){
                                    if(val.length==11){
                                      return null;

                                    } else{
                                      return "الهاتف خطاء";

                                    }
                                  },
                                  labelText: 'الهاتف',
                                  width: MediaQuery.of(context).size.width / 1.1,
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
                              ),
                            ],
                          ),
                        ),

                  Padding(
                    padding: const EdgeInsets.only(right: 18),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 4,
                            child: DropdownButton(
                              hint: Text('إختر النوع ',style: TextStyle( fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic'),),
                              // Not necessary for Option 1
                              value: provider.selectGander,
                              onChanged: (newValue) {
                                provider.choseGander(newValue);
                              },
                              items: provider.ganderState.map((state) {
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
                                " : إختر النوع",
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
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[

                        Container(
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: DropdownButton(
                            hint: Text('إختر فصيله الدم ',style: TextStyle( fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic'),),
                            // Not necessary for Option 1
                            value: provider.selectedBloodType,
                            onChanged: (newValue) {
                              provider.choseBloodType(newValue);
                            },
                            items: provider.bloodType.map((state) {
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
                              " : إختر فصيله الدم",
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


                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 15.0),
                    child: Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        ButtonWidget(
                          height: 40,
                          color: kSecondColor,
                          textColor: Colors.white,
                          borderColor: kSecondColor,
                          text: "إختر الموقع المستشفى",
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
                              Provider.of<BloodPostProvider>(context).checkGps();
                            }

                            _loading=false;
                          },
                        ),

                        SizedBox(
                          width: 25,
                        ),
                        Text(
                          "تأكد من انك داخل المستشفى",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',color: Colors.black45),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 15,
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Container(
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

                              provider.createBloodPost(context);
                              _loading=false;
                            }
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 15,
                  ),
                ],
            ),

        ),
      ),
    )

    );
  }
}







