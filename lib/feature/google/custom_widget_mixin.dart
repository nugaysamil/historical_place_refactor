part of 'custom_widget.dart';

mixin CustomWidgetMixin on State<CustomMarkerInfoWindow> {
  bool isSideMenuClosed = true;
  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> scaleAnimation;

  double calculateVerticalShift(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.height * percentage;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void sideMenuCloseOrOpen() {
    if (isSideMenuClosed) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    setState(() {
      isSideMenuClosed = !isSideMenuClosed;
    });
  }
}
