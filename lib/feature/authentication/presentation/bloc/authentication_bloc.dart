import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/authentication/domain/entities/login_result_user.dart';

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
        emit(const AuthenticationVerifyTokenLoading());
        final accessCases = await verivyTokenCases(NoParams());
        final returnState = accessCases.when<AuthenticationState>(
          err: (error) {
            return AuthenticationVerifyTokenError(error.message);
          },
          ok: (ok) {
            if (ok == LoginResultUser.empty()) {
              return const AuthenticationNoTokenSaved();
            }

            return const AuthenticationVerifyTokenComplete();
          },
        );

        emit(returnState);
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

    /// Login prosses
    on<OnLoginEvent>(
      (event, emit) async {
        emit(const AuthenticationLoginLoading());
        final accessCases = await loginCases(event.loginModel);
        accessCases.when(
          err: (error) {
            var message = error.message;
            debugPrint('Error : $message');
            if (error.message.contains(':')) {
              message = error.message.split(':').last;
            }
            emit(AuthenticationLoginError(message));
          },
          ok: (result) {
            emit(const AuthenticationLoginComplete());
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

  void onLogin({
    required String usernameOrEmail,
    required String password,
    required void Function() onSuccess,
  }) {
    add(
      OnLoginEvent(
        loginModel: LoginRequestUser(
          usernameOrEmail: usernameOrEmail,
          password: password,
        ),
        onSuccess: onSuccess,
      ),
    );
  }
}
