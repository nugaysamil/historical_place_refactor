// ignore_for_file: deprecated_member_use

import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationService {
  static Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw PlatformException(
        code: 'LOCATION_SERVICES_DISABLED',
        message: 'Location services are disabled.',
      );
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        throw PlatformException(
          code: 'LOCATION_PERMISSION_DENIED_FOREVER',
          message:
              'Location permissions are denied forever, we cannot request permissions.',
        );
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw PlatformException(
        code: 'LOCATION_PERMISSION_DENIED_FOREVER',
        message:
            'Location permissions are denied forever, we cannot request permissions.',
      );
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> openMap(String latitude, String longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw PlatformException(
        code: 'MAP_OPEN_ERROR',
        message: 'Could not open the map. $googleUrl',
      );
    }
  }
}
