



import 'package:cached_network_image/cached_network_image.dart';
import 'package:company_task/style/constent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostsMaterial extends StatelessWidget {
  const PostsMaterial({
    this.state,this.name,this.phone,this.owner,this.imageUrl

  });

  final String name;
  final String imageUrl;
  final String owner;
  final String state;
  final int phone;


  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: kSecondColor,
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: ClipRRect(
                borderRadius:
                BorderRadius.circular(20),
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
            Positioned(
              top: 192,
              right: 24,
              child: Container(
                width: MediaQuery.of(context)
                    .size
                    .width /
                    2.2,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                        "$name",
                        style: kPostStyleArabicChange
                    ),
                    Text(
                        " : الملبس",
                        style: kPostStyleArabicBase
                    ),

                  ],
                ),
              ),
            ),
            Positioned(
              top: 217,
              right: 12.5,
              child: Container(
                width: MediaQuery.of(context)
                    .size
                    .width /
                    2.2,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                        "$owner",
                        style: kPostStyleArabicChange
                    ),
                    Text(
                        " : المالك",
                        style: kPostStyleArabicBase
                    ),

                  ],
                ),
              ),
            ),
            Positioned(
              top: 238,
              right: 23,
              child: Container(
                width: MediaQuery.of(context)
                    .size
                    .width /
                    2.2,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "0$phone",
                      style: kPostStyleArabicChange,
                    ),
                    Text(
                        " : الهاتف",
                        style: kPostStyleArabicBase
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 260,
              right: 5,
              child: Container(
                width: MediaQuery.of(context)
                    .size
                    .width /
                    2.2,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[

                    Text(
                        "$state",
                        style: kPostStyleArabicChange
                    ),
                    Text(
                        " : الحاله",
                        style: kPostStyleArabicBase
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}