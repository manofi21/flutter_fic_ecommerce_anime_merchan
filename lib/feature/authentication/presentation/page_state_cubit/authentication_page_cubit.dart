import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../core/show_dialog/show_confirm_dialog.dart';
import '../../../home/presentation/page/home_page.dart';
import '../bloc/authentication_bloc.dart';

part 'authentication_page_state.dart';

class AuthenticationPageCubit extends Cubit<AuthPageStateEntitiy> {
  final AuthenticationBloc authBloc;
  AuthenticationPageCubit({required this.authBloc})
      : super(
          AuthPageStateEntitiy(
            pageState: AuthenticationPageState.register,
          ),
        );

  void _changeStateToLogin() {
    emit(AuthPageStateEntitiy(pageState: AuthenticationPageState.login));
  }

  void _changeStateToRegistration() {
    emit(AuthPageStateEntitiy(pageState: AuthenticationPageState.register));
  }

  void onChangeState({required void Function() onBeforeChange}) {
    onBeforeChange();
    if (state.pageState == AuthenticationPageState.register) {
      _changeStateToLogin();
      return;
    }

    if (state.pageState == AuthenticationPageState.login) {
      _changeStateToRegistration();
      return;
    }
  }

  void onPressed(String name, String username, String password, String email,
      String usernameOrEmail, BuildContext context,
      {required void Function() onAfterClick}) {
    if (state.pageState == AuthenticationPageState.register) {
      authBloc.onRegisting(
        name: name,
        username: username,
        email: email,
        password: password,
        onSuccess: () async {
          onAfterClick();
          await showConfirmDialog(
            context: context,
            message: 'Silahkan Melakukan Login kembali!',
            ok: () {},
            trueFalseOption: false,
          );
          _changeStateToLogin();
        },
      );
      return;
    }

    if (state.pageState == AuthenticationPageState.login) {
      authBloc.onLogin(
        usernameOrEmail: usernameOrEmail,
        password: password,
        onSuccess: () {
          onAfterClick();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const HomePage(),
            ),
          );
        },
      );
      return;
    }
  }
}
