import 'dart:async';

import 'package:company_task/Screens/AdingMedicienPost.dart';
import 'package:company_task/Screens/FurintureScreen.dart';
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
import 'package:company_task/provider/MapProvider.dart';
import 'package:company_task/provider/info_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'Screens/MedicinePosts.dart';
import 'Screens/splashScreen.dart';
import 'Screens/Login.dart';
import 'Screens/secondRigister.dart';
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

        ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        //home:HomePage(),
        initialRoute: HomePage.id,
        routes: {
          HomePage.id: (context) => HomePage(),
          MedicinePosts.id: (context) => MedicinePosts(),
          ProfileScreen.id:(context)=>ProfileScreen(),
          EditScreen.id:(context)=>EditScreen(),
          ProfileImageScreen.id:(context)=>ProfileImageScreen(),
          ClothesPost.id:(context)=>ClothesPost(),
          AddMedicinePostDataScreen.id:(context)=>AddMedicinePostDataScreen(),
          FurnitureScreen.id:(context)=>FurnitureScreen(),
          GoogleMaps.id:(context)=>GoogleMaps(),
          UserLocation.id:(context)=>UserLocation(),
          secondRegister.id:(context)=>secondRegister(),
        },
      ),
    );
  }
}
