
// ignore_for_file: non_constant_identifier_names

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsuygulama/product/service/fetch_api.dart';

import '../models/api_model.dart';

final singleUserDataProvider = FutureProvider<List<MarkerModel>>((ref) async {
  final ApiService = ref.watch(userProvider);
  return ApiService!.getMarkerList();
});

final getRuinsProvider = Provider<ApiService>((ref) => ApiService());
