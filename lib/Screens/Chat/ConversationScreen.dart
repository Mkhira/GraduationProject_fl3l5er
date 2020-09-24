import 'package:cached_network_image/cached_network_image.dart';
import 'file:///E:/flater_projects/company_task/lib/Screens/Chat/ChatScreen.dart';
import 'package:company_task/provider/info_provider.dart';
import 'package:company_task/style/constent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:provider/provider.dart';

class ConversationScreen extends StatefulWidget {
  ConversationScreen({this.name, this.imageUrl, this.chatRoomId});
  final String name;
  final String chatRoomId;
  final String imageUrl;
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  TextEditingController messageController = TextEditingController();

  DataBaseMethods dataBaseMethods = DataBaseMethods();

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": messageController.text,
        "sender": Provider.of<InfoProvider>(context).nameProfile,
        "time": DateTime.now().millisecondsSinceEpoch
      };
      dataBaseMethods.addConversationMessages(widget.chatRoomId, messageMap);
      messageController.text = "";
    }
  }

  Stream chatMessageStream;
  @override
  void initState() {
    // TODO: implement initState
    dataBaseMethods.getConversationMessages(widget.chatRoomId).then((val) {
      setState(() {
        chatMessageStream = val;
      });
    });
    super.initState();
  }

  Widget chatMessageList() {
    return StreamBuilder(
      stream: chatMessageStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                padding: EdgeInsets.only(top: 15, left: 10, bottom: 10),
                reverse: true,
                shrinkWrap: true,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return MessageTail(
                    message: snapshot.data.documents[index].data["message"],
                    isMyName: snapshot.data.documents[index].data["sender"] ==
                        Provider.of<InfoProvider>(context).nameProfile,
                  );
                },
              )
            : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: kSecondColor,
            elevation: 0,
            title: Row(
              textDirection: TextDirection.rtl,
              children: <Widget>[
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(120),
                    child: CachedNetworkImage(
                      imageUrl: "${widget.imageUrl}",
                      height: 98,
                      width: 200,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      placeholderFadeInDuration: Duration(days: 30),
                      useOldImageOnUrlChange: true,
                      filterQuality: FilterQuality.low,
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  "${widget.name}",
                  style: TextStyle(
                      color: kMainColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: ArabicFonts.Amiri,
                      package: 'google_fonts_arabic',
                      fontSize: 20),
                ),
              ],
            ),
          ),
          backgroundColor: kSecondColor,
          body: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      color: Colors.white),
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      child: chatMessageList()),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                alignment: Alignment.bottomCenter,
                width: MediaQuery.of(context).size.width,
                height: 80,
                color: kMainColor,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white54,
                          ),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextField(
                              textDirection: TextDirection.rtl,
                              controller: messageController,
                              style: TextStyle(color: kSecondColor),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "   اكتب الرساله",
                                hintStyle: TextStyle(
                                  color: kSecondColor,
                                  fontFamily: ArabicFonts.Amiri,
                                  package: 'google_fonts_arabic',
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.send,
                          color: kSecondColor,
                          size: 30,
                        ),
                        onPressed: () {
                          sendMessage();
                        })
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

class MessageTail extends StatelessWidget {
  MessageTail({this.message, this.isMyName});

  final String message;
  final bool isMyName;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(left: isMyName ? 0 : 4, right: isMyName ? 10 : 0),
      margin: EdgeInsets.symmetric(
        vertical: 8,
      ),
      width: MediaQuery.of(context).size.width,
      alignment: isMyName ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: isMyName
                    ? [
                        Color(0xffFFC107),
                        Color(0xffFFC107),
                      ]
                    : [
                        kMainColor,
                        kMainColor,
                      ]),
            borderRadius: isMyName
                ? BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    topLeft: Radius.circular(20))
                : BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    topRight: Radius.circular(20))),
        child: Text(
          '$message',
          style: TextStyle(
              fontFamily: ArabicFonts.Amiri,
              package: 'google_fonts_arabic',
              fontSize: 14),
        ),
      ),
    );
  }
}
