import 'package:flutter_fic_ecommerce_warung_comicon/feature/authentication/data/modal/login_request_model.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/authentication/domain/entities/login_user_result.dart';

import 'package:flutter_fic_ecommerce_warung_comicon/feature/authentication/domain/entities/login_user_request.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/repos/auth_repo.dart';
import '../data_source/auth_local_data_source.dart';
import '../data_source/auth_remote_data_source.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;
  AuthRepoImpl(this.authRemoteDataSource, this.authLocalDataSource);

  @override
  Future<LoginUserResult> userLogin(LoginUserRequest userRequest) async {
    try {
      final requestLogin = LoginRequestModel(
        identifier: userRequest.usernameOrEmail,
        password: userRequest.password,
      );
      final loginResult = await authRemoteDataSource.login(requestLogin);
      await authLocalDataSource.saveAccessToken(loginResult.jwt);
      final resultLogin = LoginUserResult(
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
  Future<LoginUserResult> verifyUserToken() async {
    try {
      final loginResult = await authRemoteDataSource.verifyMe();
      final resultLogin = LoginUserResult(
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
}
