import 'package:flutter_fic_ecommerce_warung_comicon/feature/authentication/data/repos/auth_repo_impl.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/authentication/domain/repos/auth_repo.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/order/data/repos/order_repo_impl.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/product/domain/use_cases/get_product_remote.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http_interceptor/http_interceptor.dart';

import 'core/http_request/http_request_interceptor.dart';
import 'feature/address/data/data_source/address_remote_data_source.dart';
import 'feature/address/data/repos/address_repo_impl.dart';
import 'feature/address/domain/repos/address_repo.dart';
import 'feature/address/domain/use_cases/get_list_address_user.dart';
import 'feature/authentication/data/data_source/auth_local_data_source.dart';
import 'feature/authentication/data/data_source/auth_remote_data_source.dart';
import 'feature/authentication/domain/use_cases/login_user_cases.dart';
import 'feature/authentication/domain/use_cases/registration_user_cases.dart';
import 'feature/authentication/domain/use_cases/verify_user_token_cases.dart';
import 'feature/authentication/presentation/bloc/authentication_bloc.dart';
import 'feature/cart/presentation/bloc/cart_bloc.dart';
import 'feature/checkout/presentation/bloc/address_checkout_bloc.dart';
import 'feature/order/data/data_source/order_remote_data_source.dart';
import 'feature/order/domain/repos/order_repo.dart';
import 'feature/order/domain/use_cases/checkout_order_product.dart';
import 'feature/order/presentation/cubit/order_cubit.dart';
import 'feature/product/data/data_source/product_remote_data_source.dart';
import 'feature/product/data/repos/product_repo_impl.dart';
import 'feature/product/domain/repos/product_repo.dart';
import 'feature/product/presentation/bloc/product_bloc.dart';

final getIt = GetIt.I;
void configureDependencies() {
  // Registering FlutterSecureStorage
  getIt.registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage());

  // Registering AuthLocalDataSource (changed to AuthStorage)
  getIt.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSource(getIt<FlutterSecureStorage>()));

  getIt.registerFactory<InterceptedHttp>(
      () => InterceptedHttp.build(interceptors: [
            HttpRequestInterceptor(getIt<AuthLocalDataSource>()),
          ]));

  // Registering HTTP request (Removed because been declare as abstract class)
  // getIt.registerLazySingleton<RemoteDataRequest>(() => RemoteDataRequest(getIt<InterceptedHttp>()));

  // Registring Product DataSource, Repo, and Use Cases
  getIt.registerSingleton<ProductRemoteDataSource>(
      ProductRemoteDataSourceImpl(http: getIt<InterceptedHttp>()));
  getIt.registerSingleton<ProductRepo>(
      ProductRepoImpl(getIt<ProductRemoteDataSource>()));
  getIt.registerFactory<GetProductRemote>(
      () => GetProductRemote(getIt<ProductRepo>()));
  getIt.registerFactory<ProductBloc>(
      () => ProductBloc(getIt<GetProductRemote>()));

  // Registring Auth DataSource, Repo, and Use Cases
  getIt.registerSingleton<AuthRemoteDataSource>(
      AuthRemoteDataSourceImpl(http: getIt<InterceptedHttp>()));
  getIt.registerSingleton<AuthRepo>(AuthRepoImpl(
      getIt<AuthRemoteDataSource>(), getIt<AuthLocalDataSource>()));
  getIt
      .registerFactory<LoginUserCases>(() => LoginUserCases(getIt<AuthRepo>()));
  getIt.registerFactory<VerifyUserTokenCases>(
      () => VerifyUserTokenCases(getIt<AuthRepo>()));
  getIt.registerFactory<RegistrationUserCases>(
      () => RegistrationUserCases(getIt<AuthRepo>()));
  getIt.registerFactory<AuthenticationBloc>(() => AuthenticationBloc(
      getIt<VerifyUserTokenCases>(),
      getIt<RegistrationUserCases>(),
      getIt<LoginUserCases>()));

  // Order DataSource, Repo, and Use Cases
  getIt.registerSingleton<OrderRemoteDataSource>(
      OrderRemoteDataSourceImpl(http: getIt<InterceptedHttp>()));
  getIt.registerSingleton<OrderRepo>(
      OrderRepoImpl(getIt<OrderRemoteDataSource>()));
  getIt.registerFactory<CheckoutOrderProduct>(
      () => CheckoutOrderProduct(getIt<OrderRepo>()));
  getIt.registerFactoryParam<OrderCubit, CheckoutOrderProduct?, CartBloc>(
    (p1, p2) => OrderCubit(
      p1 ?? getIt<CheckoutOrderProduct>(),
      cartBloc: p2,
    ),
  );

  // Address DataSource, Repo, and Use Cases
  getIt.registerSingleton<AddressRemoteDataSource>(
      AddressRemoteDataSourceImpl(http: getIt<InterceptedHttp>()));
  getIt.registerSingleton<AddressRepo>(
      AddressRepoImpl(getIt<AddressRemoteDataSource>()));
  getIt.registerFactory<GetListAddressUser>(
      () => GetListAddressUser(getIt<AddressRepo>()));
  getIt.registerFactory<AddressCheckoutBloc>(() => AddressCheckoutBloc(getIt<GetListAddressUser>()));
}
