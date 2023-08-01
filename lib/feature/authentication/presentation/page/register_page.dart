import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/core/base_widget/wcon_text_field.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/core/show_dialog/show_error_dialog.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/product/presentation/page/product_view.dart';

import '../../../../core/base_widget/wcon_elevated_button.dart';
import '../bloc/authentication_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final TextEditingController emailController;
  late final TextEditingController passController;
  late final TextEditingController usernameController;
  late final TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    usernameController = TextEditingController();
    emailController = TextEditingController();
    passController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  List<Widget> get listWidget => [
        WConTextField(
          usePrefix: true,
          prefixIcon: Icons.people,
          labelText: 'Name',
          controller: nameController,
        ),
        WConTextField(
          usePrefix: true,
          prefixIcon: Icons.account_box,
          labelText: 'Username',
          controller: usernameController,
        ),
        WConTextField(
          usePrefix: true,
          prefixIcon: Icons.email_rounded,
          labelText: 'Email',
          controller: emailController,
        ),
        WConTextField(
          usePrefix: true,
          prefixIcon: Icons.password_rounded,
          labelText: 'Password',
          controller: passController,
          obscure: true,
        ),
        BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationRegistrationError) {
              showErrorDialog(context: context, message: state.message);
            }
          },
          builder: (context, state) {
            if (state is AuthenticationRegistrationLoading) {
              return const Center(
                child: SizedBox(
                  height: 45,
                  width: 45,
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return WConElevatedButton(
              title: 'Registing',
              onPressed: () {
                context.read<AuthenticationBloc>().onRegisting(
                      name: nameController.text,
                      username: usernameController.text,
                      email: emailController.text,
                      password: passController.text,
                      onSuccess: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ProductView(),
                          ),
                        );
                      },
                    );
              },
            );
          },
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ListView.separated(
          itemBuilder: (context, index) {
            return listWidget[index];
          },
          separatorBuilder: (context, _) {
            return const SizedBox(height: 8);
          },
          itemCount: listWidget.length,
        ),
      ),
    );
  }
}
