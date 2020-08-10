import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_task/Block/Block.dart';
import 'package:company_task/Screens/ChatScreen.dart';
import 'package:company_task/Screens/ClothesPost.dart';
import 'package:company_task/Screens/FurintureScreen.dart';
import 'package:company_task/Screens/HomePageContentScreen.dart';
import 'package:company_task/Screens/Notification.dart';
import 'package:company_task/Screens/profile_screen.dart';
import 'package:company_task/Utli/Common.dart';
import 'package:company_task/models/eventModel.dart';
import 'package:company_task/provider/info_provider.dart';
import 'package:company_task/wedgit/main_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import '../wedgit/caruselWedgit.dart';
import '../style/constent.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import '../models/topDonatersmodel.dart';
import '../models/charityModel.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'MedicinePosts.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Bloc _bloc;
  PageController _pageController;
  List<Widget> _widgetOptions = <Widget>[
    MainHomePage(),
    ChatScreenPage(),
    NotificationScreen(),
  ];
 @override
  void initState()  {
    // TODO: implement initState


   Bloc();
   _bloc = Bloc();
   _bloc.fetchEvent();
   _bloc.fetchTopDonators();
   _bloc.fetchcharity();
   _bloc.fetchcharity();
   _pageController = PageController();

   super.initState();



  }

  @override
  void dispose() {
    super.dispose();

    _bloc.dispose();
    _pageController.dispose();

  }
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var x = (MediaQuery.of(context).orientation == Orientation.portrait);
    var profileProvider = Provider.of<InfoProvider>(context);

    return SafeArea(
        child: Scaffold(

            bottomNavigationBar: BottomNavyBar(

              selectedIndex: _currentIndex,
              onItemSelected: (index) {
                setState(() => _currentIndex = index);
//                _pageController.jumpToPage(index);
              },
              items: <BottomNavyBarItem>[
                BottomNavyBarItem(
                    title: Text('الرئيسيه',style: kNavigationBar),
                    icon: Icon(Icons.home,textDirection: TextDirection.rtl,size: 30,),
                  activeColor: kSecondColor,
                   inactiveColor: Colors.grey,
                  textAlign: TextAlign.right
                ),
                BottomNavyBarItem(
                    title: Text('الرسائل',style: kNavigationBar,),
                    icon: Icon(Icons.message,size: 30,),
                    activeColor: kSecondColor,
                    inactiveColor: Colors.grey,
                    textAlign: TextAlign.right
                ),
                BottomNavyBarItem(
                    title: Text('الأشعارات'),
                    icon: Icon(Icons.notifications_active,size: 30,),

                    activeColor: kSecondColor,
                    inactiveColor: Colors.grey,
                    textAlign: TextAlign.right

                ),

              ],
            ),
            drawer: MainDrawer(),
            backgroundColor: Color(0xffe6e6ea),
            body:             _widgetOptions.elementAt(_currentIndex)

        ));
  }
}



