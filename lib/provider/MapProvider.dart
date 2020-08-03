import 'package:company_task/Screens/Maps/user_location.dart';
import 'package:company_task/provider/AddPostClothProvider.dart';
import 'package:company_task/provider/AddPostMedicineProvider.dart';
import 'package:company_task/provider/AddPostfurnitureProvider.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class MapProvider extends ChangeNotifier{


   getCurrentLocation(BuildContext context) async{
     //get current position using geolocator package
     Position position = await Geolocator()
         .getCurrentPosition(
         desiredAccuracy: LocationAccuracy.high);

     //get the address from the coordinates
     List<Placemark> placemark = await Geolocator()
         .placemarkFromCoordinates(
         position.latitude, position.longitude);

     Placemark place = placemark[0];
     String administrativeArea =
         place.subAdministrativeArea;
     String locality = place.locality;

     print('$administrativeArea  $locality');
     print(
         '${position.latitude}  ${position.longitude}');
     Provider.of<AddPostMedicineProvider>(context).chosenLong =position.longitude;
     Provider.of<AddPostMedicineProvider>(context).chosenLat =position.latitude;
     Provider.of<AddPostClothProvider>(context).chosenLong =position.longitude;
     Provider.of<AddPostClothProvider>(context).chosenLat =position.latitude;
     Provider.of<AddPostFurnitureProvider>(context).chosenLong =position.longitude;
     Provider.of<AddPostFurnitureProvider>(context).chosenLat =position.latitude;
     notifyListeners();
   }

   getAnotherLocation(BuildContext context) async{
     //get current position using geolocator package
     Position position = await Geolocator()
         .getCurrentPosition(
         desiredAccuracy: LocationAccuracy.high);

     //get the address from the coordinates
     List<Placemark> placemark = await Geolocator()
         .placemarkFromCoordinates(
         position.latitude, position.longitude);

     Placemark place = placemark[0];
     String administrativeArea =
         place.subAdministrativeArea;
     String locality = place.locality;
     Navigator.push(
       context,
       MaterialPageRoute(
         builder: (context) {
           return UserLocation(
             latitude: position.latitude,
             longitude: position.longitude,
             locality: administrativeArea,
           );
         },
       ),
     );
   }



}