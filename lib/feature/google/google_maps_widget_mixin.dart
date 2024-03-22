// ignore_for_file: unused_element

part of 'google_maps_widget.dart';

mixin GoogleMapsWidgetMixin on State<GoogleMapsWidget> {
  String mapTheme = '';
  double zoomVal = 5.0;
  bool showSourceField = false;

  TextEditingController _destinationController = TextEditingController();
  bool isSideMenuClosed = true;
  late GoogleMapController _mapController;
  

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  @override
  void initState() {
    DefaultAssetBundle.of(context)
        .loadString(StringConstants.mapThemeAubergine)
        .then((value) => mapTheme = value);
    super.initState();

    @override
    void dispose() {
      _mapController.dispose();
      _destinationController.dispose();
      super.dispose();
    }
  }

  double calculateVerticalShift(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.height * percentage;
  }

  Future<void> selectedPlace() async {
    final _selectedPlace =
        await GooglePlacesService().showGoogleAutoComplete(context);
    _destinationController.text = _selectedPlace.description!;
    final mapUtility =
        MapUtility(GoogleMapsPlaces(apiKey: StringConstants.kGoogleApiKey), _mapController);
    mapUtility.goToPlace(_selectedPlace.placeId!);

    setState(() {
      showSourceField = true;
    });
  }

  Future<void> onMapCreated(GoogleMapController controller) async {
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
  }
}
