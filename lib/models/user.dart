class User {
  int? id;
  String? name;
  String? image;
  String? email;
  String? genre;
  String? token;

  User({
    this.id,
    this.name,
    this.image,
    this.email,
    this.genre,
    this.token,
  });

  // to convert json data to user model
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['user']['id'],
        name: json['user']['name'],
        genre: json['user']['genre'],
        image: json['user']['image'],
        email: json['user']['email'],
        token: json['token']);
  }
}
