import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsuygulama/product/service/fetch_api.dart';

import '../models/api_model.dart';

final markerProvider = Provider<ApiService?>((ref) => ApiService());

final singleUserDataProvider = FutureProvider<List<MarkerModel>>((ref) async {
  final ApiService = ref.read(markerProvider);
  return ApiService!.getMarkerList();
});

final getRuinsProvider = Provider<ApiService>((ref) => ApiService());
