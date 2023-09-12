import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/show_dialog/show_error_dialog.dart';
import '../bloc/logout_cubit/logout_cubit.dart';
import '../page/auth_page.dart';
import 'auth_loading_overlay.dart';

class ButtonLogOut extends StatelessWidget {
  const ButtonLogOut({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogoutCubit, LogoutState>(
      listener: (context, state) {
        if (state.isSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const AuthLoadingOverlay(
                authPage: AuthPage(),
              ),
            ),
          );
        }

        if (state.isError) {
          showErrorDialog(
            context: context,
            message: state.msgError,
          );
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const SizedBox(
              height: 25,
              width: 25,
              child: Center(
                child: CircularProgressIndicator(),
              ));
        }

        return InkWell(
          onTap: () {
            context.read<LogoutCubit>().onLogout();
            // Navigator.pop(context);
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(
            //     builder: (_) => const AuthPage(),
            //   ),
            // );
          },
          child: const Icon(Icons.logout_sharp),
        );
      },
    );
  }
}
