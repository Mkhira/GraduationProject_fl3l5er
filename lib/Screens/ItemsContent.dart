
import 'package:company_task/Screens/profile_screen.dart';
import 'package:company_task/provider/info_provider.dart';
import 'package:company_task/style/constent.dart';
import 'package:company_task/wedgit/ItemContentHeader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';


class ItemContent extends StatelessWidget {
 final String name;
 final int amount;
 final int phone;
 final String location;
 final String owner;
 final int dayLeft;
 final String imageUrl;
 final String state;
 ItemContent({this.name,this.imageUrl,this.phone,this.location,this.amount,this.owner,this.state,this.dayLeft});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kMainColor,
        body: CustomScrollView(
           slivers: <Widget>[



             SliverPersistentHeader(

                 pinned: true,
                 floating: false,
                 delegate: Bar(expandedHeight: 300, collapsedHeight: 200,image: '$imageUrl',itemAmount: amount,itemName: name)),
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
                         padding: const EdgeInsets.only(top: 24.0, bottom: 5.0),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: <Widget>[
                             Padding(
                               padding: const EdgeInsets.only(
                                   left: 15.0, right: 15.0, bottom: 8.0),
                               child: Row(
                                 crossAxisAlignment: CrossAxisAlignment.center,
                                 children: <Widget>[
                                   InkWell(
                                     child: Row(
                                       children: <Widget>[
                                         SizedBox(width: 10,),
                                         InkWell(
                                           highlightColor: Colors.transparent,
                                           splashColor: Colors.transparent,
                                           child: Row(
                                             children: <Widget>[
                                               Container(
                                                 decoration: BoxDecoration(
                                                     color: Colors.black12,
                                                     borderRadius: BorderRadius.all(
                                                         Radius.circular(15.0)),
                                                     shape: BoxShape.rectangle),
                                                 width: 40.0,
                                                 height: 40.0,
                                                 //todo make image to postMakerImage
                                                 child: Provider.of<InfoProvider>(
                                                     context)
                                                     .updatedImage ==
                                                     null
                                                     ? null
                                                     : ClipRRect(
                                                   borderRadius:
                                                   BorderRadius.circular(
                                                     15,
                                                   ),
                                                   child: Image.file(
                                                     Provider.of<InfoProvider>(
                                                         context)
                                                         .updatedImage,
                                                     fit: BoxFit.cover,
                                                   ),
                                                 ),
                                               ),
                                               SizedBox(
                                                 width: 5.0,
                                               ),
                                               Text(
                                                 //todo make name to postMaker
                                                           "$owner"    ,
                                                 style: TextStyle(
                                                     fontSize: 18.0,
                                                     fontWeight: FontWeight.w800),
                                               ),
                                             ],
                                           ),
                                           onTap: () {
                                             //todo make different profile screens for different users
                                             Navigator.pushNamed(
                                                 context, ProfileScreen.id);
                                           },
                                         ),
                                         Text(
                                           ' | ',
                                           style: TextStyle(
                                               fontSize: 30.0,
                                               fontWeight: FontWeight.w300),
                                         ),
                                         Icon(
                                           Icons.timer,
                                         ),
                                         Text(
                                           '$dayLeft ',
                                           style: TextStyle(
                                               fontSize: 20.0,
                                               fontWeight: FontWeight.w900),
                                         ),
                                         Text(
                                           'day left',
                                           style: TextStyle(
                                               fontSize: 17.0,
                                               fontWeight: FontWeight.w500),
                                         ),
                                       ],
                                     ),
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
                                       'Medicine Informations',
                                       style: TextStyle(
                                         color: kSecondColor,
                                         fontSize: 18,
                                       ),
                                     ),
                                     children: <Widget>[
                                       Padding(
                                         padding: const EdgeInsets.only(
                                             left: 15.0, right: 15.0, bottom: 10),
                                         child: Column(
                                           mainAxisSize: MainAxisSize.min,
                                           crossAxisAlignment:
                                           CrossAxisAlignment.start,
                                           children: <Widget>[
                                             SizedBox(
                                               height: 15.0,
                                             ),
                                             MedicinePostText(
                                               title: 'Name : ',
                                               value: '$name',
                                             ),

                                           state.contains("demond")==true? Container(height: 0,width: 0,):  MedicinePostText(
                                               title: 'Expire : ',
                                               value: '${Provider.of<InfoProvider>(context).expireDay}'
                                                   '/${Provider.of<InfoProvider>(context).expireMonth}'
                                                   '/${Provider.of<InfoProvider>(context).expireYear}',
                                             ),

                                             MedicinePostText(
                                               title: 'Uses : ',
                                               value:Provider.of<InfoProvider>(context).uses,
                                             ),
                                             MedicinePostText(
                                               title: 'State : ',
                                               value:'$state',
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
                                 crossAxisAlignment: CrossAxisAlignment.center,
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: <Widget>[
                                   SizedBox(width: 20,),

                                   Text("Phone: ",style: TextStyle(fontWeight: FontWeight.bold),),
                                   Text("0$phone"),
                                   Spacer(),
                                   SizedBox(width: 20,)

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
                               child: Material(
                                 elevation: 5.0,
                                 color: Colors.amber,
                                 borderRadius: BorderRadius.circular(15.0),
                                 child: MaterialButton(
                                   minWidth: 200.0,
                                   height: 55.0,
                                   hoverColor: Colors.transparent,
                                   onPressed: () {},
                                   child: Text(
                                     'Apply',
                                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                                   )
                                   ),
                               ),
                             ),
                           ],
                         ),
                       ),
                     ),
                   ),

                 ],),),

           ],
        ),
      ),
    );
  }
}


class MedicinePostText extends StatelessWidget {
  final String title, value;

  MedicinePostText({this.title, this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: HomeHeadreStyle
            ),
            Flexible(
              child: AutoSizeText(
                value,
                style: TextStyle(fontSize: 15,color: Colors.black),
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


