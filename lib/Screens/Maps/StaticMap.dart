


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMaps extends StatefulWidget {
  static const String id = "GoogleMaps";
  GoogleMaps({this.lat,this.lan});
  final double lat;
  final double lan;

  @override
  _GoogleMapsState createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  GoogleMapController mapController;

  //todo add longitude and latitude from user information at database.

  Set<Marker> markers={};

  void _onMapCreated(GoogleMapController controller){
    setState(() {
      mapController=controller;
      markers.add(
          Marker(
            position: LatLng(widget.lat,widget.lan),
            icon:BitmapDescriptor.defaultMarker,
            markerId: MarkerId("idMarker"),
          )
      );
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green[700],
        title: Text("Google Maps"),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            markers: markers,
            initialCameraPosition: CameraPosition(
              target: LatLng(widget.lat,widget.lan),
              zoom: 11.0,
            ),
          ),
        ],
      ),
    );
  }
}
