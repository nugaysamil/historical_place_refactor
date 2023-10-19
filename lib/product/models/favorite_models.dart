class Favorite {
  final String name;
  late final String image;
  final String information;

  Favorite({
    required this.name,
    required this.image,
    required this.information,
  });


  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'information': information,
    };
  }

  factory Favorite.fromMap(Map<String, dynamic> map) {
    return Favorite(
      name: map['name'],
      image: map['image'],
      information: map['information'],
    );
  }
}
