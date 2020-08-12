



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_task/Screens/ChatScreen.dart';
import 'package:company_task/Screens/ConversationScreen.dart';
import 'package:company_task/provider/info_provider.dart';
import 'package:company_task/style/constent.dart';
import 'package:company_task/wedgit/ButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:provider/provider.dart';

class ChatSearchScreen extends StatefulWidget {
  @override
  _ChatSearchScreenState createState() => _ChatSearchScreenState();
}

class _ChatSearchScreenState extends State<ChatSearchScreen> {

  DataBaseMethods dataBaseMethods = DataBaseMethods();

  final nameController = TextEditingController();

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
  QuerySnapshot querySnapshot;
  createChatRomAndStartConverstion({String userId, String userName, String imageUrl,String userNames,String userimages}) {

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

  inateSearch(){

    dataBaseMethods.getUserByName(nameController.text).then((val){
      print(val.toString());
      setState(() {
        querySnapshot = val;

      });
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:        CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              pinned: false,
              floating: false,
              delegate: ChatHeader(
                  maxxExtent: 100,
                  minnExtent: 100,
                  nameController: nameController,
                  onPressed: (){
                    inateSearch();
                  }
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[
                  SizedBox(
                    height: 10,

                  ),
//                  ChatRoomList(),
                  querySnapshot !=null ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: querySnapshot.documents.length,
                    itemBuilder: (context,index){
                      return Padding(
                        padding: const EdgeInsets.only(top:10.0,bottom: 10),
                        child: UserContainer(
                          imgeUrl: querySnapshot.documents[index].data["image"],
                          name: querySnapshot.documents[index].data["name"],
                          userID: querySnapshot.documents[index].data["userId"],
                            onPressed: (){
                              createChatRomAndStartConverstion(
                                  userId: querySnapshot.documents[index].data["userId"], userName:querySnapshot.documents[index].data["name"],
                                  imageUrl: querySnapshot.documents[index].data["image"],userNames: querySnapshot.documents[index].data["username"],
                                userimages: querySnapshot.documents[index].data["userimage"]


                              );

                            },
                        ),
                      );
                    },
                  ): Container(),
                ],
              ),
            ),

          ],
        )
        ,
      ),
    );
  }
}
class UserContainer extends StatelessWidget {
  UserContainer({this.imgeUrl,this.name,this.userID,this.onPressed});
  final String imgeUrl;
  final   String name;
  final String userID;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        elevation: 3,
        child: Container(
          width: MediaQuery.of(context).size.width - 40,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          height: 100,
          child: Row(
            textDirection: TextDirection.rtl,
            children: <Widget>[
              SizedBox(
                width: 10,
              ),
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kSecondColor,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(120),
                  child: Image(image: NetworkImage('$imgeUrl')),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "$name",
                style: TextStyle(
                  fontFamily: ArabicFonts.Amiri,
                  package: 'google_fonts_arabic',
                ),
                textDirection: TextDirection.rtl,
              ),
              Spacer(),
              Container(
                height: 40,
                child: ButtonWidget(
                  color: kSecondColor,
                  height: 40,
                  textColor: Colors.white,
                  onPressed: onPressed,
                  borderColor: kSecondColor,
                  text: 'محادثه',
                ),
              ),
              SizedBox(
                width: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
