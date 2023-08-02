import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/core/base_widget/wcon_loading_widget.dart';

import '../../../product/presentation/page/product_page.dart';
import '../bloc/authentication_bloc.dart';

class AuthLoadingOverlay extends StatefulWidget {
  final Widget authPage;
  const AuthLoadingOverlay({super.key, required this.authPage});

  @override
  State<AuthLoadingOverlay> createState() => _AuthLoadingOverlayState();
}

class _AuthLoadingOverlayState extends State<AuthLoadingOverlay> {
  late Stream<AuthenticationState> authStream;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        final authBloc = context.read<AuthenticationBloc>(); 
        authStream = context.read<AuthenticationBloc>().stream;
        authStream.listen(
          (state) {
            if (state is AuthenticationVerifyTokenComplete) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProductPage(),
                ),
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
