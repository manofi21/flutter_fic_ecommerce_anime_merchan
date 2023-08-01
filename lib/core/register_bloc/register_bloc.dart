import 'package:flutter_bloc/flutter_bloc.dart';

import '../../feature/authentication/presentation/bloc/authentication_bloc.dart';
import '../../feature/product/presentation/bloc/product_bloc.dart';
import '../../locator.dart';

final registerBloc = [
  BlocProvider<ProductBloc>(create: (_)=> getIt<ProductBloc>()),
  BlocProvider<AuthenticationBloc>(create: (_) => getIt<AuthenticationBloc>())
];