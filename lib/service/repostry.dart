import 'package:company_task/models/BloodNeedyModel.dart';
import 'package:company_task/models/ChatModel.dart';
import 'package:company_task/models/ClothesModel.dart';
import 'package:company_task/models/FurintureModel.dart';
import 'package:company_task/models/User.dart';
import 'package:company_task/service/ChatService.dart';
import 'package:company_task/service/ClothService.dart';
import 'package:company_task/service/GetUser.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import '../models/eventModel.dart';
import 'BloodNeedyService.dart';
import 'FurnitureService.dart';
import 'eventSirves.dart';
import '../models/topDonatersmodel.dart';
import 'topDontorsService.dart';
import 'cahrityService.dart';
import '../models/charityModel.dart';
import '../models/medicenModel.dart';
import 'MedicineService.dart';
class eventRepostry{
  final _eventService = eventService();
         Future<List<EventModel>> getevent() => _eventService.getevent();

}




class TopDonatorsRepostry{
  final _topDonatorsService = TopDonatorsService();
  Future<List<TopDonatorsModel>> getTopdDonators() => _topDonatorsService.getTopdDonators();

}
class charityRepostry{
  final _charityService = charityService();
  Future<List<charityModel>> getcharity() => _charityService.getcharity();

}



class MedicineRepostry{
  final _medicineService = MedicineService();
  Future<List<MedicineModel>> getMedicine() => _medicineService.getMedicine();

}




class MedicineRepostrySearch{
  final _medicineServiceSearch = MedicineServiceSearch();
  Future<List<MedicineModel>> getMedicineSearch(String query) => _medicineServiceSearch.getMedicineSearch(query);

}

class MedicineRepostryFinish{
  final _medicineService = MedicineServiceFinish();
  Future<List<MedicineModel>> getMedicineFinish() => _medicineService.getMedicineFinish();

}



class MedicineRepostoryProfile{
  final _medicineService = MedicineProfile();
  Future<List<MedicineModel>> getMedicineProfile(BuildContext context) => _medicineService.getMedicineProfile(context);

}
////////////////////////////// Cloth start /////////////////
class ClothRepostry{
  final _clothService = ClothService();
  Future<List<ClothModel>> getCloth() => _clothService.getCloth();

}




class ClothRepostrySearch{
  final _clothServiceSearch = ClothServiceSearch();
  Future<List<ClothModel>> getClothSearch(String query) => _clothServiceSearch.getClothSearch(query);

}



class ClothRepostryFinish{
  final _clothService = ClothServicefinsh();
  Future<List<ClothModel>> getCloth() => _clothService.getClothFinish();

}


class ClothRepostoryProfile{
  final _clothService = ClothProfile();
  Future<List<ClothModel>> getClothProfile(BuildContext context) => _clothService.getClothProfile(context);

}

/////////////////////////// Cloth Finish ///////////////////
////////////////////////// Furniture start ///////////

class FurnitureRepostry{
  final _furnitureService = FurnitureService();
  Future<List<FurnitureModel>> getFurniture() => _furnitureService.getFurniture();

}




class FurnitureRepostrySearch{
  final _furnitureServiceSearch = FurnitureServiceSearch();
  Future<List<FurnitureModel>> getFurnitureSearch(String query) => _furnitureServiceSearch.getFurnitureSearch(query);

}



class FurnitureRepostryFinish{
  final _furnitureService = FurnitureServiceFinish();
  Future<List<FurnitureModel>> getFurnitureFinish() => _furnitureService.getFurnitureFinish();

}




class FurnitureRepostoryProfile{
  final _furnitureService = FurnitureProfile();
  Future<List<FurnitureModel>> getFurnitureProfile(BuildContext context) => _furnitureService.getFurnitureProfile(context);

}

//////////////////////////////////////
class BloodRepostry{
  final _bloodService = BloodNeedyService();
  Future<List<BloodNeedyModel>> getNeedy() => _bloodService.getNeedy();

}





class UserRopestryLogin{
  final _userService = UserServiceLogin();
  Future<List<User>> getUserData( BuildContext context) => _userService.getUserData( context);

}


///////////////////////////////// chat /////////




class chatRommRepostry{
  final _chatService = chatServices();
  Future<List<ChatModel>> getChatRoom(BuildContext context) => _chatService.getChatRoom(context);

}