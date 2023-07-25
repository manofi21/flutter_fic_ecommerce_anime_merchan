class LoginUserRequest {
  final String usernameOrEmail;
  final String password;

  const LoginUserRequest({
    required this.usernameOrEmail,
    required this.password,
  });
}
