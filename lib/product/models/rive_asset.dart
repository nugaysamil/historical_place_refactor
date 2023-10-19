// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:rive/rive.dart';

class RiveAsset {
  final String src;
  final String artboard;
  final String stateMachineName;
  final String title;

  late SMIBool? input;

  RiveAsset({
    required this.src,
    required this.artboard,
    required this.stateMachineName,
    required this.title,
    this.input,
  });

  set setInput(SMIBool status) {
    input = status;
  }
}

List<RiveAsset> bottomNavs = [
  RiveAsset(
      src: 'assets/RiveAssets/icon.riv',
      artboard: 'CHAT',
      stateMachineName: 'CHAT_Interactivity',
      title: 'Chat'),
  RiveAsset(
      src: 'assets/RiveAssets/icon.riv',
      artboard: 'SEARCH',
      stateMachineName: 'SEARCH',
      title: 'SEARCH'),
  RiveAsset(
      src: 'assets/RiveAssets/icon.riv',
      artboard: 'TIMER',
      stateMachineName: 'TIMER_Interactivity',
      title: 'Notification'),
  RiveAsset(
      src: 'assets/RiveAssets/icon.riv',
      artboard: 'USER',
      stateMachineName: 'USER_Interactivity',
      title: 'Profile'),
];

List<RiveAsset> sideMenus = [
  RiveAsset(
    src: 'assets/RiveAssets/icons.riv',
    artboard: 'USER',
    stateMachineName: 'USER_Interactivity',
    title: 'Profile',
  ),
  RiveAsset(
      src: 'assets/RiveAssets/icons.riv',
      artboard: 'HOME',
      stateMachineName: 'HOME_interactivity',
      title: 'Home'),
  RiveAsset(
      src: 'assets/RiveAssets/icons.riv',
      artboard: 'BELL',
      stateMachineName: 'BELL_Interactivity',
      title: 'Notification'),
];
List<RiveAsset> sideMenu2 = [
  RiveAsset(
      src: 'assets/RiveAssets/icons.riv',
      artboard: 'SETTINGS',
      stateMachineName: 'SETTINGS_Interactivity',
      title: 'Settings'),
  RiveAsset(
      src: 'assets/RiveAssets/icons.riv',
      artboard: 'LIKE/STAR',
      stateMachineName: 'STAR_Interactivity',
      title: 'Favorites'),
];
