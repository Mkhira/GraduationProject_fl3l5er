
import 'package:company_task/Block/Block.dart';

import 'package:company_task/Screens/HomePageContentScreen.dart';

import 'package:company_task/wedgit/main_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  static const String id = 'home_page';
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  Bloc _bloc;
//  PageController _pageController;
//  List<Widget> _widgetOptions = <Widget>[
//    MainHomePage(),
//    ChatScreenPage(),
//    NotificationScreen(),
//  ];
 @override
  void initState()  {
   Bloc();
   _bloc = Bloc();
   _bloc.fetchEvent();
   _bloc.fetchTopDonators();
   _bloc.fetchcharity();
   _bloc.fetchcharity();
//   _pageController = PageController();
   super.initState();
  }
  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
//    _pageController.dispose();
  }
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
//            bottomNavigationBar: BottomNavyBar(
//              selectedIndex: _currentIndex,
//              onItemSelected: (index) {
//                setState(() => _currentIndex = index);
//              }, items: <BottomNavyBarItem>[
//                BottomNavyBarItem(
//                    title: Text('الرئيسيه',style: kNavigationBar),
//                    icon: Icon(Icons.home,textDirection: TextDirection.rtl,size: 30,),
//                  activeColor: kSecondColor,
//                   inactiveColor: Colors.grey,
//                  textAlign: TextAlign.right
//                ), BottomNavyBarItem(
//                    title: Text('الرسائل',style: kNavigationBar,),
//                    icon: Icon(Icons.message,size: 30,),
//                    activeColor: kSecondColor,
//                    inactiveColor: Colors.grey,
//                    textAlign: TextAlign.right
//                ), BottomNavyBarItem(
//                    title: Text('الأشعارات'),
//                    icon: Icon(Icons.notifications_active,size: 30,),
//
//                    activeColor: kSecondColor,
//                    inactiveColor: Colors.grey,
//                    textAlign: TextAlign.right
//
//                ),
//              ],
//            ),
            endDrawer: MainDrawer(),
            backgroundColor: Color(0xffe6e6ea),
            body:   MainHomePage(),),);}
}



