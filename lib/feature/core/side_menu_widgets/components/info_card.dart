// ignore_for_file: unused_local_variable, invalid_use_of_protected_member

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../database/user_data_notifier.dart';
import '../../../../product/models/user_model.dart';

final userDataProvider =
    StateNotifierProvider<UserDataNotifier, UserData>((ref) {
  return UserDataNotifier();
});

class InfoCard extends ConsumerWidget {
  const InfoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userdata = ref.watch(userDataProvider.notifier).state;

    return ListTile(
      contentPadding: EdgeInsets.all(10),
      leading: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ClipOval(
          child: userdata.imageUrl.isNotEmpty
              ? Image.network(
                  userdata.imageUrl,
                  fit: BoxFit.cover,
                )
              : Icon(
                  CupertinoIcons.person,
                  color: Colors.white,
                ),
        ),
      ),
      title: Text(
        userdata.name,
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      subtitle: Text(
        userdata.location,
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
