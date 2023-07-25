class LoginRequestModel {
    final String identifier;
    final String password;

    LoginRequestModel({
        required this.identifier,
        required this.password,
    });

    factory LoginRequestModel.fromJson(Map<String, dynamic> json) => LoginRequestModel(
        identifier: json["identifier"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "identifier": identifier,
        "password": password,
    };
}
