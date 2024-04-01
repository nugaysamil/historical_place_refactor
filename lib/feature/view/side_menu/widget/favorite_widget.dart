// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsuygulama/product/database/description_notifier.dart';
import 'package:mapsuygulama/product/models/favorite_models.dart';

final favoritesProvider =
    StateNotifierProvider<FavoritesStateNotifier, List<Favorite>>(
  (ref) => FavoritesStateNotifier(),
);

class FavWidget extends ConsumerWidget {
  const FavWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesNotifier = ref.watch(favoritesProvider.notifier);

    Future<void>.microtask(() async {
      if (favoritesNotifier.state.isEmpty) {
        await favoritesNotifier.readFromFirestore();
      }
    });

    final favorites = ref.watch(favoritesProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Favorites'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: ListView.separated(
          itemCount: favorites.length,
          separatorBuilder: (context, index) => Divider(),
          itemBuilder: (context, index) {
            final favoriteData = favorites[index];
            return ListTile(
              leading: Icon(Icons.star),
              title: Text(
                favoriteData.name != 'null' && favoriteData.name.isNotEmpty
                    ? favoriteData.name
                    : '',
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Text(
                favoriteData.information != 'null' &&
                        favoriteData.information.isNotEmpty
                    ? favoriteData.information
                    : '',
                style: TextStyle(fontSize: 15),
              ),
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () {
                  /* Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DescriptionDetails(
                          data: favoriteData,
                          markerList: favoriteData.name,
                          placeUrl: favoriteData.image),
                    ),
                  ); */
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
