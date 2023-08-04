// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class LoginResultUser extends Equatable {
  final String username;
  final String email;

  const LoginResultUser({required this.username,required this.email});

  static LoginResultUser empty() {
    return const LoginResultUser(username: '', email: '');
  }

  LoginResultUser copyWith({
    String? username,
    String? email,
  }) {
    return LoginResultUser(
      username: username ?? this.username,
      email: email ?? this.email,
    );
  }

  @override
  String toString() => 'LoginResultUser(username: $username, email: $email)';
  
  @override
  List<Object?> get props => [username, email];
}
