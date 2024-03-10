part of 'profile_update_widget.dart';

mixin ProfileEditUpdateMixin on State<ProfileEditUpdate> {
  String? imageUrl;

  bool isObscurePassword = true;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final bool isPasswordTextField = false;

  @override
  void initState() {
    super.initState();
    readUserData();
  }

  Future<void> readUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (snapshot.exists) {
        final userData = snapshot.data()!;
        setState(() {
          _nameController.text = userData['name'] ?? '';
          _locationController.text = userData['location'] ?? '';
          _ageController.text = userData['age'] ?? '';
          imageUrl = userData['imageUrl'];
        });
      }
    }
  }

  Future<void> getImageUtils() async {
    XFile? file = await getImage();
    if (file != null) {
      final imageUrl = await DatabaseServices.uploadImage(file);
      setState(
        () {
          this.imageUrl = imageUrl;
        },
      );
    }
  }

  void saveUserDataController() {
    FirebaseService.saveUserData(
      _nameController.text,
      _ageController.text,
      _locationController.text,
      imageUrl!,
    ).then((value) {
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("data_saved_success".tr()),
          duration: Duration(seconds: 2),
        ),
      );

      // Delay and then navigate to the next screen
      Future.delayed(
        Duration(seconds: 2),
        () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CustomMarkerInfoWindow(),
          ),
        ),
      );
    });
  }

  Future<XFile?> getImage() async {
    final picker = ImagePicker();

    return await picker.pickImage(
      source: ImageSource.gallery,
    );
  }
}
