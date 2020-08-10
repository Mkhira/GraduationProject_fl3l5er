






import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_task/style/constent.dart';
import 'package:company_task/wedgit/ButtonWidget.dart';
import 'package:company_task/wedgit/OurTextFeilds/MyMainTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts_arabic/fonts.dart';

class ChatScreenPage extends StatefulWidget { 
  @override
  _ChatScreenPageState createState() => _ChatScreenPageState();
}

class _ChatScreenPageState extends State<ChatScreenPage> {
  DataBaseMethods dataBaseMethods = DataBaseMethods();

  final nameController = TextEditingController();


   QuerySnapshot querySnapshot;

  inateSearch(){

    dataBaseMethods.getUserByName(nameController.text).then((val){
      print(val.toString());
      setState(() {
        querySnapshot = val;

      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kSecondColor,
          title: Text("الرسائل",style: TextStyle(fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',),textDirection: TextDirection.rtl,),

        ),
        body: CustomScrollView(
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
                  querySnapshot !=null ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: querySnapshot.documents.length,
                    itemBuilder: (context,index){
                      return UserContainer(
                        imgeUrl: querySnapshot.documents[index].data["image"],
                        name: querySnapshot.documents[index].data["name"],
                        onPressed: (){

                        },
                      );
                    },
                  ): Container(),
                ],
              ),
            ),

          ],
        )
      ),
    );
  }

}


class ChatHeader implements SliverPersistentHeaderDelegate {
  ChatHeader({this.maxxExtent, this.minnExtent,this.nameController,this.onPressed });
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
          ),Container(
            height: 70,
           child: MyMainTextField(
             width: MediaQuery.of(context).size.width-40,
             hintText: 'اسم المستخدم',
             labelText: 'ابحث بالأسم',
              inputController: nameController,
          widget: IconButton(icon:  Icon(Icons.search,size: 25,color: kSecondColor,), onPressed: onPressed,),

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


class UserContainer extends StatelessWidget {
  UserContainer({this.name,this.onPressed,this.imgeUrl});
  final String imgeUrl;
  final String name;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(left: 15,right: 15),
      child: Material(
          borderRadius: BorderRadius.circular(20),

          elevation: 3,
          child: Container(
              width: MediaQuery.of(context).size.width-40,
              decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(20)
              ),
              height: 100,
              child: Row(
                textDirection: TextDirection.rtl,
                children: <Widget>[

                   SizedBox(width: 10,),
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(shape: BoxShape.circle,
                      color: kSecondColor,

                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(120),
                      child: Image(image: NetworkImage('$imgeUrl')),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Text("$name",style: TextStyle(fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',),textDirection: TextDirection.rtl,),                  Spacer(),
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
                  SizedBox(width: 10,)
                ],
              ),


        ),
      ),
    );
  }
}



class DataBaseMethods{


  getUserByName(String name) async{

   return await Firestore.instance.collection('Users').where('name',isEqualTo: name).getDocuments();
  }



}
