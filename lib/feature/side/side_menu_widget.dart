// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:mapsuygulama/feature/side/favorite_widget.dart';
import 'package:mapsuygulama/feature/profile/profile_update/notification_widget.dart';
import 'package:mapsuygulama/feature/profile/profile_update/profile_update_widget.dart';
import 'package:mapsuygulama/feature/profile/profile_update/settings_widget.dart';
import 'package:mapsuygulama/feature/slack/screen/onbording_screen.dart';
import 'package:rive/rive.dart';
import 'package:mapsuygulama/feature/google/google.dart';
import 'package:mapsuygulama/product/models/rive_asset.dart';
import 'package:mapsuygulama/product/helper/rive_utils_helper.dart';
import 'component/info_card.dart';
import 'component/side_menu_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  RiveAsset selectedMenu = sideMenus.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 288,
        height: double.infinity,
        color: Color(0xFF17203A),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InfoCard(),
              _browseText(context),
              ...sideMenus.map(
                (menu) => SideMenuTile(
                  menu: menu,
                  press: () {
                    menu.input!.change(true);
                    setState(() {
                      selectedMenu = menu;
                    });

                    Future.delayed(
                      Duration(milliseconds: 750),
                      () {
                        menu.input!.change(false);
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              if (menu.title == 'Profile') {
                                return ProfileEditUpdate();
                              } else if (menu.title == 'Home') {
                                return CustomMarkerInfoWindow(
                                  markers: markers,
                                  customInfoWindowController:
                                      customInfoWindowController,
                                );
                              } else if (menu.title == 'Search') {
                                return CustomMarkerInfoWindow(
                                  markers: markers,
                                  customInfoWindowController:
                                      customInfoWindowController,
                                );
                              }
                              return NotificationWidget();
                            },
                          ),
                        );
                      },
                    );
                  },
                  riveonInit: (artboard) {
                    StateMachineController controller =
                        RiveUtils.getRiveController(artboard,
                            stateMachineName: menu.stateMachineName);
                    menu.input = controller.findSMI('active') as SMIBool;
                  },
                  isActive: selectedMenu == menu,
                ),
              ),
              _historyText(context),
              ...sideMenu2.map(
                (menu) => SideMenuTile(
                  menu: menu,
                  press: () {
                    menu.input!.change(true);
                    Future.delayed(Duration(milliseconds: 750), () {
                      menu.input!.change(false);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          if (menu.title == 'Settings') {
                            return LanguageSelection();
                          }
                          return FavWidget();
                        }),
                      );
                    });
                    setState(() {
                      selectedMenu = menu;
                    });
                  },
                  riveonInit: (artboard) {
                    StateMachineController controller =
                        RiveUtils.getRiveController(artboard,
                            stateMachineName: menu.stateMachineName); // bakcaz

                    menu.input = controller.findSMI('active') as SMIBool;
                  },
                  isActive: selectedMenu == menu,
                ),
              ),
              SizedBox(height: 5),
              GestureDetector(
                onTap: () async {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );

                  signOut();

                  await Future.delayed(Duration(milliseconds: 750));

                  Navigator.pop(context);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OnBoardingScreen(),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 13),
                      child: IconButton(
                        color: Colors.white,
                        onPressed: () {},
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
    );
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

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
