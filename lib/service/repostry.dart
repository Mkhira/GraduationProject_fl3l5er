import '../models/eventModel.dart';
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