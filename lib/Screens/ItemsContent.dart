
import 'file:///E:/flater_projects/company_task/lib/Screens/Profile/profile_screen.dart';
import 'package:company_task/Screens/Chat/ChatScreen.dart';
import 'package:company_task/Screens/Chat/ConversationScreen.dart';
import 'package:company_task/provider/info_provider.dart';
import 'package:company_task/style/constent.dart';
import 'package:company_task/wedgit/ItemContentHeader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'Maps/StaticMap.dart';


class ItemContent extends StatefulWidget {
 final String name;
 final int amount;
 final int phone;
 final List location;
 final String owner;
 final int dayLeft;
 final String imageUrl;
 final String userImage;
 final String state;
 final String information;
 final String description;
 final String userId;
 final String ownerName;
 ItemContent({this.ownerName,this.userId,this.name,this.imageUrl,this.phone,this.location,this.amount,this.owner,this.state,this.dayLeft,this.userImage,this.information,this.description});

  @override
  _ItemContentState createState() => _ItemContentState();
}

class _ItemContentState extends State<ItemContent> {
bool _loading=false;
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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kMainColor,
        body: ModalProgressHUD(
          inAsyncCall: _loading,

          child: CustomScrollView(
             slivers: <Widget>[
               SliverPersistentHeader(
                   pinned: true,
                   floating: false,
                   delegate: Bar(expandedHeight: 300, collapsedHeight: 200,image: '${widget.imageUrl}',itemAmount: widget.amount,itemName: widget.name)),
               SliverList(
                   delegate: SliverChildListDelegate(<Widget>[
                     Container(
                       decoration: BoxDecoration(
                         color: kMainColor, //Color(0xffEEEEEE),
                         borderRadius: BorderRadius.only(
                           topLeft: Radius.circular(40),
                           topRight: Radius.circular(40),
                         ),
                       ),
                       child: Padding(
                         padding: const EdgeInsets.only(top: 5.0),
                         child: Padding(
                           padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.end,
                             children: <Widget>[

                               Container(
                                 width: MediaQuery.of(context).size.width,
                                 child: Row(
                                   textDirection: TextDirection.rtl,
                                   children: <Widget>[
                                     SizedBox(width: 15,),
                                   Container(
                                                     decoration: BoxDecoration(

                                                         color: kSecondColor,
                                                         borderRadius: BorderRadius.all(
                                                             Radius.circular(15.0)),
                                                         shape: BoxShape.rectangle),
                                                     width: 55.0,
                                                     height: 55.0,
                                                     //todo make image to postMakerImage
                                                     child: widget.owner == "مجهول"

                                                         ? null
                                                         : ClipRRect(
                                                       borderRadius:
                                                       BorderRadius.circular(
                                                         15,
                                                       ),
                                                       child: Image(image: NetworkImage("${widget.userImage}"),
                                                         fit: BoxFit.cover,
                                                       ),
                                                     ),
                                                   ),
                                     SizedBox(width: 15,),
                                    Text(
                                                     //todo make name to postMaker
                                                               "${widget.owner}"    ,
                                                     style: TextStyle(
                                                         fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',
                                                         fontSize: 18.0,
                                                         fontWeight: FontWeight.w800),
                                                   ),
                                   ],
                                 ),
                               ),
                               SizedBox(height: 10,),
                               Container(
                                 width: MediaQuery.of(context).size.width,
                                 child: Row(
                                   textDirection: TextDirection.rtl,
                                   children: <Widget>[
                                     SizedBox(width: 5,),

                                    Text(
                                                               "-: الايام المتبقيه"    ,
                                                     style: TextStyle(
                                                         color: kSecondColor,

                                                         fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',
                                                         fontSize: 17.0,
                                                         fontWeight: FontWeight.w500),
                                                   ),
                                     SizedBox(width: 5,),
                                     Text(
                                       '${widget.dayLeft} ',
                                       style: TextStyle(
                                           fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',
                                           fontSize: 20.0,

                                           fontWeight: FontWeight.w900),
                                     ),
                                 SizedBox(width: 10,),
                                 Icon(
                                               Icons.timer,
                                   size: 25,
                                             ),

                                   ],
                                 ),
                               ),







                               Padding(
                                 padding: const EdgeInsets.all(15.0),
                                 child: Container(
                                   width: MediaQuery.of(context).size.width,
                                   decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(10),
                                       color: Colors.white //Color(0xffF4F7FA),
                                   ),
                                   child: Theme(
                                     data: ThemeData(
                                         unselectedWidgetColor: kSecondColor,
                                         accentColor: kSecondColor),
                                     child: ExpansionTile(

                                       initiallyExpanded: true,
                                       title: Text(

                                         '${widget.information}',
                                         style: TextStyle(

                                           fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',
                                           color: kSecondColor,
                                           fontSize: 18,
                                         ),
                                       ),
                                       children: <Widget>[
                                         Padding(
                                           padding: const EdgeInsets.only(
                                               left: 15.0, right: 15.0, bottom: 10),
                                           child: Column(
                                             textDirection: TextDirection.rtl,
                                             children: <Widget>[
                                               SizedBox(
                                                 height: 15.0,
                                               ),
                                               MedicinePostText(
                                                 title: ' :الإسم    ',
                                                 value: '${widget.name} ',
                                               ),

                                             Provider.of<InfoProvider>(context).medicineClick==true?   MedicinePostText(
                                                 title: ' :الإنتهاء   ',
                                                 value: '${widget.dayLeft}'
                                               ):Container(height: 0,width: 0,),

                                               MedicinePostText(
                                                 title: ' :الوصف     ',
                                                 value:"${widget.description}",
                                               ),
                                               MedicinePostText(
                                                 title: '  :الحاله',
                                                 value:'${widget.state}',
                                               ),
                                             ],
                                           ),
                                         ),
                                       ],
                                     ),
                                   ),
                                 ),
                               ),

                               Padding(
                                 padding: EdgeInsets.only(right: 10.0, left: 10.0),
                                 child: Divider(
                                   thickness: 5.0,
                                   color: Colors.white,
                                 ),
                               ),
                               Container(
                                 width: MediaQuery.of(context).size.width,
                                 child: Row(
                                      textDirection: TextDirection.rtl,
                                   children: <Widget>[
                                     SizedBox(width: 25,),

                                     Text(" :الهاتف",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',),),
                                     Text("0${widget.phone}",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',),),
                                     Spacer(),
                                     SizedBox(width: 25,)

                                   ],
                                 ),
                               ),

                               Padding(
                                 padding: EdgeInsets.only(right: 10.0, left: 10.0),
                                 child: Divider(
                                   thickness: 5.0,
                                   color: Colors.grey.shade100,
                                 ),
                               ),
                               SizedBox(
                                 height: 10,
                               ),
                                Center(
                                  child: GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        _loading=true;
                                      });
                                      print(widget.location[0]);
                                      print(widget.location[1]);
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (BuildContext context) => GoogleMaps(lat: widget.location[0],lan: widget.location[1],)));
                                      _loading=false;

                                    },
                                    child: Material(
                                      elevation: 4,
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        height: 200,
                                        width: MediaQuery.of(context).size.width/1.2,
                                        child: ClipRRect(
                                          borderRadius:  BorderRadius.circular(20),
                                          child: Image(image: AssetImage('assets/map.jpg'),fit: BoxFit.cover,),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                               SizedBox(
                                 height: 10,
                               ),
                               Center(
                                 child: Material(
                                   elevation: 5.0,
                                   color: Colors.amber,
                                   borderRadius: BorderRadius.circular(15.0),
                                   child: MaterialButton(
                                     minWidth: 200.0,
                                     height: 55.0,
                                     hoverColor: Colors.transparent,
                                     onPressed: () {

                                       print("${widget.userId}");
                                       print("${widget.userImage}");
                                       print("${widget.ownerName}");
                                       print("${Provider.of<InfoProvider>(context).UserLoginId}");
                                       print("${Provider.of<InfoProvider>(context).imageUrlProfile}");
                                       print("${Provider.of<InfoProvider>(context).nameProfile}");
                                       createChatRomAndStartConverstion(userName: widget.ownerName,userNames: widget.ownerName,context: context,
                                       userimages: widget.userImage,userId: widget.userId,imageUrl: widget.userImage
                                       );
                                     },
                                     child: Text(
                                       'محادثه',
                                       style: TextStyle(
                                           fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',
                                           fontWeight: FontWeight.bold, fontSize: 17),
                                     )
                                     ),
                                 ),
                               ),
                               SizedBox(
                                 height: 30,
                               )
                             ],
                           ),
                         ),
                       ),
                     ),
                   ],),),],),
        ),),);}}
class MedicinePostText extends StatelessWidget {
  final String title, value;

  MedicinePostText({this.title, this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          textDirection: TextDirection.rtl,
          children: <Widget>[
            Text(
              title,
              style: HomeHeadreStyle
            ),
            Flexible(
              child: AutoSizeText(
                value,
                style: TextStyle(fontSize: 15,color: Colors.black,fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',),
                minFontSize: 9,
                stepGranularity: 9,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),)
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
      ],
    );
  }
}


