// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserData {
  final String name;
  final String location;
  final String age;
  final String imageUrl;

  UserData({
    this.name = '',
    this.location = '',
    this.age = '',
    this.imageUrl = ''
  });

  UserData copyWith({
    String? name,
    String? location,
    String? age,
    String? imageURL,
  }) {
    return UserData(
      name: name ?? this.name,
      location: location ?? this.location,
      age: age ?? this.age,
      imageUrl: imageURL ?? this.imageUrl,
    );
  }
}
