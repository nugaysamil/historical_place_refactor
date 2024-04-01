import 'package:flutter/material.dart';
import 'package:mapsuygulama/product/models/rive_asset.dart';

class SideMenuViewModel extends ChangeNotifier {
  RiveAsset _selectedMenu = sideMenus.first;

  RiveAsset get selectedMenu => _selectedMenu;

  void setSelectedMenu(RiveAsset menu) {
    _selectedMenu = menu;
    notifyListeners();
  }
}
