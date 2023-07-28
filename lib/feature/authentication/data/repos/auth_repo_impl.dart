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
    } on UnknownException catch (e) {
      throw UnknownFailure(e.message);
    } catch (e) {
      throw UnknownFailure('Occure in Auth Repo : ${e.toString()}');
    }
  }

  @override
  Future<LoginResultUser> verifyUserTokenCases() async {
    try {
      final loginResult = await authRemoteDataSource.verifyMe();
      final resultLogin = LoginResultUser(
        email: loginResult.email,
        username: loginResult.username,
      );
      return resultLogin;
    } on HttpException catch (e) {
      throw AuthenticationFailure(e.message);
    } on UnknownException catch (e) {
      throw UnknownFailure(e.message);
    } catch (e) {
      throw UnknownFailure('Occure in Auth Repo : ${e.toString()}');
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
      final loginResult = await authRemoteDataSource.regist(registerParam);
      return loginResult.jwt.isNotEmpty;
    } on HttpException catch (e) {
      throw AuthenticationFailure(e.message);
    } on UnknownException catch (e) {
      throw UnknownFailure(e.message);
    } catch (e) {
      throw UnknownFailure('Occure in Auth Repo : ${e.toString()}');
    }
  }
}
