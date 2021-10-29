class UserData {
  UserData({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.imageUrl,
    this.location,
  });

  final String id;
  final String name;
  final String phone;
  final String email;
  final String imageUrl;
  final String location;

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json["id"] as String,
      name: json["name"] as String,
      phone: json["phone"] as String,
      email: json["email"] as String,
      imageUrl: json["imageUrl"] as String,
      location: json["location"] as String,
    );
  }
}