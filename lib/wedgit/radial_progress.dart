import 'package:flutter/material.dart';

class RadialProgress extends StatefulWidget {
  final double value;
  final double width;
  final double height;
  RadialProgress({this.value, this.width, this.height});
  @override
  _RadialProgressState createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 3000),
    );
    animation = Tween(begin: 0.0, end: widget.value).animate(animationController);
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: widget.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                color: Colors.grey.shade200,
              ),
            ),
            Container(
              width: animation.value*2.0,
              height: widget.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                //color: Colors.green
                gradient: LinearGradient(
                    colors: <Color>[Color(0XFFFC4A1F), Color(0XFFAF1055)]),
              ),
            ),
//             Positioned(
//               right: 85,
//               child: Text(
//                 animation.value.toInt().toString(),
//               ),
//             )
          ],
        );
      },
    );
  }
}
