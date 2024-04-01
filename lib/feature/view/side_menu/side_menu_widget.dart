// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:mapsuygulama/feature/view/side_menu/mixin/side_menu_mixin.dart';
import 'package:mapsuygulama/feature/view/side_menu/widget/favorite_widget.dart';
import 'package:mapsuygulama/feature/view/profile/profile_update/notification_widget.dart';
import 'package:mapsuygulama/feature/view/profile/profile_update/profile_update_widget.dart';
import 'package:mapsuygulama/feature/view/profile/settings/settings_screen.dart';
import 'package:mapsuygulama/feature/view/welcome/screen/onbording_screen.dart';
import 'package:mapsuygulama/feature/view_model/side_menu/side_menu_view_model.dart';
import 'package:rive/rive.dart';
import 'package:mapsuygulama/feature/view/google/custom_widget.dart';
import 'package:mapsuygulama/product/models/rive_asset.dart';
import 'package:mapsuygulama/product/helper/rive_utils_helper.dart';
import 'widget/info_card.dart';
import 'widget/side_menu_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> with SideMenuMixin {
  final viewModel = SideMenuViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 288,
        height: double.infinity,
        color: Color(0xFF17203A),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InfoCard(),
                _browseText(context),
                ...sideMenus.map(
                  (menu) => SideMenuTile(
                    menu: menu,
                    press: () {
                      viewModel.setSelectedMenu(menu);
                      _handleMenuSelection(context, menu);
                    },
                    riveonInit: (artboard) {
                      StateMachineController controller =
                          RiveUtils.getRiveController(artboard,
                              stateMachineName: menu.stateMachineName);
                      menu.input = controller.findSMI('active') as SMIBool;
                    },
                    isActive: viewModel.selectedMenu == menu,
                  ),
                ),
                _historyText(context),
                ...sideMenu2.map(
                  (menu) => SideMenuTile(
                    menu: menu,
                    press: () {
                      viewModel.setSelectedMenu(menu);
                      _handleMenuSelection(context, menu);
                    },
                    riveonInit: (artboard) {
                      StateMachineController controller =
                          RiveUtils.getRiveController(artboard,
                              stateMachineName: menu.stateMachineName);
                      menu.input = controller.findSMI('active') as SMIBool;
                    },
                    isActive: viewModel.selectedMenu == menu,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Divider(color: Colors.white24, height: 5),
                ),
                GestureDetector(
                  onTap: () => signOut(context),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 13),
                        child: IconButton(
                          color: Colors.white,
                          onPressed: () => signOut(context),
                          icon: Icon(Icons.logout),
                        ),
                      ),
                      SizedBox(width: 0),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          'Logout',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleMenuSelection(BuildContext context, RiveAsset menu) {
    menu.input!.change(true);
    Future.delayed(Duration(milliseconds: 750), () {
      menu.input!.change(false);
      switch (menu.title) {
        case 'Profile':
          navigateToProfile(context);
          break;
        case 'Home':
        case 'Search':
          navigateToHome(context);
          break;
        case 'Settings':
          navigateToSettings(context);
          break;
        case 'Favorites':
          navigateToFavorites(context);
          break;
        default:
          break;
      }
    });
  }

  Padding _historyText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
      child: Text(
        'History'.toUpperCase(),
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: Colors.white70),
      ),
    );
  }

  Padding _browseText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
      child: Text(
        'Browse'.toUpperCase(),
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: Colors.white70),
      ),
    );
  }
}
