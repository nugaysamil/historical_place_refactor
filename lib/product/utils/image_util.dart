import 'package:image_picker/image_picker.dart';

Future<XFile?> getImage() async {
  final picker = ImagePicker();

  return await picker.pickImage(
    source: ImageSource.gallery,
  );
}
