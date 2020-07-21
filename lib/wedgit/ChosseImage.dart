import 'package:company_task/provider/AddPostProvider.dart';
import 'package:company_task/style/constent.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ChosseImage extends StatefulWidget {
  const ChosseImage({
    Key key,
  }) : super(key: key);

  @override
  _ChosseImageState createState() => _ChosseImageState();
}

class _ChosseImageState extends State<ChosseImage> {



  @override
  Widget build(BuildContext context) {
   var provider = Provider.of<AddPostProvider>(context);
    return Container(
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
      ),
      height: 150,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10,),
          GestureDetector(
            onTap: (){
              setState(() {
                provider.openCamera(context);


              });
            },
            child: Container(width: MediaQuery.of(context).size.width/2,
              height: 50,
              child: ListTile(
                leading: Icon(FontAwesomeIcons.camera,color: kSecondColor,),
                title: Text("Camera",style: TextStyle(color: kSecondColor,fontWeight: FontWeight.bold),),
              ),
            ),
          ),
          Spacer(flex: 1,),
          GestureDetector(
            onTap: (){
              provider.openGallary(context);
            },
            child: Container(width: MediaQuery.of(context).size.width/2,
              height: 50,
              child: ListTile(
                leading: Icon(FontAwesomeIcons.image,color: kSecondColor,),
                title: Text("Gallery",style: TextStyle(color: kSecondColor,fontWeight: FontWeight.bold),),
              ),
            ),
          ),
          SizedBox(height: 10,),

        ],
      ),
    );
  }
}
