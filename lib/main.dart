import 'dart:async';

import 'package:company_task/Screens/AdingMedicienPost.dart';
import 'package:company_task/Screens/edit_screen.dart';
import 'package:company_task/Screens/homePage.dart';
import 'package:company_task/Screens/ClothesPost.dart';
import 'package:company_task/Screens/profile_screen.dart';
import 'package:company_task/Screens/profile_image_screen.dart';
import 'package:company_task/provider/AddPostProvider.dart';
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
        create: (context)=>AddPostProvider(),

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
        },
      ),
    );
  }
}
