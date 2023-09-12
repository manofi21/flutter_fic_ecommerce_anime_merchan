import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/core/base_widget/wcon_loading_widget.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/core/show_dialog/show_confirm_dialog.dart';

import '../../../../core/show_dialog/show_error_dialog.dart';
import '../../../home/presentation/page/home_page.dart';
// import '../../../product/presentation/page/product_page.dart';
import '../bloc/authentication_bloc.dart';

class AuthLoadingOverlay extends StatefulWidget {
  final Widget authPage;
  const AuthLoadingOverlay({super.key, required this.authPage});

  @override
  State<AuthLoadingOverlay> createState() => _AuthLoadingOverlayState();
}

class _AuthLoadingOverlayState extends State<AuthLoadingOverlay> {
  late StreamSubscription<AuthenticationState> authStream;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        if (!mounted) return;

        final authBloc = context.read<AuthenticationBloc>();
        authStream = authBloc.stream.listen(
          (state) async {
            if (state is AuthenticationVerifyTokenComplete) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const HomePage(),
                ),
              );
              return;
            }

            if (state is AuthenticationNoTokenSaved) {
              if (mounted) {
                await showConfirmDialog(
                  context: context,
                  message:
                      "Silahkan Melakukan Login/Registrasi terlebih dahulu",
                  trueFalseOption: false,
                  ok: () {
                    authStream.cancel();
                  },
                );
              }

              return;
            }

            if (state is AuthenticationVerifyTokenError) {
              await showErrorDialog(
                context: context,
                message: state.message,
              );
            }
          },
        );

        authBloc.add(const OnVerifyTokenEvent());
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) => WConLodingWidget(
        title: 'Memeriksa Token...',
        show: state is AuthenticationVerifyTokenLoading,
        child: widget.authPage,
      ),
    );
  }
}
