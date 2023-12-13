// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

import 'package:mapsuygulama/animations/animation_widget.dart';
import 'package:mapsuygulama/feature/google/description/description_widget.dart';
import 'package:mapsuygulama/product/data_provider/api_provider.dart';
import 'package:mapsuygulama/product/data_provider/auth_provider.dart';
import 'package:mapsuygulama/product/helper/location_service.dart';
import 'package:mapsuygulama/product/models/api_model.dart';
import 'package:mapsuygulama/product/service/fetch_api.dart';
import 'package:mapsuygulama/product/service/google_places_service.dart';
import 'package:mapsuygulama/product/utils/const/string_const.dart';
import 'package:mapsuygulama/product/utils/map_utility.dart';
import 'package:mapsuygulama/product/utils/zoom_in_function.dart';
import 'package:mapsuygulama/product/utils/zoom_utility.dart';

class GoogleMapsWidget extends ConsumerStatefulWidget {
  const GoogleMapsWidget({
    Key? key,
  });

  @override
  _GoogleConsumerWidgetState createState() => _GoogleConsumerWidgetState();
}

class _GoogleConsumerWidgetState extends ConsumerState<GoogleMapsWidget> {
  String mapTheme = '';
  double zoomVal = 5.0;
  bool showSourceField = false;

  TextEditingController _destinationController = TextEditingController();
  late GoogleMapController _mapController;
  bool isSideMenuClosed = true;

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
    _destinationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    //print(authState);
    final markerModel = ref.watch(singleUserDataProvider);
    List<MarkerModel> markers = [];

    Marker markerModelToMarker(MarkerModel markerModel) {
      return Marker(
        markerId: MarkerId(markerModel.id.toString()),
        position: LatLng(markerModel.latitude, markerModel.longitude),
        onTap: () async {
          var myData = await ApiService().getRuins(markerModel.slug);

          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.only(top: 300),
                child: Dialog(
                  backgroundColor: Colors.transparent,
                  elevation: 8.0,
                  insetPadding: EdgeInsets.all(16.0),
                  child: Container(
                    height: 350,
                    child: DraggableScrollableActuator(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 200,
                            width: 200,
                            child: myData['image'] != null &&
                                    myData['image'].toString().isNotEmpty
                                ? Image.network(
                                    placeUrl + myData['image'].toString())
                                : myData['error'] != null
                                    ? Text('Hata: ${myData['error']}')
                                    : Container(),
                          ),


                          SizedBox(height: 15),
                          Text(
                            markerModel.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: 10),
                          AnimatedTextButton(
                            text: 'more_information'.tr(),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DescriptionDetails(
                                    markerList: markerModel.name,
                                    data: myData,
                                    placeUrl: placeUrl,
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      );
    }

    double calculateVerticalShift(BuildContext context, double percentage) {
      return MediaQuery.of(context).size.height * percentage;
    }
    double screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        markerModel.when(
          data: (data) {
            markers =
                data.map((json) => MarkerModel.fromMap(json.toMap())).toList();

            Set<Marker> markerSet = markers.map(markerModelToMarker).toSet();
            print(markers.length);

            return GoogleMap(
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              onMapCreated: (controller) async {
                setState(() {});

                controller.setMapStyle(mapTheme);
                _mapController = controller;
                _controller.complete(controller);

                try {
                  final currentPosition =
                      await LocationService.getCurrentLocation();
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
              markers: markerSet,
              initialCameraPosition: const CameraPosition(
                target: LatLng(38.9573415, 35.240741),
                zoom: 5,
              ),
            );
          },
          error: (error, stackTrace) {
            print('Error: $error');
            print('StackTrace: $stackTrace');

            return Center(child: Text('Error: $error'));
          },
          loading: () {
            print('Loading...');

            return Center(child: CircularProgressIndicator());
          },
        ),
        
        SafeArea(
          child: Row(
            mainAxisAlignment: authState.asData?.value == null
                ? MainAxisAlignment.center
                : MainAxisAlignment.end,
            children: [
              if (isSideMenuClosed)
                Container(
                  width: authState.asData?.value != null ? 325 : 350,
                  height: 50,
                  margin: EdgeInsets.only(
                      top: calculateVerticalShift(context, 0.01)),
                  padding: EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        spreadRadius: 4,
                        blurRadius: 10,
                      )
                    ],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextFormField(
                    controller: _destinationController,
                    readOnly: true,
                    onTap: () async {
                      final _selectedPlace = await GooglePlacesService()
                          .showGoogleAutoComplete(context);
                      _destinationController.text = _selectedPlace.description!;
                      final mapUtility = MapUtility(
                          GoogleMapsPlaces(apiKey: kGoogleApiKey),
                          _mapController);
                      mapUtility.goToPlace(_selectedPlace.placeId!);
          
                      setState(() {
                        showSourceField = true;
                      });
                    },
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: 'destination'.tr(),
                      hintStyle: GoogleFonts.poppins(fontSize: 16),
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
            ],
          ),
        ),
        
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isSideMenuClosed)
              ZoomInButton(
                icon: Icons.zoom_in,
                onPressed: () {
                  final zoomUtility = ZoomUtility(_controller);

                  zoomVal++;
                  zoomUtility.zoom(zoomVal);
                },
              ),
            SizedBox(height: 15),
            if (isSideMenuClosed)
              ZoomInButton(
                icon: Icons.zoom_out,
                onPressed: () {
                  final zoomUtility = ZoomUtility(_controller);

                  zoomVal--;
                  zoomUtility.zoom(zoomVal);
                },
              ),
          ],
        ),
      ],
    );
  }
}
