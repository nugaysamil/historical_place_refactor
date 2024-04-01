// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rive/rive.dart';
import 'package:mapsuygulama/feature/view/google/google_maps_widget.dart';
import 'package:mapsuygulama/feature/view/side_menu/side_menu_widget.dart';
import 'package:mapsuygulama/product/data_provider/auth_provider.dart';
import 'package:mapsuygulama/product/utils/const/string_const.dart';

part 'mixin/custom_widget_mixin.dart';

class CustomMarkerInfoWindow extends ConsumerStatefulWidget {
  const CustomMarkerInfoWindow({
    Key? key,
  });

  @override
  _CustomConsumerWidgetState createState() => _CustomConsumerWidgetState();
}

class _CustomConsumerWidgetState extends ConsumerState<CustomMarkerInfoWindow>
    with SingleTickerProviderStateMixin, CustomWidgetMixin {
  
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    )..addListener(() {
        setState(() {});
      });
    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));

    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF17203A),
      extendBody: true,
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            width: 288,
            left: isSideMenuClosed ? -288 : 0,
            height: MediaQuery.of(context).size.height,
            child: SideMenu(),
          ),
          Transform.translate(
            offset: Offset(animation.value * 265, 0),
            child: Transform.scale(
              scale: scaleAnimation.value,
              child: GoogleMapsWidget(),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 200),
            left: isSideMenuClosed ? 0 : 230,
            curve: Curves.fastOutSlowIn,
            child: SafeArea(
              child: Visibility(
                visible: authState.asData?.value != null,
                child: Container(
                  margin: EdgeInsets.only(
                      top: calculateVerticalShift(context, 0.007)),
                  child: FloatingActionButton(
                    backgroundColor: Colors.white,
                    onPressed: () => sideMenuCloseOrOpen(),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: RiveAnimation.asset(
                        StringConstants.rivIconsAssetDir,
                        artboard: StringConstants.artBoard,
                        onInit: (riveOnInit) {},
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
 
}
