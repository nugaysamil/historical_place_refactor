import 'dart:async';
import 'dart:math';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:mapsuygulama/feature/google/marker_list_widget.dart';
import 'package:mapsuygulama/product/models/api_model.dart';
import 'package:mapsuygulama/product/utils/zoom_in_function.dart';
import 'package:mapsuygulama/product/data_provider/auth_provider.dart';
import 'package:mapsuygulama/feature/side/side_menu_widget.dart';
import 'package:mapsuygulama/product/service/google_places_service.dart';
import 'package:mapsuygulama/product/utils/const/string_const.dart';
import 'package:mapsuygulama/product/utils/map_utility.dart';
import 'package:mapsuygulama/product/utils/zoom_utility.dart';
import 'package:rive/rive.dart';

class CustomMarkerInfoWindow extends ConsumerStatefulWidget {
  final Set<Marker> markers;
  final CustomInfoWindowController customInfoWindowController;

  const CustomMarkerInfoWindow(
      {super.key,
      required this.markers,
      required this.customInfoWindowController});

  @override
  _CustomConsumerWidgetState createState() => _CustomConsumerWidgetState();
}
late List<MarkerModel> markerModelData;

CustomInfoWindowController customInfoWindowController =
    CustomInfoWindowController();

class _CustomConsumerWidgetState extends ConsumerState<CustomMarkerInfoWindow>
    with SingleTickerProviderStateMixin {
  bool isSideMenuClosed = true;
  bool showSourceField = false;
   Completer<GoogleMapController>? _controller;
  late GoogleMapController _mapController;
  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> scaleAnimation;

  TextEditingController _destinationController = TextEditingController();

  double zoomVal = 5.0;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    )..addListener(() {
        setState(() {});
      });
    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));

    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  void dispose() {
    _mapController.dispose();
    _animationController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF17203A),
      extendBody: true,
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            width: 288,
            left: isSideMenuClosed ? -288 : 0,
            height: MediaQuery.of(context).size.height,
            child: SideMenu(),
          ),
          Transform.translate(
            offset: Offset(animation.value * 265, 0),
            child: Transform.scale(
              scale: scaleAnimation.value,
              child: GoogleMapsWidget(),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 200),
            top: 16,
            left: isSideMenuClosed ? 0 : 230,
            curve: Curves.fastOutSlowIn,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: authState.asData?.value != null,
                            child: buttonWidget(),
                          ),
                          SizedBox(width: 15),
                          if (isSideMenuClosed) _searchBar(authState)
                        ],
                      ),
                      SizedBox(height: 15),
                      if (isSideMenuClosed)
                        ZoomInButton(
                          onPressed: () {
                            final zoomUtility = ZoomUtility(_controller!);

                            zoomVal++;
                            zoomUtility.zoom(zoomVal);
                          },
                        ),
                      SizedBox(height: 15),
                      if (isSideMenuClosed)
                        ZoomInButton(
                          onPressed: () {
                            final zoomUtility = ZoomUtility(_controller!);

                            zoomVal--;
                            zoomUtility.zoom(zoomVal);
                          },
                        ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container _searchBar(AsyncValue<User?> authState) {
    return Container(
      width: authState.asData?.value != null ? 300 : 350,
      height: 50,
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
          final _selectedPlace =
              await GooglePlacesService().showGoogleAutoComplete(context);
          _destinationController.text = _selectedPlace.description!;
          final mapUtility = MapUtility(
              GoogleMapsPlaces(apiKey: kGoogleApiKey), _mapController);
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
          hintText: 'Search for a destination',
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
    );
  }

  FloatingActionButton buttonWidget() {
    return FloatingActionButton(
      backgroundColor: Colors.white,
      onPressed: () {
        if (isSideMenuClosed) {
          _animationController.forward();
        } else {
          _animationController.reverse();
        }
        setState(() {
          isSideMenuClosed = !isSideMenuClosed;
        });
      },
      child: SizedBox(
        width: 20,
        height: 20,
        child: RiveAnimation.asset(
          'assets/RiveAssets/icons2.riv',
          artboard: 'New Artboard',
          onInit: (riveOnInit) {},
        ),
      ),
    );
  }
}




/* 
          markerModel.when(
                    data: (data) {
                      markerModelData = data;

                      for (int j = 0; j < markerModelData.length; j++) {
                        print('markerListtttttttttt: $markerModelData');

                        markers.add(
                          Marker(
                            markerId:
                                MarkerId(markerModelData[j].id.toString()),
                            position: LatLng(
                              markerModelData[j].latitude,
                              markerModelData[j].longitude,
                            ),
                            icon: BitmapDescriptor.defaultMarkerWithHue(
                                BitmapDescriptor.hueBlue),
                            onTap: () async {
                              print('markersss' + markers.toString());

                              var myData = await ApiService()
                                  .getRuins(markerModelData[j].slug);

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
                                                child: Image.network(
                                                  placeUrl +
                                                      myData['image']
                                                          .toString(),
                                                ),
                                              ),
                                              SizedBox(height: 15),
                                              Text(
                                                markerModelData[j].name,
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
                                                      builder: (context) =>
                                                          DescriptionDetails(
                                                        markerList:
                                                            markerModelData[j]
                                                                .name,
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
                          ),
                        );
                      }

                      return Text('aa');
                    },
                    error: (error, stackTrace) =>
                        Center(child: Text('Error: $error')),
                    loading: () => Center(child: CircularProgressIndicator()),
                  )),  */