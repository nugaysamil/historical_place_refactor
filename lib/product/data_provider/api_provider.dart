import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsuygulama/product/service/fetch_api.dart';

import '../models/api_model.dart';

final markerProvider = Provider<ApiService?>((ref) => ApiService());

final singleUserDataProvider =
    FutureProvider.autoDispose<List<MarkerModel>>((ref) async {
  final ApiService = ref.read(markerProvider);
  ref.keepAlive();
  return ApiService!.getMarkerList();
});
