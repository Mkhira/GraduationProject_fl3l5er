



import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:company_task/Screens/Maps/StaticMap.dart';
import 'file:///E:/flater_projects/company_task/lib/Screens/Chat/ChatScreen.dart';
import 'file:///E:/flater_projects/company_task/lib/Screens/Chat/ConversationScreen.dart';
import 'file:///E:/flater_projects/company_task/lib/Screens/Profile/profile_screen.dart';
import 'package:company_task/provider/info_provider.dart';
import 'package:company_task/style/constent.dart';
import 'package:company_task/wedgit/ButtonWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class BloodNeedyData extends StatefulWidget {

  final String description;
  final String bankAccount;
  final int bloodNeed;
  final int bloodCollected;
  final String name;
  final int age;
  final String bloodType;
  final String gander;
  final String postOwnerName;
  final String imageUrl;
  final String userId;
  final String phone;

  final String hospitalName;
  final List location;

  BloodNeedyData( {this.phone,this.userId,this.imageUrl,this.hospitalName,this.postOwnerName,this.gander,this.name,this.description,this.location,this.age,this.bankAccount,this.bloodCollected,this.bloodNeed,this.bloodType});
  @override
  _BloodNeedyDataState createState() => _BloodNeedyDataState();
}


bool  _loading=false;
DataBaseMethods dataBaseMethods = DataBaseMethods();
getChatRoomID(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else
    return "$a\_$b";
}
getImages(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\(\#\_\*\)$a";
  } else
    return "$a\(\#\_\*\)$b";
}
createChatRomAndStartConverstion({String userId, String userName, String imageUrl,String userNames,String userimages,BuildContext context}) {

  if(userName != Provider.of<InfoProvider>(context).nameProfile && userId != Provider.of<InfoProvider>(context).UserLoginId) {
    String chatRoom_id =
    getChatRoomID(userId, Provider
        .of<InfoProvider>(context)
        .UserLoginId);
    String userNames = getChatRoomID(userName, Provider
        .of<InfoProvider>(context)
        .nameProfile);
    String userimage = getImages(imageUrl, Provider
        .of<InfoProvider>(context)
        .imageUrlProfile);
    List<String> ids = [
      userId,
      Provider
          .of<InfoProvider>(context)
          .UserLoginId
    ];
    Map<String, dynamic> chatRoomMap = {
      'ids': ids,
      'chatrooid': chatRoom_id,
      "image": imageUrl,
      "userid": userId,
      "username": userNames,
      "userimage": userimage
    };
    dataBaseMethods.createChatRoom(chatRoom_id, chatRoomMap);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ConversationScreen(
                  chatRoomId: chatRoom_id,
                  name: userName,
                  imageUrl: imageUrl,
                )));
  }
}
class _BloodNeedyDataState extends State<BloodNeedyData> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(

      body: ModalProgressHUD(
        inAsyncCall: _loading,

        child: SingleChildScrollView(

          child: Container(
            color: Color(0xffFFC200),
            height: 850,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 5,
                  left: 15,
                  child: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,size: 40,), onPressed: null),
                ),
                Positioned(
                  top: 40,
                  right: 40,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return ProfileScreen();
                      }));
                    },
                    child: Container(
                      height: 98,
                      width: 98,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          imageUrl: widget.imageUrl,
                          height: 98,
                          width: 200,
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
                        )
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 55,
                  right: 155,
                  child: Container(
                    height: 98,
                    width: MediaQuery.of(context).size.width/1.8,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      textDirection: TextDirection.rtl,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 2,),
                        Text("${widget.postOwnerName}",style: TextStyle(fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),
                        SizedBox(height: 2,),
//                      Text("A+",style: TextStyle(fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),

                      ],
                    )
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    height: 600,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                      color: kMainColor
                    ),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          bottom: 30,
                          right: 40,
                          child: Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              width: MediaQuery.of(context).size.width*.83,
                              height: 500,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Column(
                                  textDirection: TextDirection.rtl,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(right: 37.5),
                                      child: Row(
                                        textDirection: TextDirection.rtl,
                                        children: <Widget>[
                                          Text(": حساب بنك الدم",style: TextStyle(fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',fontSize: 16,fontWeight: FontWeight.bold))
                                        ,  SizedBox(width: 5,),
                                         Text("${widget.bankAccount}",style: TextStyle(fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',fontSize: 16,fontWeight: FontWeight.bold,color: kSecondColor))
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    //////// azbtha///
                                    Padding(
                                      padding: const EdgeInsets.only(right: 5),
                                      child: Row(
                                        textDirection: TextDirection.rtl,
                                        children: <Widget>[
                                          Text(": ما تم جمعه",style: TextStyle(fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',fontSize: 16,fontWeight: FontWeight.bold)),
                                          SizedBox(width: 10,),
                                      SleekCircularSlider(

                                        appearance: CircularSliderAppearance(

                                          infoProperties: InfoProperties(
                                            modifier:
                                                  (double value) {
                                                final roundedValue = widget.bloodCollected.ceil().toInt();
                                                return '${((roundedValue/widget.bloodNeed)*100).round()} %';
                                              }
                                            ,
                                            mainLabelStyle: TextStyle(fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',fontSize: 18,fontWeight: FontWeight.bold)
                                          ),

                                          angleRange: 200,
                                          startAngle: 170,
                                          customColors: CustomSliderColors(
                                            dotColor: Colors.white,
                                            progressBarColors: [
                                              Colors.yellowAccent,kSecondColor,

                                            ],

                                            trackColor: kMainColor
                                          ),

                                          size: 100,
                                            customWidths: CustomSliderWidths(progressBarWidth: 10)),

                                        min: 0,
                                        max: widget.bloodNeed.toDouble(),
                                        initialValue: widget.bloodCollected.toDouble(),
                                      ),

                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 17),
                                      child: Row(
                                        textDirection: TextDirection.rtl,
                                        children: <Widget>[
                                          Text(": عدد الاكياس المطلوبه ",style: TextStyle(fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',fontSize: 16,fontWeight: FontWeight.bold))
                                          ,  SizedBox(width: 20,),
                                          Text("${widget.bloodNeed}",style: TextStyle(fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',fontSize: 16,fontWeight: FontWeight.bold,color: kSecondColor))
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 6),
                                      child: Row(
                                        textDirection: TextDirection.rtl,
                                        children: <Widget>[
                                          Text(": اسم الحاله",style: TextStyle(fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',fontSize: 16,fontWeight: FontWeight.bold))
                                          ,  SizedBox(width: 20,),
                                          AutoSizeText(
                                            '${widget.name}',
                                            textAlign: TextAlign.right,

                                            presetFontSizes: [ 16, 13,10],
                                            style: TextStyle(color:kSecondColor,fontWeight: FontWeight.bold,fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic'),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          )  ,                                      ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 28),
                                      child: Row(
                                        textDirection: TextDirection.rtl,
                                        children: <Widget>[
                                          Text(": السن",style: TextStyle(fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',fontSize: 16,fontWeight: FontWeight.bold))
                                          ,  SizedBox(width: 5,),
                                          Text("${widget.age}",style: TextStyle(fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',fontSize: 16,fontWeight: FontWeight.bold,color: kSecondColor))
                                        ],
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(right: 19),
                                      child: Row(
                                        textDirection: TextDirection.rtl,
                                        children: <Widget>[
                                          Text(": النوع",style: TextStyle(fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',fontSize: 16,fontWeight: FontWeight.bold))
                                          ,  SizedBox(width: 5,),
                                          Text("${widget.gander}",style: TextStyle(fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',fontSize: 16,fontWeight: FontWeight.bold,color: kSecondColor))
                                        ],
                                      ),
                                    ),
                                  Row(
                                        textDirection: TextDirection.rtl,
                                        children: <Widget>[
                                          Text(": فصيله الدم",style: TextStyle(fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',fontSize: 16,fontWeight: FontWeight.bold))
                                          ,  SizedBox(width: 5,),
                                          Text("${widget.bloodType}",style: TextStyle(fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',fontSize: 16,fontWeight: FontWeight.bold,color: kSecondColor))
                                        ],
                                      ),
                                  Row(
                                        textDirection: TextDirection.rtl,
                                        children: <Widget>[
                                          SizedBox(
                                            width: 23,
                                          ),
                                          Text(": الهاتف",style: TextStyle(fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',fontSize: 16,fontWeight: FontWeight.bold))
                                          ,  SizedBox(width: 5,),
                                          Text("${widget.phone}",style: TextStyle(fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',fontSize: 16,fontWeight: FontWeight.bold,color: kSecondColor))
                                        ],
                                      ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                    Center(
                                      child: Container(
                                        width: MediaQuery.of(context).size.width/1.5,
                                        height: 50,
                                        child: ButtonWidget(
                                          text: '${widget.hospitalName}',
                                          borderColor: kSecondColor,
                                          onPressed: (){
                                            setState(() {
                                              _loading=true;
                                            });
                                            print(widget.location[0]);
                                            print(widget.location[1]);
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (BuildContext context) => GoogleMaps(lat: widget.location[0],lan: widget.location[1],)));
                                            _loading=false;

                                          },
                                          textColor: kSecondColor,
                                          color: Colors.white,
                                          height: 40,
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      width: MediaQuery.of(context).size.width/.83,
                                      child: ButtonWidget(

                                        height: 50,
                                        color: kSecondColor,
                                        textColor: Colors.white,
                                        onPressed: (){
                                          print("${widget.userId}");
                                          print("${widget.postOwnerName}");
                                          print("${widget.imageUrl}");
                                          print("${Provider.of<InfoProvider>(context).nameProfile}");
                                          print("${Provider.of<InfoProvider>(context).idProfile}");
                                          print("${Provider.of<InfoProvider>(context).imageUrlProfile}");


                                          createChatRomAndStartConverstion(context: context, imageUrl: widget.imageUrl,userId: widget.userId,userimages: widget.imageUrl,userNames: widget.postOwnerName,userName: widget.postOwnerName);
                                        },
                                        borderColor: kSecondColor,
                                        text: 'ارسال رساله',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 150,
                  right: 40,
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 140,
                      width: MediaQuery.of(context).size.width*.83,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)
                      ,color: Colors.white,),
                      child: Column(
                        textDirection: TextDirection.rtl,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 25,top: 4),
                            child: Text("وصف الحاله",style: TextStyle(fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',fontSize: 18,fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 25,left: 15,bottom: 3),
                            child: AutoSizeText(
                                  '${widget.description}',
                              textAlign: TextAlign.right,
                              presetFontSizes: [ 16, 13,12],
                              style: TextStyle(fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic'),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    ));
  }
}
