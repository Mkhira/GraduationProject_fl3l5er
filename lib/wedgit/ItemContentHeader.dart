import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:company_task/style/constent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

class Bar extends SliverPersistentHeaderDelegate {
  final double collapsedHeight;
  final double expandedHeight;
  final String image;

  final String itemName;
  final int itemAmount;

  Bar({
    this.collapsedHeight,
    this.expandedHeight,
    this.image,
    this.itemName,
    this.itemAmount

  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.amber,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child:          Container(
              color: Colors.white,
              child: ClipRRect(

                borderRadius:
                BorderRadius.circular(20),
                child: CachedNetworkImage(
                  imageUrl: image,
                  width: MediaQuery.of(context)
                      .size
                      .width ,
                  height: 300,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      CircularProgressIndicator(),
                  errorWidget:
                      (context, url, error) =>
                      Icon(Icons.error),

                  color: Colors.white,
                  placeholderFadeInDuration:
                  Duration(days: 30),
                  useOldImageOnUrlChange: true,
                  filterQuality:
                  FilterQuality.low,
                ),
              ),
            ),

          ),
          Positioned(bottom: 0, left: 0, child: appBar(itemAmount: itemAmount,itemName: itemName,)),
          Positioned(
              bottom: 0,
              left: 0,
              child: SizedBox(
                height: 10,
              )),
        ],
      ),
    );
  }

  double titelOpacity(double shrinkOffset) {
    return 1.0 - max(0.0, shrinkOffset) / minExtent;
  }

  @override
  double get minExtent => this.collapsedHeight;

  @override
  double get maxExtent => this.expandedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class appBar extends StatelessWidget {

  final String itemName;
  final int itemAmount;

  const appBar({

    this.itemAmount,
    this.itemName,
  }) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Text("Name:", style: HomeHeadreStyle),
          Text(
            " $itemName",
            style: TextStyle(color: Colors.black),
          ),
          Spacer(
            flex: 1,
          ),
          Text(
            "Amount:",
            style: HomeHeadreStyle,
          ),
          Text(
            " $itemAmount",
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}
