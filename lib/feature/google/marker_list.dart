/* import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapsuygulama/animations/animation_widget.dart';
import 'package:mapsuygulama/feature/google/description/description_widget.dart';
import 'package:mapsuygulama/product/data_provider/api_provider.dart';
import 'package:mapsuygulama/product/models/api_model.dart';
import 'package:mapsuygulama/product/service/fetch_api.dart';
import 'package:mapsuygulama/product/utils/const/string_const.dart';

class MarkerListDetails extends ConsumerStatefulWidget {

  const MarkerListDetails({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MarkerListDetailsState();
}
Set<Marker> markers = {};


class _MarkerListDetailsState extends ConsumerState<MarkerListDetails> {

  BitmapDescriptor? markerIcon;
  late List<MarkerModel> markerData;

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
  void initState() {
    addCustomIcon();
    super.initState();
  }
/*  */
  @override
  Widget build(BuildContext context) {
    final markerModel = ref.watch(singleUserDataProvider);

    return markerModel.when(
      data: (data) {
        markerData = data;
        for (int j = 0; j < markerData.length; j++) {
          print(markerData);
          markers.add(
            Marker(
              markerId: MarkerId(markerData[j].id.toString()),
              position: LatLng(markerData[j].latitude, markerData[j].longitude),
              icon: markerIcon!,
              onTap: () async {
                var myData = await ApiService().getRuins(markerData[j].slug);

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
                                  markerData[j].name,
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
                                          markerList: markerData[j].name,
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
        print(markerData);
        return Container();
      },
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }
}
 */