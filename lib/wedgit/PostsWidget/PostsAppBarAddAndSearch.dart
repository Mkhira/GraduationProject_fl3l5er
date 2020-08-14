




import 'package:cached_network_image/cached_network_image.dart';
import 'file:///E:/flater_projects/company_task/lib/Screens/Profile/profile_screen.dart';
import 'package:company_task/provider/info_provider.dart';
import 'package:company_task/style/constent.dart';
import 'package:company_task/wedgit/OurTextFeilds/MainTextFeild.dart';
import 'package:company_task/wedgit/OurTextFeilds/MyMainTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostsAppBarrHeader extends StatefulWidget {

  final Stream blocStream;
  final Function state;
  final Function add;
  PostsAppBarrHeader({this.state,this.blocStream,this.add});
  @override
  _PostsAppBarrHeaderState createState() => _PostsAppBarrHeaderState();
}

class _PostsAppBarrHeaderState extends State<PostsAppBarrHeader> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      decoration: BoxDecoration(
          color: Color(0xffe6e6ea),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20))),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FloatingActionButton(
                mini: false,
                onPressed:widget.add,
                heroTag: "vc",
                child: Icon(
                  Icons.add,
                  color: kSecondColor,
                  size: 40,
                ),
                elevation: 3,
                backgroundColor: Colors.white,
              ),
              Spacer(
                flex: 2,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.circular(10)
                ),
                child: MyMainTextFieldSearch(
                     width: MediaQuery.of(context).size.width/1.7,
                     widget: Icon(Icons.search,color: kSecondColor,),
                     labelText: "ابحث",
                     hintText: "ابحث",
                     height: 60,
                     textChange: widget.state,
                     textStream: widget.blocStream,
                     inputType: TextInputType.text,
                   ),
              ),
              Spacer(
                flex: 2,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ProfileScreen.id);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.all(Radius.circular(10.0)),
                  ),
                  width: 65.0,
                  height: 65.0,
                  child:
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
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
              ),
              Spacer(
                flex: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//StreamBuilder(
//stream: widget.blocStream,
//builder: (context, snapshot) {
//return TextField(
//onChanged: widget.state,
//decoration: InputDecoration(
//hintText: 'ابحث عن احتياجاتك',
//border: InputBorder.none,
//),
//);
//}),
