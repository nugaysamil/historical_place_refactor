// ignore_for_file: public_member_api_docs, sort_constructors_first, deprecated_member_use
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsuygulama/feature/google/description/description_details_mixin.dart';
import 'package:mapsuygulama/feature/google/description/link_text.dart';
import 'package:mapsuygulama/product/utils/const/string_const.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:mapsuygulama/product/generation/assets.gen.dart';
import 'package:mapsuygulama/product/models/marker_model.dart';
import 'package:mapsuygulama/product/models/ruins_model.dart';

import '../../side/favorite_widget.dart';

class DescriptionDetails extends ConsumerWidget with DescriptionDetailsMixin {
  final RuinsModel ruinsData;
  final MarkerModel markerData;

  const DescriptionDetails({
    Key? key,
    required this.ruinsData,
    required this.markerData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);
    final markerLatitude = markerData.latitude;
    final markerLongitude = markerData.longitude;
    final isPressed = isFavoritePressed(favorites, markerData, ruinsData);
    final url =
        '${StringConstants.googleMapsSearchUrl}$markerLatitude,$markerLongitude';

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text(
            markerData.name ?? '',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                color: Colors.white,
                iconSize: 40,
                onPressed: () async {
                  await handleFavoriteButtonPress(
                    ref,
                    isPressed,
                    markerData,
                    ruinsData,
                  );
                },
                icon: Icon(
                  Icons.star,
                  color: isPressed ? Colors.yellow : null,
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: ruinsData.image != null
                    ? Image.network(
                        StringConstants.placeUrl + '${ruinsData.image}')
                    : Container(
                        color: Colors.grey,
                        child: Center(
                          child: Text('No image available'),
                        ),
                      ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Container(
                  child: Text(
                    ruinsData.information != null
                        ? ruinsData.information.toString()
                        : 'source'.tr(),
                    textAlign: TextAlign.justify,
                    style: TextStyle(wordSpacing: 2.0),
                  ),
                ),
              ),
              Container(
                width: 130,
                height: 100,
                color: Colors.transparent,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  onPressed: () {
                    launch(ruinsData.foursquare!);
                  },
                  child: Image.asset(
                    Assets.images.foursquare.path,
                  ),
                ),
              ),
              Container(
                width: 130,
                height: 100,
                color: Colors.transparent,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  onPressed: () {
                    launch(ruinsData.tripadvisor!);
                  },
                  child: Image.asset(
                    Assets.images.tripadvisor.path,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text(
                "language_resource_tr".tr(),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 18),
              GestureDetector(
                onTap: () {
                  if (ruinsData.turkishLinks != null &&
                      ruinsData.turkishLinks!.isNotEmpty &&
                      ruinsData.turkishLinks![0].url != null) {
                    launch(ruinsData.turkishLinks![0].url!);
                  }
                },
                child: Text(
                  ruinsData.turkishLinks != null &&
                          ruinsData.turkishLinks!.isNotEmpty &&
                          ruinsData.turkishLinks![0].description != null
                      ? ruinsData.turkishLinks![0].description!
                      : 'Boş',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              SizedBox(height: 18),
              if (ruinsData.turkishLinks!.length > 1)
                LinkText(
                  text: ruinsData.turkishLinks![1].description,
                  url: ruinsData.turkishLinks![1].url,
                ),
              SizedBox(height: 15),
              Text(
                "language_resource_en".tr(),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 18),
              Column(
                children: [
                  LinkText(
                    text: ruinsData.turkishLinks != null &&
                            ruinsData.turkishLinks!.isNotEmpty &&
                            ruinsData.turkishLinks![0].description != null
                        ? ruinsData.turkishLinks![0].description
                        : null,
                    url: ruinsData.turkishLinks != null &&
                            ruinsData.turkishLinks!.isNotEmpty &&
                            ruinsData.turkishLinks![0].url != null
                        ? ruinsData.turkishLinks![0].url
                        : null,
                  ),
                  SizedBox(height: 18),
                  LinkText(
                    text: ruinsData.englishLinks != null &&
                            ruinsData.englishLinks!.isNotEmpty &&
                            ruinsData.englishLinks![0].description != null
                        ? ruinsData.englishLinks![0].description
                        : null,
                    url: ruinsData.englishLinks != null &&
                            ruinsData.englishLinks!.isNotEmpty &&
                            ruinsData.englishLinks![0].url != null
                        ? ruinsData.englishLinks![0].url
                        : null,
                  ),
                  SizedBox(height: 10),
                  if (ruinsData.englishLinks!.length > 1)
                    LinkText(
                      text: ruinsData.englishLinks![1].description,
                      url: ruinsData.englishLinks![1].url,
                    ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.only(bottom: 50),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onPressed: () {
                    launch(url);
                  },
                  child: Text("open_google_maps".tr()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
