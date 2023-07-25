// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class LoginUserResult extends Equatable {
  final String username;
  final String email;

  const LoginUserResult({required this.username,required this.email});

  LoginUserResult copyWith({
    String? username,
    String? email,
  }) {
    return LoginUserResult(
      username: username ?? this.username,
      email: email ?? this.email,
    );
  }

  @override
  String toString() => 'LoginUserResult(username: $username, email: $email)';
  
  @override
  List<Object?> get props => [username, email];
}
