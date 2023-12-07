import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

class MapUtility {
  final GoogleMapsPlaces _places;
  final GoogleMapController _mapController;

  MapUtility(this._places, this._mapController);

  Future<void> goToPlace(String placeId) async {
    final response = await _places.getDetailsByPlaceId(placeId);

    if (response.status == "OK") {
      final result = response.result;
      final location = result.geometry?.location;
      if (location != null) {
        _mapController.animateCamera(CameraUpdate.newLatLngZoom(
          LatLng(location.lat, location.lng),
          15,
        ));
      }
    }
  }
}
