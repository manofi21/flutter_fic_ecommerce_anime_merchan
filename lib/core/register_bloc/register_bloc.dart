import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/order/presentation/cubit/order_cubit.dart';

import '../../feature/authentication/presentation/bloc/authentication_bloc.dart';
import '../../feature/authentication/presentation/page_state_cubit/authentication_page_cubit.dart';
import '../../feature/cart/presentation/bloc/cart_bloc.dart';
import '../../feature/checkout/presentation/bloc/address_checkout_bloc.dart';
import '../../feature/product/presentation/bloc/product_bloc.dart';
import '../../locator.dart';

final registerBloc = [
  BlocProvider<ProductBloc>(
    create: (context) => getIt<ProductBloc>(),
  ),
  BlocProvider<AuthenticationBloc>(create: (_) => getIt<AuthenticationBloc>()),
  BlocProvider<AuthenticationPageCubit>(
    create: (context) => AuthenticationPageCubit(
      authBloc: context.read<AuthenticationBloc>(),
    ),
  ),
  BlocProvider<CartBloc>(create: (_) => CartBloc()),
  BlocProvider<OrderCubit>(
    create: (context) => getIt<OrderCubit>(
      // param1: null,
      param2: context.read<CartBloc>(),
    ),
  ),
  BlocProvider<AddressCheckoutBloc>(create: (_) => getIt<AddressCheckoutBloc>())
];
