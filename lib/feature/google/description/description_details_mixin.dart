import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsuygulama/feature/side/favorite_widget.dart';
import 'package:mapsuygulama/product/models/favorite_models.dart';
import 'package:mapsuygulama/product/models/marker_model.dart';
import 'package:mapsuygulama/product/models/ruins_model.dart';

mixin DescriptionDetailsMixin {
  bool isFavoritePressed(
      List<Favorite> favorites, MarkerModel markerData, RuinsModel ruinsData) {
    return favorites.any((favorite) {
      return favorite.name == markerData &&
          favorite.image == ruinsData.image &&
          favorite.information == ruinsData.information;
    });
  }

  Future<void> handleFavoriteButtonPress(
    WidgetRef ref,
    bool isPressed,
    MarkerModel markerData,
    RuinsModel ruinsData,
  ) async {
    final favoritesNotifier = ref.read(favoritesProvider.notifier);

    if (isPressed) {
      final dataToRemove = {
        'name': markerData,
        'image': ruinsData.image,
        'information': ruinsData.information,
      };
      await favoritesNotifier.deleteFromFirestore(dataToRemove);
    } else {
      await favoritesNotifier.readFromFirestore();
      final newData = {
        'name': markerData,
        'image': ruinsData.image,
        'information': ruinsData.information,
      };
      await favoritesNotifier.writeToFirestore(
        markerData.name!,
        newData,
      );
    }
  }
}
