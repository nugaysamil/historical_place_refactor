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
import 'package:mapsuygulama/animations/animation_widget.dart';
import 'package:mapsuygulama/feature/google/description/description_widget.dart';
import 'package:mapsuygulama/product/data_provider/api_provider.dart';
import 'package:mapsuygulama/product/data_provider/auth_provider.dart';
import 'package:mapsuygulama/feature/side/side_menu_widget.dart';
import 'package:mapsuygulama/product/service/fetch_api.dart';
import 'package:mapsuygulama/product/helper/location_service.dart';
import 'package:mapsuygulama/product/utils/const/string_const.dart';
import 'package:rive/rive.dart';
import 'package:flutter_google_places/flutter_google_places.dart';

class CustomMarkerInfoWindow extends StatefulWidget {
  final Set<Marker> markers;
  final CustomInfoWindowController customInfoWindowController;

  const CustomMarkerInfoWindow(
      {super.key,
      required this.markers,
      required this.customInfoWindowController});

  @override
  State<CustomMarkerInfoWindow> createState() => _CustomMarkerInfoWindowState();
}

Set<Marker> markers = {};

CustomInfoWindowController customInfoWindowController =
    CustomInfoWindowController();

class _CustomMarkerInfoWindowState extends State<CustomMarkerInfoWindow>
    with SingleTickerProviderStateMixin {
  bool isSideMenuClosed = true;
  bool showSourceField = false;

  late GoogleMapController _mapController;
  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> scaleAnimation;

  TextEditingController _destinationController = TextEditingController();

  String mapTheme = '';
  double zoomVal = 5.0;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  void initState() {
    addCustomIcon();
    DefaultAssetBundle.of(context)
        .loadString(mapThemeAubergine)
        .then((value) => mapTheme = value);
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
    _animationController.dispose();
    _mapController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  BitmapDescriptor? markerIcon;

  Future<void> addCustomIcon() async {
    final icon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      starIcon,
    );
    setState(() {
      markerIcon = icon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final authState = ref.watch(authStateProvider);
      print('authState: $authState');

      final markerModel = ref.watch(singleUserDataProvider);

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
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(animation.value - 30 * animation.value * pi / 75),
              child: Transform.translate(
                offset: Offset(animation.value * 265, 0),
                child: Transform.scale(
                  scale: scaleAnimation.value,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                    child: Stack(
                      children: [
                        _googleMaps(),
                        markerModel.when(
                          data: (data) {
                            for (int j = 0; j < data.length; j++) {
                              markers.add(
                                Marker(
                                  markerId: MarkerId(data[j].id.toString()),
                                  position: LatLng(
                                      data[j].latitude, data[j].longitude),
                                  icon: markerIcon!,
                                  onTap: () async {
                                    var myData = await ApiService()
                                        .getRuins(data[0].slug);
                                    await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(top: 300),
                                          child: Dialog(
                                            backgroundColor: Colors.transparent,
                                            elevation: 8.0,
                                            insetPadding: EdgeInsets.all(16.0),
                                            child: Container(
                                              height: 350,
                                              child:
                                                  DraggableScrollableActuator(
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
                                                      data[j].name,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    SizedBox(height: 10),
                                                    AnimatedTextButton(
                                                      text: 'more_information'
                                                          .tr(),
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                DescriptionDetails(
                                                              markerList:
                                                                  data[j].name,
                                                              data: myData,
                                                              placeUrl:
                                                                  placeUrl,
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
                            return Center(
                              child: Text(''), // return will be change
                            );
                          },
                          error: (error, stackTrace) =>
                              Center(child: Text('Error: $error')),
                          loading: () =>
                              Center(child: CircularProgressIndicator()),
                        )
                      ],
                    ),
                  ),
                ),
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
                        if (isSideMenuClosed) _zoomplusFunction(),
                        SizedBox(height: 15),
                        if (isSideMenuClosed) _zoominusfunction(),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  Container _searchBar(AsyncValue<User?> authState) {
    return Container(
      width: authState.asData?.value != null ? 330 : 380,
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
          final _selectedPlace = await showGoogleAutoComplete();
          _destinationController.text = _selectedPlace.description!;
          goToPlace(_selectedPlace.placeId!);
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

  GoogleMap _googleMaps() {
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

  void goToPlace(String placeId) async {
    final places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
    final response = await places.getDetailsByPlaceId(placeId);

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

  Future<Prediction> showGoogleAutoComplete() async {
    Prediction? p = await PlacesAutocomplete.show(
      offset: 0,
      radius: 1000,
      strictbounds: false,
      region: "tr",
      language: "en",
      context: context,
      mode: Mode.overlay,
      apiKey: kGoogleApiKey,
      components: [Component(Component.country, "tr")],
      types: ["(cities)"],
      hint: "Search City",
    );
    return p!;
  }

  Widget _zoominusfunction() {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
        iconSize: 35,
        icon: Icon(
          Icons.zoom_out,
          color: Colors.white,
        ),
        onPressed: () {
          zoomVal--;

          _plus(zoomVal);
        },
      ),
    );
  }

  Widget _zoomplusFunction() {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
        iconSize: 35,
        icon: Icon(
          Icons.zoom_in,
          color: Colors.white,
        ),
        onPressed: () {
          signOut();
        },
      ),
    );
  }

  Future<void> _minus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(38.432, 27.1368), zoom: zoomVal),
      ),
    );
  }

  Future<void> _plus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(38.432, 27.1368), zoom: zoomVal),
      ),
    );
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
