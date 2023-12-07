import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class ZoomUtility {
  final Completer<GoogleMapController> _controller;

  ZoomUtility(this._controller);

  Future<void> zoom(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(38.432, 27.1368), zoom: zoomVal),
      ),
    );
  }
}
