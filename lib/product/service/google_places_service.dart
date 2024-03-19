import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:mapsuygulama/product/utils/const/string_const.dart';
import 'package:flutter_google_places/src/flutter_google_places.dart';


class GooglePlacesService {
  Future<Prediction> showGoogleAutoComplete(BuildContext context) async {
    Prediction? p = await PlacesAutocomplete.show(
      offset: 0,
      radius: 1000,
      strictbounds: false,
      region: "tr",
      language: "en",
      context: context,
      mode: Mode.overlay,
      apiKey: StringConstants.kGoogleApiKey,
      components: [Component(Component.country, "tr")],
      types: ["(cities)"],
      hint: "Search City",
    );
    return p!;
  }
}
