import 'package:flutter/material.dart';
import 'package:company_task/models/carouseModel.dart';
import 'package:company_task/provider/taskData.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../style/conist.dart';
import 'package:carousel_slider/carousel_slider.dart';





class caruselBuilder extends StatelessWidget {
  const caruselBuilder({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(builder: (context,carsour,child){
      return
        CarouselSlider.builder(
          autoPlay: true,
//          enlargeCenterPage: true,
//          pauseAutoPlayOnTouch: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          itemBuilder: (context, index) {
            final list = carsour.test[index];

            return
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                carouselList(list: list),
              );
          },
          itemCount: carsour.testCount,
        );
    });
  }
}

class carouselList extends StatelessWidget {
  const carouselList({
    Key key,
    @required this.list,
  }) : super(key: key);

  final carousModel list;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      height: 190,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20)),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: MediaQuery.of(context).size.width - 100,
              height: 190,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                  image: AssetImage(
                    list.image,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xffffffff).withOpacity(.5),
              ),
              width: MediaQuery.of(context).size.width - 100,
              height: 190,
            ),
          ),

          Positioned(
            bottom: 30,
            left: 15,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(list.head,style: carousHeader,)
                , Text(list.time,style: carouslittle,)
              ],
            ),

          )
        ],
      ),
    );
  }
}
