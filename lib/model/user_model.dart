class User {
  int id;
  String? imagePath;

  User({this.imagePath, required this.id});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(id: map['id'], imagePath: map['imagePath']);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'imagePath': imagePath};
  }
}
