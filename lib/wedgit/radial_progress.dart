import 'package:flutter/material.dart';

class RadialProgress extends StatefulWidget {
  final int value;
  final double height;

  RadialProgress({this.value,this.height});

  @override
  _RadialProgressState createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress> {

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Stack(
      children: <Widget>[
        Container(
          width:width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: Colors.grey.shade200,
          ),
        ),
        Container(
          width:(width/100)*(widget.value/100),
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: Color(0xFFF9A155),
          ),
        ),

      ],
    );
  }
}
