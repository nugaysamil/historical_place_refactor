import 'package:image_picker/image_picker.dart';

Future<XFile?> getImage() async {
  final picker = ImagePicker();

  try {
    return await picker.pickImage(
      source: ImageSource.gallery,
    );
  } catch (e) {
    print('Error selecting image: $e');

    return null;
  }
}
