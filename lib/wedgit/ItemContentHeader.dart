import 'dart:math';

import 'package:company_task/style/constent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

class Bar extends SliverPersistentHeaderDelegate {
  final double collapsedHeight;
  final double expandedHeight;

  Bar({
    this.collapsedHeight,
    this.expandedHeight,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: Image(
              image: AssetImage("assets/me.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(bottom: 0, left: 0, child: appBar()),
        Positioned(
            bottom: 0,
            left: 0,
            child: SizedBox(
              height: 10,
            )),
      ],
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
  const appBar({
    Key key,
  }) : super(key: key);

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
            " Insulin",
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
            " 10",
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
