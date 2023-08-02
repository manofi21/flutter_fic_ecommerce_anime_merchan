part of 'authentication_page_cubit.dart';

enum AuthenticationPageState { register, login }

class AuthPageStateEntitiy {
  final String name;
  final String username;
  final String password;
  final String email;
  final String usernameOrName;
  final AuthenticationPageState pageState;

  AuthPageStateEntitiy({
    this.name = '',
    this.username = '',
    this.password = '',
    this.email = '',
    this.usernameOrName = '',
    required this.pageState,
  });
}
