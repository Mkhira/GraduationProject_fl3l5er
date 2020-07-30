import 'dart:async';

import 'package:company_task/provider/AddPostClothProvider.dart';
import 'package:company_task/provider/AddPostMedicineProvider.dart';
import 'package:company_task/provider/AddPostfurnitureProvider.dart';
import 'package:company_task/provider/MapProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class UserLocation extends StatefulWidget {
  double latitude, longitude;
  String locality;
  static const String id = "UserLocation";

  UserLocation({this.longitude, this.latitude, this.locality});

  @override
  _UserLocationState createState() => _UserLocationState();
}

class _UserLocationState extends State<UserLocation> {
  Completer<GoogleMapController> mapController = Completer();

  //double currentLatitude , currentLongitude ;
  Set<Marker> markers = {};
  Set<Marker> clickMark = {};

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Your Current Location'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('${widget.locality}.',style: TextStyle(color: Colors.red),),
                Text('Would you like to approve this Location?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
//
  Future<void> _goToLocation() async {
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(widget.latitude, widget.longitude),
        zoom: 11.0,
      ),

    ));
    Provider.of<AddPostMedicineProvider>(context).chosenLat = widget.latitude;
    Provider.of<AddPostMedicineProvider>(context).chosenLong = widget.longitude;
    Provider.of<AddPostClothProvider>(context).chosenLat = widget.latitude;
    Provider.of<AddPostClothProvider>(context).chosenLong = widget.longitude;
    Provider.of<AddPostFurnitureProvider>(context).chosenLat = widget.latitude;
    Provider.of<AddPostFurnitureProvider>(context).chosenLong = widget.longitude;
    Future.delayed(

      Duration(
        seconds: 4,
      ),
      () {
        _showMyDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green[700],
        title: Text('Google Maps'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onTap: (latlang){
                  setState(() {
                    Provider.of<AddPostMedicineProvider>(context).chosenLat = latlang.latitude;
                    Provider.of<AddPostMedicineProvider>(context).chosenLong = latlang.longitude;
                    Provider.of<AddPostClothProvider>(context).chosenLat = latlang.latitude;
                    Provider.of<AddPostClothProvider>(context).chosenLong = latlang.longitude;
                    Provider.of<AddPostFurnitureProvider>(context).chosenLat = latlang.latitude;
                    Provider.of<AddPostFurnitureProvider>(context).chosenLong = latlang.longitude;

                  });
            },
            onMapCreated: (GoogleMapController controller) {
              mapController.complete(controller);
              setState(() {
                markers.add(Marker(
                  position: LatLng(widget.latitude, widget.longitude),
                  icon: BitmapDescriptor.defaultMarker,
                  markerId: MarkerId("idMarker"),
                ));
              });
            },
            markers: markers,
            initialCameraPosition: CameraPosition(
              //initial position at cairo.
              target: LatLng(30.033333, 31.233334),
              zoom: 15.0,
            ),
          ),
          Positioned(
            bottom: 30.0,
            left: 8.0,
            child: FloatingActionButton(
              child: Icon(Icons.location_on),
              onPressed: _goToLocation,
            ),
          )
        ],
      ),
    );
  }
}
