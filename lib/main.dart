import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/authentication/presentation/widget/auth_loading_overlay.dart';
// import 'package:flutter_fic_ecommerce_warung_comicon/core/result_handler/no_params.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/locator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sizer/sizer.dart';

import 'core/navigator/navigator.dart';
import 'core/register_bloc/register_bloc.dart';
// import 'feature/authentication/domain/entities/login_request_user.dart';
// import 'feature/authentication/domain/use_cases/login_user_cases.dart';
import 'feature/authentication/presentation/page/auth_page.dart';
// import 'feature/product/domain/use_cases/get_product_remote.dart';
// import 'feature/product/presentation/bloc/product_bloc.dart';
// import 'feature/product/presentation/page/product_page.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: registerBloc,
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        home: Sizer(builder: (context, orientation, deviceType) {
          // return const MyHomePage(title: 'Flutter Demo Home Page');
          return const AuthLoadingOverlay(
            authPage: AuthPage(),
          );
        }),
      ),
    );
  }
}
