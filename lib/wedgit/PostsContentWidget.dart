//
//
//
//import 'package:cached_network_image/cached_network_image.dart';
//import 'package:company_task/Screens/ItemsContent.dart';
//import 'package:company_task/models/ClothesModel.dart';
//import 'package:company_task/models/medicenModel.dart';
//import 'package:company_task/style/constent.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//
//class PostsContentWidget extends StatelessWidget {
//
//  PostsContentWidget({});
//  @override
//  Widget build(BuildContext context) {
//
//    return GestureDetector(
//      onTap: (){
//        Navigator.push(context, MaterialPageRoute(builder: (context){
//          return ItemContent(phone: medicineModel.phone,name: medicineModel.name,location: medicineModel.location,imageUrl: medicineModel.imageUrl,amount: medicineModel.amount,
//            dayLeft: medicineModel.dayLeft,owner: medicineModel.owner,state: medicineModel.state,
//          );
//        }));
//      },
//      child: Material(
//        borderRadius: BorderRadius.circular(20),
//        elevation: 4,
//        child: Container(
//          decoration: BoxDecoration(
//            borderRadius: BorderRadius.circular(20),
//            color: kSecondColor,
//          ),
//          child: Stack(
//            children: <Widget>[
//              Positioned(
//                top: 0,
//                left: 0,
//                child: ClipRRect(
//                  borderRadius:
//                  BorderRadius.circular(20),
//                  child: CachedNetworkImage(
//                    imageUrl: image,
//                    width: MediaQuery.of(context)
//                        .size
//                        .width /
//                        2.18,
//                    height: 180,
//                    fit: BoxFit.cover,
//                    placeholder: (context, url) =>
//                        CircularProgressIndicator(),
//                    errorWidget:
//                        (context, url, error) =>
//                        Icon(Icons.error),
//                    placeholderFadeInDuration:
//                    Duration(days: 30),
//                    useOldImageOnUrlChange: true,
//                    filterQuality:
//                    FilterQuality.low,
//                  ),
//                ),
//              ),
//              Positioned(
//                top: 195,
//                left: 15,
//                child: Container(
//                  width: MediaQuery.of(context)
//                      .size
//                      .width /
//                      2.2,
//                  child: Row(
//                    children: <Widget>[
//                      Text(
//                        "Name: ",
//                        style: TextStyle(
//                            color: Colors.white),
//                      ),
//                      Text(
//                        "${medicineModel.name}",
//                        style: TextStyle(
//                            color: Colors.black,
//                            fontWeight:
//                            FontWeight.bold),
//                      )
//                    ],
//                  ),
//                ),
//              ),
//              Positioned(
//                top: 220,
//                left: 15,
//                child: Container(
//                  width: MediaQuery.of(context)
//                      .size
//                      .width /
//                      2.2,
//                  child: Row(
//                    children: <Widget>[
//                      Text(
//                        "Owner: ",
//                        style: TextStyle(
//                            color: Colors.white),
//                      ),
//                      Text(
//                        "${medicineModel.owner}",
//                        style: TextStyle(
//                            color: Colors.black,
//                            fontWeight:
//                            FontWeight.bold),
//                      )
//                    ],
//                  ),
//                ),
//              ),
//              Positioned(
//                top: 245,
//                left: 15,
//                child: Container(
//                  width: MediaQuery.of(context)
//                      .size
//                      .width /
//                      2.2,
//                  child: Row(
//                    children: <Widget>[
//                      Text(
//                        "Phone: ",
//                        style: TextStyle(
//                            color: Colors.white),
//                      ),
//                      Text(
//                        "0${medicineModel.phone}",
//                        style: TextStyle(
//                            color: Colors.black,
//                            fontWeight:
//                            FontWeight.bold,fontSize: 13),
//                      )
//                    ],
//                  ),
//                ),
//              ),
//              Positioned(
//                top: 270,
//                left: 15,
//                child: Container(
//                  width: MediaQuery.of(context)
//                      .size
//                      .width /
//                      2.2,
//                  child: Row(
//                    children: <Widget>[
//                      Text(
//                        "State: ",
//                        style: TextStyle(
//                            color: Colors.white),
//                      ),
//                      Text(
//                        "${medicineModel.state}",
//                        style: TextStyle(
//                            color: Colors.black,
//                            fontWeight:
//                            FontWeight.bold),
//                      )
//                    ],
//                  ),
//                ),
//              ),
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//}