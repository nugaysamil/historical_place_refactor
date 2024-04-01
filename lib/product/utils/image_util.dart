import 'package:image_picker/image_picker.dart';

final class ImageSelector {
  final ImagePicker _picker = ImagePicker();

  Future<XFile?> getImage() async {
    try {
      return await _picker.pickImage(
        source: ImageSource.gallery,
      );
    } catch (e) {
      print('Error selecting image: $e');
      return null;
    }
  }
}
