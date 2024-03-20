// ignore_for_file: public_member_api_docs, unused_field

import 'package:dio/dio.dart';

class ProjectNetworkManager {
  ProjectNetworkManager._init() {
    dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
      ),
    );
  }
  static ProjectNetworkManager? _instance;

  static ProjectNetworkManager? get instance {
    if (_instance != null) return _instance!;
    _instance = ProjectNetworkManager._init();
    return _instance!;
  }

  final String _baseUrl = 'https://ancientcitiesturkey.com/api/tr/ruins';


  late final Dio dio;
}
