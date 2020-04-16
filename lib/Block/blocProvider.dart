import 'dart:async';
import 'package:flutter/material.dart';
import 'Block.dart';
class blocProvider extends InheritedWidget{
  final  bloc = Bloc();

  blocProvider({Key key , Widget child}):super(key :key , child :child);

  bool updateShouldNotify(_)=> true;

  static Bloc of(context){
    return (context.inheritFromWidgetOfExactType(blocProvider) as blocProvider).bloc;
  }
}