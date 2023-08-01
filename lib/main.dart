import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_fic_ecommerce_warung_comicon/core/result_handler/no_params.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/locator.dart';
import 'package:sizer/sizer.dart';

import 'core/register_bloc/register_bloc.dart';
// import 'feature/authentication/domain/entities/login_request_user.dart';
// import 'feature/authentication/domain/use_cases/login_user_cases.dart';
import 'feature/authentication/presentation/page/register_page.dart';
// import 'feature/product/domain/use_cases/get_product_remote.dart';
import 'feature/product/presentation/bloc/product_bloc.dart';
import 'feature/product/presentation/page/product_view.dart';


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
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Sizer(builder: (context, orientation, deviceType) {
          // return const MyHomePage(title: 'Flutter Demo Home Page');
          return const RegisterPage();
        }),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void _incrementCounter() {
    setState(() {
    });
  }

  Future<void> accessBloc() async {
    final accessBloc = context.read<ProductBloc>();
    accessBloc.loadProduct();

    final state = accessBloc.state;
    if (state is ProductStateError){
      debugPrint('Value By bloc (Error) : ${state.message}');
    }

    if (state is ProductStateLoaded){
      debugPrint('Value By bloc : ${state.listProduct.map((e) => e.productName).toList()}');
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // final requestLogin = getIt<LoginUserCases>();
      // const requestLoginValue = LoginRequestUser(usernameOrEmail: 'Ollie2@gmail.com', password: 'Ollie1872');
      // final getLoginCases = await requestLogin(requestLoginValue);
      // final isGetAccessLogin = getLoginCases.when<bool>(ok: (ok) {
      //   debugPrint('Value Result : ${ok.toString()}');
      //   return true;
      // }, err: (err) {
      //   debugPrint('Value Result Err: ${err.message}');
      //   return false;
      // });

      // getIt<VerifyUserTokenCases>())

      // final verifyTokenCases = getIt<VerifyUserTokenCases>();
      // final getVerify = await verifyTokenCases(NoParams());
      // final isGetVerify = getVerify.when<bool>(ok: (ok) {
      //   debugPrint('Value Result : ${ok.toString()}');
      //   return true;
      // }, err: (err) {
      //   debugPrint('Value Result Err: ${err.message}');
      //   return false;
      // });

      // if (!isGetAccessLogin) {
      //   return;
      // }

      // final getProduct = getIt<GetProductRemote>();
      // final getProductValue = await getProduct(NoParams());
      // getProductValue.when(ok: (ok) {
      //   debugPrint('Value Result : ${ok.toString()}');
      // }, err: (err) {
      //   debugPrint('Value Result Err: ${err.message}');
      // });

      // await accessBloc();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const ProductView(),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
