import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_task/Block/Block.dart';
import '../Chat/ChatSearchScreen.dart';
import '../Chat/ConversationScreen.dart';
import 'package:company_task/Utli/Common.dart';
import 'package:company_task/models/ChatModel.dart';
import 'package:company_task/provider/info_provider.dart';
import 'package:company_task/style/constent.dart';
import 'package:company_task/wedgit/ButtonWidget.dart';
import 'package:company_task/wedgit/OurTextFeilds/MyMainTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:provider/provider.dart';

class ChatScreenPage extends StatefulWidget {
  @override
  _ChatScreenPageState createState() => _ChatScreenPageState();
}
class _ChatScreenPageState extends State<ChatScreenPage> {









  DataBaseMethods dataBaseMethods = DataBaseMethods();
  getChatRoomID(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else
      return "$a\_$b";
  }

  createChatRomAndStartConverstion({String userId, String userName, String imageUrl}) {
    String chatRoom_id =
        getChatRoomID(userId, Provider.of<InfoProvider>(context).UserLoginId);
      String userNames = getChatRoomID(userName, Provider.of<InfoProvider>(context).name );
    List<String> users = [
      userName,
      Provider.of<InfoProvider>(context).nameProfile
    ];
    Map<String, dynamic> chatRoomMap = {
      'users': users,
      'chatrooid': chatRoom_id,
      "image": imageUrl,
      "userid": userId,
      "username": userNames
    };
    dataBaseMethods.createChatRoom(chatRoom_id, chatRoomMap);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ConversationScreen(
                  chatRoomId: chatRoom_id,
                  name: userName,
                  imageUrl: imageUrl,
                )));
  }







  Widget ChatRoomList() {
    return  StreamBuilder<List<ChatModel>>(
      stream: _bloc.streamChatRoom,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            var data = snapshot.data[index];

            return Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10),
              child: UserContainer(
                chatModel: data,

              ),
            );
          },
        )
            : Container();
      },
    );
  }

     openConversation({String chatRoom_id,String userName,String imageUrl}){
       dataBaseMethods.getConversationMessages(chatRoom_id);
       Navigator.push(
           context,
           MaterialPageRoute(
               builder: (context) => ConversationScreen(
                 chatRoomId: chatRoom_id,
                 name: userName,
                 imageUrl: imageUrl,
               )));
     }


  Bloc _bloc = Bloc();
  @override
  void initState() {
    // TODO: implement initState
     _bloc.fetchChatRoom(context);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: kSecondColor,
            child: Icon(Icons.search),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChatSearchScreen()));
            },
          ),
          appBar: AppBar(
            backgroundColor: kSecondColor,
            title: Text(
              "الرسائل",
              style: TextStyle(
                fontFamily: ArabicFonts.Amiri,
                package: 'google_fonts_arabic',
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
          body: CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    ChatRoomList(),
//                  querySnapshot !=null ? ListView.builder(
//                    shrinkWrap: true,
//                    itemCount: querySnapshot.documents.length,
//                    itemBuilder: (context,index){
//                      return Padding(
//                        padding: const EdgeInsets.only(top:10.0,bottom: 10),
//                        child: UserContainer(
//                          imgeUrl: querySnapshot.documents[index].data["image"],
//                          name: querySnapshot.documents[index].data["name"],
//                          userID: querySnapshot.documents[index].data["userId"],
//
//                        ),
//                      );
//                    },
//                  ): Container(),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
class ChatHeader implements SliverPersistentHeaderDelegate {
  ChatHeader(
      {this.maxxExtent, this.minnExtent, this.nameController, this.onPressed});
  final double minnExtent;
  final double maxxExtent;
  final Function onPressed;
  final TextEditingController nameController;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: Column(
        children: <Widget>[
          Container(
            height: 30,
          ),
          Container(
            height: 70,
            child: MyMainTextField(
              width: MediaQuery.of(context).size.width - 40,
              hintText: 'اسم المستخدم',
              labelText: 'ابحث بالأسم',
              inputController: nameController,
              widget: IconButton(
                icon: Icon(
                  Icons.search,
                  size: 25,
                  color: kSecondColor,
                ),
                onPressed: onPressed,
              ),
              inputType: TextInputType.text,
            ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => minExtent;

  @override
  // TODO: implement minExtent
  double get minExtent => maxxExtent;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return true;
  }

  @override
  // TODO: implement snapConfiguration
  FloatingHeaderSnapConfiguration get snapConfiguration => null;

  @override
  // TODO: implement stretchConfiguration
  OverScrollHeaderStretchConfiguration get stretchConfiguration => null;
}














class DataBaseMethods {
  getUserByName(String name) async {
    return await Firestore.instance
        .collection('Users')
        .where('name', isGreaterThanOrEqualTo: name)
        .getDocuments();
  }

  createChatRoom(String roomID, chatRoomMap) {
    Firestore.instance
        .collection("chatRoom")
        .document(roomID)
        .setData(chatRoomMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  addConversationMessages(String chatRoomId, messageMap) {
    Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .collection("chat")
        .add(messageMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  getConversationMessages(String chatRoomId) async {
    return await Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .collection("chat")
        .orderBy("time", descending: true)
        .snapshots();



  }

//  getChatRooms(String userName) async {
//    return await Firestore.instance
//        .collection("chatRoom")
//        .where("users", arrayContains: userName)
//        .snapshots();
//  }
}




class UserContainer extends StatelessWidget {
  UserContainer({this.chatModel,});
    final ChatModel chatModel;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: GestureDetector(
        onTap:   (){

          print("${chatModel.roomId}");
          Navigator.push(context, MaterialPageRoute(builder: (context)=> ConversationScreen(
            imageUrl:chatModel.usersImage.toString().replaceAll("(#_*)", "").replaceAll("${Provider.of<InfoProvider>(context).imageUrlProfile}", "") ,
            name: chatModel.usersName.toString().replaceAll("_", "").replaceAll("${Provider.of<InfoProvider>(context).nameProfile}", ""),
            chatRoomId: chatModel.roomId,

          )));
        },
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
                    child: Image(image: NetworkImage('${chatModel.usersImage.toString().replaceAll("(#_*)", "").replaceAll("${Provider.of<InfoProvider>(context).imageUrlProfile}", "")}')),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "${chatModel.usersName.toString().replaceAll("_", "").replaceAll("${Provider.of<InfoProvider>(context).nameProfile}", "")}",
                  style: TextStyle(
                    fontFamily: ArabicFonts.Amiri,
                    package: 'google_fonts_arabic',
                  ),
                  textDirection: TextDirection.rtl,
                ),
                Spacer(),

                SizedBox(
                  width: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
