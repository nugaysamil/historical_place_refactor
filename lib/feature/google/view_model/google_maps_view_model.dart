// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsuygulama/product/models/marker_model.dart';
import 'package:mapsuygulama/product/models/ruins_model.dart';
import 'package:mapsuygulama/product/service/manager/product_network_manager.dart';

class GoogleMapsViewModel {
  final Dio dio = ProjectNetworkManager.instance!.dio;

  List<MarkerModel> models = [];

  Future<void> fetchMarkers() async {
    try {
      final response =
          await dio.get('https://ancientcitiesturkey.com/api/tr/ruins');

      if (response.statusCode == 200) {
        final markerList = response.data as List<dynamic>;
        models = markerList
            .map((e) => MarkerModel.fromJson(e as Map<String, dynamic>))
            .toList();

      }
    } on DioError catch (e) {
      return Future.error(e);
    }
  }

  Future<Map<String, dynamic>> getRuins(String slug) async {
    try {
      final response =
          await dio.get('https://ancientcitiesturkey.com/api/tr/ruins/$slug');

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        return Future.error('Error! Failed to load ruins data.');
      }
    } on DioError catch (e) {
      return Future.error(e);
    }
  }
}

final googleMapsViewModelProvider = Provider((ref) => GoogleMapsViewModel());

final markersProvider = FutureProvider((ref) async {
  final viewModel = ref.read(googleMapsViewModelProvider);
  await viewModel.fetchMarkers();
  return viewModel.models;
});

final ruinDetailsProvider =
    FutureProvider.family<RuinsModel, String>((ref, slug) async {
  final viewModel = ref.read(googleMapsViewModelProvider);
  final ruinsData = await viewModel.getRuins(slug);
  return RuinsModel.fromJson(ruinsData);
});
