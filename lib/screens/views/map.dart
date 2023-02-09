import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class GMap extends StatefulWidget {
  const GMap({Key? key}) : super(key: key);

  @override
  State<GMap> createState() => _MapState();
}

class _MapState extends State<GMap> {
  double lat = 0.0;
  double long = 0.0;

  Completer<GoogleMapController> mapcontroler = Completer();

  void onMapCreated(GoogleMapController controller) {
    mapcontroler.complete(controller);
  }

  MapType currentMap = MapType.normal;
  late CameraPosition pos;

  Live() async {
    Geolocator.getPositionStream().listen((Position position) {
      setState(() {
        lat = position.latitude;
        long = position.longitude;
        pos = CameraPosition(
          target: LatLng(lat, long),
        );
      });
    });
  }

  @override
  void initState() {
    super.initState();
    Permission.location.request();
    Live();
    pos = CameraPosition(target: LatLng(lat, long));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> location =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(CupertinoIcons.back),
        ),
        title: Text("${location['name']}"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _onMapTypeButtonPressed,
            icon: const Icon(CupertinoIcons.map),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        autofocus: false,
        onPressed: () async {
          Live();
          setState(() {
            pos = CameraPosition(
              target: LatLng(location['lat'], location['long']),
            );
          });
          final GoogleMapController controller = await mapcontroler.future;
          controller.animateCamera(
            CameraUpdate.newCameraPosition(pos),
          );
        },
        label: const Text("Location"),
        icon: const Icon(CupertinoIcons.globe),
      ),
      body: Column(
        children: [
          Expanded(
              flex: 35,
              child: GoogleMap(
                onMapCreated: (GoogleMapController controller) {
                  mapcontroler.complete(controller);
                },
                initialCameraPosition: pos,
                mapType: currentMap,
                zoomControlsEnabled: false,
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
              )),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.red),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text("${location['lat']}, ${location['long']},"),
              ),
            ),
          )),
        ],
      ),
    );
  }

  void _onMapTypeButtonPressed() {
    setState(() {
      currentMap =
          currentMap == MapType.normal ? MapType.satellite : MapType.hybrid;
    });
  }
}
