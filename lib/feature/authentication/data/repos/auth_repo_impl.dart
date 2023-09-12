import 'package:flutter_fic_ecommerce_warung_comicon/core/use_cases/exception_to_failure.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/authentication/data/modal/login_request_model.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/authentication/data/modal/regist_request_model.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/authentication/domain/entities/login_result_user.dart';

import 'package:flutter_fic_ecommerce_warung_comicon/feature/authentication/domain/entities/login_request_user.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/register_request_user.dart';
import '../../domain/repos/auth_repo.dart';
import '../data_source/auth_local_data_source.dart';
import '../data_source/auth_remote_data_source.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;
  AuthRepoImpl(this.authRemoteDataSource, this.authLocalDataSource);

  @override
  Future<LoginResultUser> userLogin(LoginRequestUser userRequest) async {
    try {
      final requestLogin = LoginRequestModel(
        identifier: userRequest.usernameOrEmail,
        password: userRequest.password,
      );
      final loginResult = await authRemoteDataSource.login(requestLogin);
      await authLocalDataSource.saveAccessToken(loginResult.jwt);
      final resultLogin = LoginResultUser(
          username: loginResult.user.username, email: loginResult.user.email);
      return resultLogin;
    } on HttpException catch (e) {
      throw AuthenticationFailure(e.message);
    } on UnknownException catch (e, stackTrace) {
      throw UnknownFailure(e.message, stackTrace);
    } catch (e, stackTrace) {
      throw UnknownFailure('Occure in Auth Repo : ${e.toString()}', stackTrace);
    }
  }

  @override
  Future<LoginResultUser> verifyUserTokenCases() async {
    try {
      final verivyToken = await authRemoteDataSource.verifyMe();
      final verivyResult = LoginResultUser(
        email: verivyToken.email,
        username: verivyToken.username,
      );
      return verivyResult;
    } on NoTokenSaved {
      return LoginResultUser.empty();
    } on HttpException catch (e) {
      throw AuthenticationFailure(e.message);
    } on UnknownException catch (e, stackTrace) {
      throw UnknownFailure(e.message, stackTrace);
    } catch (e, stackTrace) {
      throw UnknownFailure('Occure in Auth Repo : ${e.toString()}', stackTrace);
    }
  }

  @override
  Future<bool> registrationUser(RegisterRequestUser registerRequest) async {
    try {
      final registerParam = RegistRequestModel(
        name: registerRequest.name,
        password: registerRequest.password,
        email: registerRequest.email,
        username: registerRequest.username,
      );
      final registResult = await authRemoteDataSource.regist(registerParam);
      await authLocalDataSource.saveAccessToken(registResult.jwt);
      return registResult.jwt.isNotEmpty;
    } on BaseExceptions catch (e) {
      throw exceptionToFailure<AuthenticationFailure>(
        e,
        AuthenticationFailure.new,
      );
    } catch (e, stackTrace) {
      throw UnknownFailure('Occure in Auth Repo : ${e.toString()}', stackTrace);
    }
  }

  @override
  Future<void> logOutUser() async {
    try {
      await authLocalDataSource.clearToken();
    } on UnknownException catch (e, stackTrace) {
      throw UnknownFailure(e.message, stackTrace);
    } catch (e, stackTrace) {
      throw UnknownFailure('Occure in Auth logOutUser : ${e.toString()}', stackTrace);
    }
  }
}
