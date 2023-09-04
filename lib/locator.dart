import 'package:flutter_fic_ecommerce_warung_comicon/feature/authentication/data/repos/auth_repo_impl.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/authentication/domain/repos/auth_repo.dart';
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
import 'feature/checkout/data/data_source/checkout_order_remote_data_source.dart';
import 'feature/checkout/data/repos/checkout_order_repo_impl.dart';
import 'feature/checkout/domain/repos/checkout_order_repo.dart';
import 'feature/checkout/domain/use_cases/checkout_order_product.dart';
import 'feature/checkout/presentation/bloc/address_checkout/address_checkout_bloc.dart';
import 'feature/checkout/presentation/bloc/order_checkout/order_checkout_cubit.dart';
import 'feature/order_history/data/data_source/order_history_remote_data_source.dart';
import 'feature/order_history/data/repos/order_history_repo_impl.dart';
import 'feature/order_history/domain/repos/order_history_repo.dart';
import 'feature/order_history/domain/use_cases/get_order_history.dart';
import 'feature/order_history/presentation/bloc/order_history_bloc.dart';
import 'feature/product/data/data_source/product_remote_data_source.dart';
import 'feature/product/data/repos/product_repo_impl.dart';
import 'feature/product/domain/repos/product_repo.dart';
import 'feature/product/presentation/bloc/product_bloc.dart';
import 'feature/search/domain/use_cases/get_searched_product.dart';
import 'feature/search/presentation/bloc/search_product_bloc.dart';

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

  getIt.registerFactory<GetSearchedProduct>(
      () => GetSearchedProduct(getIt<ProductRepo>()));
  getIt.registerFactory<SearchProductBloc>(
      () => SearchProductBloc(getIt<GetSearchedProduct>()));

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
  getIt.registerSingleton<CheckoutOrderRemoteDataSource>(
      CheckoutOrderRemoteDataSourceImpl(http: getIt<InterceptedHttp>()));
  getIt.registerSingleton<CheckoutOrderRepo>(
      CheckoutOrderRepoImpl(getIt<CheckoutOrderRemoteDataSource>()));
  getIt.registerFactory<CheckoutOrderProduct>(
      () => CheckoutOrderProduct(getIt<CheckoutOrderRepo>()));
  getIt.registerFactoryParam<OrderCheckoutCubit, CartBloc?,
      AddressCheckoutBloc?>(
    (p1, p2) => OrderCheckoutCubit(getIt<CheckoutOrderProduct>(),
        cartBloc: p1, addressCheckoutBloc: p2),
  );

  // Address DataSource, Repo, and Use Cases
  getIt.registerSingleton<AddressRemoteDataSource>(
      AddressRemoteDataSourceImpl(http: getIt<InterceptedHttp>()));
  getIt.registerSingleton<AddressRepo>(
      AddressRepoImpl(getIt<AddressRemoteDataSource>()));
  getIt.registerFactory<GetListAddressUser>(
      () => GetListAddressUser(getIt<AddressRepo>()));
  getIt.registerFactory<AddressCheckoutBloc>(
      () => AddressCheckoutBloc(getIt<GetListAddressUser>()));

  // History Order DataSource, Repo, and Use Cases
  getIt.registerSingleton<OrderHistoryRemoteDataSource>(
      OrderHistoryRemoteDataSourceImpl(http: getIt<InterceptedHttp>()));
  getIt.registerSingleton<OrderHistoryRepo>(
      OrderHistoryRepoImpl(getIt<OrderHistoryRemoteDataSource>()));
  getIt.registerFactory<GetOrderHistory>(
      () => GetOrderHistory(getIt<OrderHistoryRepo>()));
  getIt.registerFactory<OrderHistoryBloc>(
      () => OrderHistoryBloc(getIt<GetOrderHistory>()));
}
