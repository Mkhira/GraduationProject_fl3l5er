import 'package:company_task/Screens/Maps/user_location.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class MapProvider extends ChangeNotifier{


   getCurrentLocation() async{
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