import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/core/base_widget/wcon_text_field.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/core/show_dialog/show_error_dialog.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/authentication/presentation/page_state_cubit/authentication_page_cubit.dart';

import '../../../../core/base_widget/wcon_elevated_button.dart';
import '../../domain/entities/widget_with_auth_page_state.dart';
import '../bloc/authentication_bloc.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late final TextEditingController emailController;
  late final TextEditingController passController;
  late final TextEditingController usernameController;
  late final TextEditingController usernameOrEmailController;
  late final TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    usernameController = TextEditingController();
    usernameOrEmailController = TextEditingController();
    emailController = TextEditingController();
    passController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    usernameOrEmailController.dispose();
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  void onClear() {
    nameController.clear();
    usernameController.clear();
    usernameOrEmailController.clear();
    emailController.clear();
    passController.clear();
  }

  List<WidgetWithAuthPageState> get listWidget => [
        WidgetWithAuthPageState(
          child: WConTextField(
            usePrefix: true,
            prefixIcon: Icons.people,
            labelText: 'Name',
            controller: nameController,
          ),
          authState: AuthWidgetState.register,
        ),
        WidgetWithAuthPageState(
          child: WConTextField(
            usePrefix: true,
            prefixIcon: Icons.login,
            labelText: 'Username/Password',
            controller: usernameOrEmailController,
          ),
          authState: AuthWidgetState.login,
        ),
        WidgetWithAuthPageState(
          child: WConTextField(
            usePrefix: true,
            prefixIcon: Icons.account_box,
            labelText: 'Username',
            controller: usernameController,
          ),
          authState: AuthWidgetState.register,
        ),
        WidgetWithAuthPageState(
          child: WConTextField(
            usePrefix: true,
            prefixIcon: Icons.email_rounded,
            labelText: 'Email',
            controller: emailController,
          ),
          authState: AuthWidgetState.register,
        ),
        WidgetWithAuthPageState(
          child: WConTextField(
            usePrefix: true,
            prefixIcon: Icons.password_rounded,
            labelText: 'Password',
            controller: passController,
            obscure: true,
          ),
          authState: AuthWidgetState.registerAndLogin,
        ),
        WidgetWithAuthPageState(
          child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state is AuthenticationRegistrationError ||
                  state is AuthenticationLoginError) {
                showErrorDialog(context: context, message: state.message);
              }
            },
            builder: (context, state) {
              if (state is AuthenticationRegistrationLoading ||
                  state is AuthenticationLoginLoading) {
                return const Center(
                  child: SizedBox(
                    height: 45,
                    width: 45,
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return buttonAuthenticaion();
            },
          ),
          authState: AuthWidgetState.registerAndLogin,
        ),
        WidgetWithAuthPageState(
          child: BlocBuilder<AuthenticationPageCubit, AuthPageStateEntitiy>(
            builder: (context, state) {
              return WConElevatedButton(
                title: state.pageState == AuthenticationPageState.register
                    ? 'To Login'
                    : 'To Register',
                onPressed: () {
                  context.read<AuthenticationPageCubit>().onChangeState(
                        onBeforeChange: onClear,
                      );
                },
                isEnable: state is! AuthenticationRegistrationLoading ||
                    state is! AuthenticationLoginLoading,
              );
            },
          ),
          authState: AuthWidgetState.registerAndLogin,
        ),
      ];

  Widget buttonAuthenticaion() {
    return BlocBuilder<AuthenticationPageCubit, AuthPageStateEntitiy>(
      builder: (_, state) {
        return WConElevatedButton(
          title: state.pageState == AuthenticationPageState.register
              ? 'Regist'
              : 'Login',
          onPressed: () {
            context.read<AuthenticationPageCubit>().onPressed(
                  nameController.text,
                  usernameController.text,
                  passController.text,
                  emailController.text,
                  usernameOrEmailController.text,
                  context,
                  onAfterClick: onClear,
                );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Registration Page',
          // style: TextStyle(fontFamily: "PoppinsBlack", fontStyle: FontStyle.italic, decoration: TextDecoration.underline),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: BlocBuilder<AuthenticationPageCubit, AuthPageStateEntitiy>(
            builder: (context, state) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  final widget = listWidget[index];

                  // print('state.pageState : ${state.pageState}');
                  final asLoginWidget =
                      widget.authState == AuthWidgetState.login ||
                          widget.authState == AuthWidgetState.registerAndLogin;
                  if (state.pageState == AuthenticationPageState.login &&
                      asLoginWidget) {
                    return widget.child;
                  }

                  final asRegisWidget =
                      widget.authState == AuthWidgetState.register ||
                          widget.authState == AuthWidgetState.registerAndLogin;
                  if (state.pageState == AuthenticationPageState.register &&
                      asRegisWidget) {
                    return widget.child;
                  }

                  return Container();
                },
                separatorBuilder: (context, _) {
                  return const SizedBox(height: 8);
                },
                itemCount: listWidget.length,
              );
            },
          )),
    );
  }
}
