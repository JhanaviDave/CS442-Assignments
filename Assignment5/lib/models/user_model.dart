//Jhanavi Dave (A20515346)
// define user details
class User {
  String username;
  String password;
  int appColor;

  User({
    required this.username,
    required this.password,
    required this.appColor,
  });

  // Cconvert object for easy map to json
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
      'appColor': appColor,
    };
  }

  // create user from mapped data
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'],
      password: map['password'],
      appColor: map['appColor'],
    );
  }
}
