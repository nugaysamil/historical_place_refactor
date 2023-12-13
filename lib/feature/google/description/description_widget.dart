// ignore_for_file: public_member_api_docs, sort_constructors_first, deprecated_member_use
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../side/favorite_widget.dart';

class DescriptionDetails extends ConsumerWidget {
  final dynamic data;
  final String placeUrl;
  final String markerList;

  const DescriptionDetails({
    Key? key,
    required this.data,
    required this.placeUrl,
    required this.markerList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);

    bool isPressed = favorites.any((favorite) =>
        favorite.name == markerList &&
        favorite.image == data['image'] &&
        favorite.information == data['information']);

    final latitude = data['latitude'];
    final longitude = data['longitude'];
    final url =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

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
            markerList,
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
                  final favoritesNotifier =
                      ref.read(favoritesProvider.notifier);

                  if (isPressed) {
                    final dataToRemove = {
                      'name': markerList,
                      'image': data['image'],
                      'information': data['information'],
                    };
                    await favoritesNotifier.deleteFromFirestore(dataToRemove);
                  } else {
                    await favoritesNotifier.readFromFirestore();
                    final newData = {
                      'name': markerList,
                      'image': data['image'],
                      'information': data['information'],
                    };
                    await favoritesNotifier.writeToFirestore(
                        markerList, newData);
                  }
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
                child: data['image'] == ""
                    ? Container()
                    : Image.network(
                        placeUrl + data['image'],
                        fit: BoxFit.fitHeight,
                      ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Container(
                  child: Text(
                    data['information'] != null
                        ? data['information'].toString()
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
                    launch(data['foursquare'].toString());
                  },
                  child: Image.asset(
                    'assets/images/foursquare.png',
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
                    launch(data['tripadvisor'].toString());
                  },
                  child: Image.asset(
                    'assets/images/tripadvisor.jpg',
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text(
                "language_resource_tr".tr(),
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 18),
              GestureDetector(
                onTap: () {
                  if (data['turkish_links'] != null) {
                    final turkishLinks = data['turkish_links'];
                    if (turkishLinks.isNotEmpty) {
                      final link = turkishLinks[0];
                      if (link['description'] != null && link['url'] != null) {
                        launch(link['url']);
                      }
                    }
                  }
                },
                child: Text(
                  data['turkish_links'] != null &&
                          data['turkish_links'].isNotEmpty
                      ? data['turkish_links'][0]['description'].isEmpty
                          ? ''
                          : data['turkish_links'][0]['description']
                      : 'Boş',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text("language_resource_en".tr(),
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              SizedBox(height: 18),
              GestureDetector(
                onTap: () {
                  if (data['english_links'] != null) {
                    final englishLinks = data['english_links'];
                    if (englishLinks.isNotEmpty) {
                      final link = englishLinks[0];
                      if (link['description'] != null && link['url'] != null) {
                        launch(link['url']);
                      }
                    }
                  }
                },
                child: Text(
                  data['english_links'] != null &&
                          data['english_links'].isNotEmpty
                      ? data['english_links'][0]['description'] ?? 'Boş'
                      : '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              SizedBox(height: 10),
              if (data['english_links'].length > 1)
                GestureDetector(
                  onTap: () {
                    launch(data['english_links'][1]['url']);
                  },
                  child: Text(
                    data['english_links'][1]['description'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              SizedBox(height: 10),
              if (data['english_links'].length > 2)
                GestureDetector(
                  onTap: () {
                    launch(data['english_links'][2]['url']);
                  },
                  child: Text(
                    data['english_links'][2]['description'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              Container(
                margin: EdgeInsets.only(bottom: 50),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    onPrimary: Colors.white,
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
