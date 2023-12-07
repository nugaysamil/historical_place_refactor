import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/api_model.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<MarkerModel>> getMarkerList() async {
    var response = await http
        .get(Uri.parse("https://ancientcitiesturkey.com/api/tr/ruins"));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      final List<MarkerModel> markerList = [];

      for (var item in jsonData) {
        markerList.add(MarkerModel.fromMap(item as Map<String, dynamic>));
      }



      return markerList;
    } else {
      throw Exception('Failed to load marker list');
    }
  }

  Future<Map<String, dynamic>> getRuins(String slug) async {
    try {
      var response2 = await Dio()
          .get('https://ancientcitiesturkey.com/api/tr/ruins/' + slug);

      Map<String, dynamic> responseMap = {};

      if (response2.statusCode == 200) {
        responseMap = response2.data;

        return responseMap;
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      return Future.error(e);
    }
    return getRuins(slug);
  }
}

