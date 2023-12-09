import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapsuygulama/product/helper/location_service.dart';
import 'package:mapsuygulama/product/utils/const/string_const.dart';

class GoogleMapsWidget extends StatefulWidget {
  const GoogleMapsWidget({super.key});

  @override
  State<GoogleMapsWidget> createState() => _GoogleMapsWidgetState();
}

class _GoogleMapsWidgetState extends State<GoogleMapsWidget> {
  String mapTheme = '';

  late GoogleMapController _mapController;
  Set<Marker> markers = {};

  @override
  void initState() {
    DefaultAssetBundle.of(context)
        .loadString(mapThemeAubergine)
        .then((value) => mapTheme = value);
    super.initState();
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      onMapCreated: (controller) async {
        setState(() {});
        controller.setMapStyle(mapTheme);
        _mapController = controller;
        _controller.complete(controller);
        try {
          final currentPosition = await LocationService.getCurrentLocation();
          controller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(
                  currentPosition.latitude,
                  currentPosition.longitude,
                ),
                zoom: 15,
              ),
            ),
          );
        } catch (e) {
          print('Error getting current location: $e');
        }
      },
      markers: markers,
      initialCameraPosition: const CameraPosition(
        target: LatLng(38.9573415, 35.240741),
        zoom: 5,
      ),
    );
  }
}
