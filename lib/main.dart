import 'dart:async';

import 'package:company_task/Screens/AdingMedicienPost.dart';
import 'package:company_task/Screens/FurintureScreen.dart';
import 'package:company_task/Screens/LoginScreen/LoginMainScreen.dart';
import 'package:company_task/Screens/Maps/StaticMap.dart';
import 'package:company_task/Screens/Maps/user_location.dart';
import 'package:company_task/Screens/edit_screen.dart';
import 'package:company_task/Screens/homePage.dart';
import 'package:company_task/Screens/ClothesPost.dart';
import 'package:company_task/Screens/profile_screen.dart';
import 'package:company_task/Screens/profile_image_screen.dart';
import 'package:company_task/provider/AddPostClothProvider.dart';
import 'package:company_task/provider/AddPostMedicineProvider.dart';
import 'package:company_task/provider/AddPostfurnitureProvider.dart';
import 'file:///E:/flater_projects/company_task/lib/provider/SignUpLoginProvider/FireBaseAuth.dart';
import 'package:company_task/provider/MapProvider.dart';
import 'package:company_task/provider/SignUpLoginProvider/LoginProvider.dart';
import 'package:company_task/provider/SignUpLoginProvider/SignUpProvider.dart';
import 'package:company_task/provider/info_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'Screens/MedicinePosts.dart';
import 'Screens/splashScreen.dart';
import 'Screens/homePage.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return   MultiProvider(
        providers: [

        ChangeNotifierProvider(
        create: (context)=>InfoProvider(),

    ),  ChangeNotifierProvider(
        create: (context)=>AddPostMedicineProvider(),

    ),  ChangeNotifierProvider(
    create: (context)=>MapProvider(),

    ),
          ChangeNotifierProvider(
            create: (context)=>AddPostClothProvider(),

          ),
          ChangeNotifierProvider(
            create: (context)=>AddPostFurnitureProvider(),

          ),
          ChangeNotifierProvider(
            create: (context)=>AuthNotifier(),

          ),
          ChangeNotifierProvider(
            create: (context)=>SignUpProvider(),

          ),
          ChangeNotifierProvider(
            create: (context)=>LoginProvider(),

          ),
        ],
      child: MaterialApp(
        builder: (context, child){
          //to remove scroll glow
          return ScrollConfiguration(
            behavior: ScrollBehavior()..buildViewportChrome(context, child, AxisDirection.down),
            child: child,
          );
        },
        debugShowCheckedModeBanner: false,
        home:Consumer<AuthNotifier>(builder: (context ,notifire ,child){
          return notifire.user != null ? SplashScreen() : LoginMainScreen();
        },),
        routes: {
          HomePage.id: (context) => HomePage(),
          LoginMainScreen.id: (context) => LoginMainScreen(),
          MedicinePosts.id: (context) => MedicinePosts(),
          ProfileScreen.id:(context)=>ProfileScreen(),
          EditScreen.id:(context)=>EditScreen(),
          ProfileImageScreen.id:(context)=>ProfileImageScreen(),
          ClothesPost.id:(context)=>ClothesPost(),
          AddMedicinePostDataScreen.id:(context)=>AddMedicinePostDataScreen(),
          FurnitureScreen.id:(context)=>FurnitureScreen(),
          GoogleMaps.id:(context)=>GoogleMaps(),
          UserLocation.id:(context)=>UserLocation(),
        },
      ),
    );
  }
}
