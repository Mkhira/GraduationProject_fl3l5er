import 'package:company_task/Screens/profile_screen.dart';
import 'package:company_task/provider/info_provider.dart';
import 'package:company_task/wedgit/main_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MedicineScreen extends StatefulWidget {
  static const String id = 'medicine_screen';

  @override
  _MedicineScreenState createState() => _MedicineScreenState();
}

class _MedicineScreenState extends State<MedicineScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;//, _slideAnimation, _fadeAnimation;
  double expandedHeightFactor = .55;
  double collapsedHeightFactor = .80;
  bool isAnimatedCompleted = false;
  double screenHeight = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _animation =
        Tween<double>(begin: collapsedHeightFactor, end: expandedHeightFactor)
            .animate(_controller);

//    _slideAnimation = TweenSequence([
//      TweenSequenceItem<Offset>(
//          weight: 10, tween: Tween(begin: Offset(0, 0), end: Offset(0, 1))),
//      TweenSequenceItem<Offset>(
//          weight: 90, tween: Tween(begin: Offset(0, 1), end: Offset(0, 0))),
//    ]).animate(_controller);
//
//    _fadeAnimation = TweenSequence([
//      TweenSequenceItem<double>(weight: 10, tween: Tween(begin: 1.0, end: 0.0)),
//      TweenSequenceItem<double>(weight: 90, tween: Tween(begin: 0.0, end: 1.0)),
//    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onBottomPartTap() {
    setState(() {
      if (isAnimatedCompleted) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
      isAnimatedCompleted = !isAnimatedCompleted;
    });
  }

  Widget getWidget() {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        FractionallySizedBox(
          heightFactor: _animation.value,
          alignment: Alignment.topCenter,
          child: ProfilePageView(),
        ),
        Positioned(
          top: 40.0,
          left: 0.0,
          child: Container(
            margin: EdgeInsets.only(left: 25.0),
            decoration: BoxDecoration(
              color: Colors.white30,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        GestureDetector(
          onTap: onBottomPartTap,
          onVerticalDragUpdate: handleVerticalDrag,
          onVerticalDragEnd: handelVerticalEnd,
          child: FractionallySizedBox(
            heightFactor: 1.05 - _animation.value,
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, //Color(0xffEEEEEE),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: SingleChildScrollView(
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
                                    Text(
                                      'By',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w900),
                                    ),
                                    Text(
                                      ' | ',
                                      style: TextStyle(
                                          fontSize: 32.0,
                                          fontWeight: FontWeight.w300),
                                    ),
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
                                            Provider.of<InfoProvider>(context)
                                                .name,
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
                                  ],
                                ),
                              ),
                              Row(
                                children: <Widget>[
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
                                    '${Provider.of<InfoProvider>(context).daysLeft} ',
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
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 10.0, left: 15.0, top: 8.0),
                          child: Text(
                            'Last Appliers',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.0,
                              color: Colors.grey,
                              fontSize: 22.0,
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  left: 6.0,
                                  right: 5.0,
                                ),
                                child: Container(
                                  width: 60,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0)),
                                      shape: BoxShape.rectangle),
                                  //todo different user's images that apply to medicine
                                  child: Provider.of<InfoProvider>(context)
                                      .updatedImage ==
                                      null
                                      ? null
                                      : ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(15),
                                    child: Image.file(
                                      Provider.of<InfoProvider>(context)
                                          .updatedImage,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                            scrollDirection: Axis.horizontal,
                            itemCount: 7, //todo num of appliers
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10.0, left: 10.0),
                          child: Divider(
                            thickness: 5.0,
                            color: Colors.grey.shade100,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black //Color(0xffF4F7FA),
                            ),
                            child: Theme(
                              data: ThemeData(
                                  unselectedWidgetColor: Colors.white,
                                  accentColor: Colors.white),
                              child: ExpansionTile(
                                initiallyExpanded: true,
                                title: Text(
                                  'Medicine Informations',
                                  style: TextStyle(
                                    color: Colors.white30,
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
                                          value: Provider.of<InfoProvider>(context).medicineName,
                                        ),

                                        MedicinePostText(
                                          title: 'Expire Date : ',
                                          value: '${Provider.of<InfoProvider>(context).expireDay}'
                                              '/${Provider.of<InfoProvider>(context).expireMonth}'
                                              '/${Provider.of<InfoProvider>(context).expireYear}',
                                        ),

                                        MedicinePostText(
                                          title: 'Uses : ',
                                          value:Provider.of<InfoProvider>(context).uses,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Material(
                            elevation: 5.0,
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(15.0),
                            child: MaterialButton(
                              minWidth: 200.0,
                              height: 55.0,
                              hoverColor: Colors.transparent,
                              onPressed: () {},
                              child: Text(
                                'Apply',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  handleVerticalDrag(DragUpdateDetails dragUpdateDetails) {
    double fractionDragged = dragUpdateDetails.primaryDelta / screenHeight;
    _controller.value -= 5 * fractionDragged;
  }

  handelVerticalEnd(DragEndDetails dragEndDetails) {
    if (_controller.value >= .5)
      _controller.forward();
    else
      _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: MainDrawer(),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return getWidget();
        },
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
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
                fontSize: 22.0,
              ),
            ),
            Flexible(
              child: Text(
                value,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 22.0,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
      ],
    );
  }
}


class ProfilePageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.asset(
              Provider.of<InfoProvider>(context).medicineImage,
              fit: BoxFit.cover,
              colorBlendMode: BlendMode.hue,
              color: Colors.black,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(1.0),
                    Colors.white.withOpacity(0.2),
                    Colors.black.withOpacity(0.5),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 50.0,
          right: 20.0,
          left: 20.0,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TwoLineItem(
                firstText: '${Provider.of<InfoProvider>(context).medicineAmount}',
                secondText: 'Amount',
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
              TwoLineItem(
                firstText: '${Provider.of<InfoProvider>(context).medicineAppliers}',
                secondText: 'Appliers',
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
              TwoLineItem(
                firstText: '${Provider.of<InfoProvider>(context).acceptedPeople}',
                secondText: 'Accepted',
                crossAxisAlignment: CrossAxisAlignment.end,
              )
            ],
          ),
        ),
      ],
    );
  }
}

class TwoLineItem extends StatelessWidget {
  final String firstText,secondText;
  final CrossAxisAlignment crossAxisAlignment;

  TwoLineItem({this.firstText, this.secondText, this.crossAxisAlignment});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
            firstText,
            style: TextStyle(
                color:Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16
            )
        ),
        Text(
          secondText,
          style: TextStyle(
              color:Colors.grey.shade300,
              //fontWeight: FontWeight.w200,
              fontSize: 16
          ),
        ),
      ],
    );
  }
}