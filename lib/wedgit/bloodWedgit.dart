
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:company_task/provider/info_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../style/constent.dart';




//class BloodListBuilder extends StatelessWidget {
//  const BloodListBuilder({
//    Key key,
//  }) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return
////      Consumer<InfoProvider>(
////      builder: (context, BloodList, chilid) {
////        return ListView.builder(
////          scrollDirection: Axis.vertical,
////          itemBuilder: (context, index) {
////            final list = BloodList.bloodList[index];
////
////            return Padding(
////              padding: const EdgeInsets.only(bottom: 15, top: 15),
////              child: donationList(
////                name: list.name,
////                description: list.description,
////                imageUrl: list.imageUrl,
////                icon: list.icon,
////                blood: list.blood,
////              ),
////            );
////          },
////          itemCount: BloodList.bloodListCount,
////        );
////      },
////    );
//  }
//}

class donationList extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String description;
  final String blood;
  final Function onPressed;
  donationList(
      {this.imageUrl,  this.name, this.description, this.blood,this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(20),

        child: Container(

          width: MediaQuery.of(context).size.width-20,
          height: 130,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
               textDirection: TextDirection.rtl,
              children: <Widget>[
                SizedBox(width: 5,),
                Container(
                  height: 85,
                  width: 60,
                  decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15)
                  ),
                  child: ClipRRect(
                    borderRadius:
                    BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      width: MediaQuery.of(context)
                          .size
                          .width /
                          2.18,
                      height: 180,
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

                Spacer(
                  flex: 2,
                ),

                Container(
                  padding: EdgeInsets.only(right: 10),
                  width: MediaQuery.of(context).size.width/1.6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    textDirection: TextDirection.rtl,
                    children: <Widget>[
                      Text(
                        name,
                        textDirection: TextDirection.rtl,
                        style: HomeHeadreStyle,
                      ),
                      SizedBox(height: 10,),
                      AutoSizeText(
                        "$description",
                        textDirection: TextDirection.rtl,
                        presetFontSizes: [10,8,5,2],
                        style: TextStyle(fontWeight: FontWeight.bold,color: kSecondColor),

                    
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                    ],
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      blood,
                      style: kBlood,
                    ),
                  ],
                ),
                Spacer(
                  flex: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

