



import 'package:cached_network_image/cached_network_image.dart';
import 'package:company_task/style/constent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostsMaterial extends StatelessWidget {
  const PostsMaterial({
    this.state,this.name,this.phone,this.owner,this.imageUrl,this.type

  });

  final String name;
  final String imageUrl;
  final String owner;
  final String state;
  final String type;
  final int phone;


  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      elevation: 4,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: <Widget>[
              Expanded(
                child: ClipRRect(
                  borderRadius:
                  BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    width: MediaQuery.of(context)
                        .size
                        .width /2.18,
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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                          "$type: $name",
                          style: kPostStyleArabicBase
                      ),


                      Text(
                          "المالك: $owner",
                          style: kPostStyleArabicBase
                      ),

                      Text(
                        "الهاتف: 0$phone",
                        style: kPostStyleArabicBase,
                      ),

                      Text(
                          "الحاله: $state",
                          style: kPostStyleArabicBase
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
