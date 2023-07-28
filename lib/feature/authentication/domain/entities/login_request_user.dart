class LoginRequestUser {
  final String usernameOrEmail;
  final String password;

  const LoginRequestUser({
    required this.usernameOrEmail,
    required this.password,
  });
}
