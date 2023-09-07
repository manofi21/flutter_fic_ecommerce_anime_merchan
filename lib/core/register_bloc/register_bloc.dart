import 'package:flutter_bloc/flutter_bloc.dart';

import '../../feature/address/presentation/cubit/choosed_address/choosed_address_cubit.dart';
import '../../feature/authentication/presentation/bloc/authentication_bloc.dart';
import '../../feature/authentication/presentation/page_state_cubit/authentication_page_cubit.dart';
import '../../feature/cart/presentation/bloc/cart_bloc.dart';
import '../../feature/checkout/presentation/bloc/address_checkout/address_checkout_bloc.dart';
import '../../feature/checkout/presentation/bloc/order_checkout/order_checkout_cubit.dart';
import '../../feature/order_history/presentation/bloc/order_history_bloc.dart';
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
  BlocProvider<AddressCheckoutBloc>(
      create: (_) => getIt<AddressCheckoutBloc>()),
  BlocProvider<OrderCheckoutCubit>(
    create: (context) => getIt<OrderCheckoutCubit>(
      param1: context.read<CartBloc>(),
      param2: context.read<AddressCheckoutBloc>(),
    ),
  ),
  BlocProvider<OrderHistoryBloc>(create: (_) => getIt<OrderHistoryBloc>()),
  BlocProvider<ChoosedAddressCubit>(create: (_) => getIt<ChoosedAddressCubit>())
];
