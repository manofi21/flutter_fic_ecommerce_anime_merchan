import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/result_handler/no_params.dart';
import '../../domain/entities/login_request_user.dart';
import '../../domain/entities/register_request_user.dart';
import '../../domain/use_cases/login_user_cases.dart';
import '../../domain/use_cases/registration_user_cases.dart';
import '../../domain/use_cases/verify_user_token_cases.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final VerifyUserTokenCases verivyTokenCases;
  final RegistrationUserCases registrationCases;
  final LoginUserCases loginCases;

  AuthenticationBloc(
    this.verivyTokenCases,
    this.registrationCases,
    this.loginCases,
  ) : super(const AuthenticationInitial()) {
    /// Verify prosses
    on<OnVerifyTokenEvent>(
      (event, emit) async {
        emit(const AuthenticationLoginLoading());
        final accessCases = await verivyTokenCases(NoParams());
        accessCases.when(
          err: (error) {
            emit(AuthenticationLoginError(error.message));
          },
          ok: (ok) {
            emit(const AuthenticationLoginComplete());
          },
        );
      },
    );

    /// Register prosses
    on<OnRegistrationEvent>(
      (event, emit) async {
        emit(const AuthenticationRegistrationLoading());
        final accessCases = await registrationCases(event.registModel);
        accessCases.when(
          error: (error) {
            var message = error.message;
            debugPrint('Error : $message');
            if (error.message.contains(':')) {
              message = error.message.split(':').last;
            }
            emit(AuthenticationRegistrationError(message));
          },
          none: () {
            emit(const AuthenticationRegistrationComplete());
            event.onSuccess();
          },
        );
      },
    );
  }

  void onRegisting({
    required String name,
    required String username,
    required String email,
    required String password,
    required void Function() onSuccess,
  }) {
    add(
      OnRegistrationEvent(
        registModel: RegisterRequestUser(
          name: name,
          password: password,
          email: email,
          username: username,
        ),
        onSuccess: onSuccess,
      ),
    );
  }
}
