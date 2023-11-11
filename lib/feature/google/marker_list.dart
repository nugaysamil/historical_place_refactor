/* import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapsuygulama/animations/animation_widget.dart';
import 'package:mapsuygulama/feature/core/description_details/description_widget.dart';
import 'package:mapsuygulama/feature/data_provider/api_provider.dart';
import 'package:mapsuygulama/product/utils/string.dart';
import 'product/service/fetch_api.dart';
import 'package:custom_info_window/custom_info_window.dart';

class MarkerListDetail extends ConsumerStatefulWidget {
  const MarkerListDetail({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MarkerListDetail();
}

class _MarkerListDetail extends ConsumerState<MarkerListDetail> {
  @override
  Widget build(BuildContext context) {
    final markerModel = ref.watch(singleUserDataProvider);

    return 
  }
}

/*  Consumer(
      builder: ((context, ref, child) {
        final markerModel = ref.watch(singleUserDataProvider);

        if (markerModel.hasValue) {
          final markerList = markerModel.value;

          for (int j = 0; j < markerList!.length; j++) {
            print('data $markerList');

            markers.add(
              Marker(
                markerId: MarkerId(j.toString()),
                position:
                    LatLng(markerList[j].latitude, markerList[j].longitude),
                icon: BitmapDescriptor.defaultMarker,
                onTap: () async {
                  var myData = await ApiService().getRuins(markerList[j].slug);
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
                                      placeUrl + myData['image'].toString(),
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Text(
                                    markerList[j].name,
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
                                            markerList: markerList[j].name,
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
        }

        return Center(
            child: Text(
          'aaa',
          style: TextStyle(color: Colors.red),
        ));
      }),
    );  */
/*   Future<void> addCustomIcon() async {
    final icon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      "assets/star-icon.png",
    );
    setState(() {
      markerIcon = icon;
    });
  }

  BitmapDescriptor? markerIcon;
  @override
  void initState() {
    super.initState();
    myIcon();
    Future.delayed(Duration(seconds: 2), () {
      setState(() {});
    });
  }

  void myIcon() async {
    await addCustomIcon();
    setState(() {});
  } */
  

/*      for (int j = 0; j <data.le ; j++) {
          markers.add(
            Marker(
              markerId: MarkerId(j.toString()),
              position: LatLng(markerList[j].latitude, markerList[j].longitude),
              icon: BitmapDescriptor.defaultMarker,
              onTap: () async {
                var myData = await ApiService().getRuins(markerList[j].slug);
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
                                    placeUrl + myData['image'].toString(),
                                  ),
                                ),
                                SizedBox(height: 15),
                                Text(
                                  markerList[j].name,
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
                                          markerList: markerList[j].name,
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
        } */ */