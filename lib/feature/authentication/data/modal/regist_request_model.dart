class RegistRequestModel {
    final String name;
    final String password;
    final String email;
    final String username;

    RegistRequestModel({
        required this.name,
        required this.password,
        required this.email,
        required this.username,
    });

    factory RegistRequestModel.fromJson(Map<String, dynamic> json) => RegistRequestModel(
        name: json["name"],
        password: json["password"],
        email: json["email"],
        username: json["username"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "password": password,
        "email": email,
        "username": username,
    };
}
