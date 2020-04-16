import 'dart:async';

import 'package:company_task/Screens/homePage.dart';
import 'package:company_task/provider/taskData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
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
    return ChangeNotifierProvider(
      create: (context) => TaskData(),
      child: MaterialApp(
          home:HomePage()
      ),
    );  }
}


