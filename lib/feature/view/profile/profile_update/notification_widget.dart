import 'package:flutter/material.dart';
import 'package:mapsuygulama/feature/view/google/custom_widget.dart';


class NotificationWidget extends StatelessWidget {
  const NotificationWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CustomMarkerInfoWindow(
                ),
              ),
            );
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Bildirimler',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Center(child: Text('Henüz bir bildiriminiz yok.')),
    );
  }
}
