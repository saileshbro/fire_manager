// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:fire_manager/services/authentication_service.dart';
import 'package:fire_manager/services/firestore_service.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:fire_manager/ui/views/items/items_viewmodel.dart';
import 'package:fire_manager/ui/views/login/login_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:fire_manager/services/third_party_modules.dart';
import 'package:fire_manager/services/user_data_service.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt initLocatorSetup(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  final thirdPartyServicesModule = _$ThirdPartyServicesModule();
  gh.lazySingleton<DialogService>(() => thirdPartyServicesModule.dialogService);
  gh.lazySingleton<FirestoreService>(() => FirestoreService());
  gh.lazySingleton<LoginViewModel>(() => LoginViewModel());
  gh.lazySingleton<NavigationService>(
      () => thirdPartyServicesModule.navigationService);
  gh.lazySingleton<SnackbarService>(
      () => thirdPartyServicesModule.snackbarService);
  gh.lazySingleton<UserDataService>(() => UserDataService());
  gh.lazySingleton<AuthenticationService>(
      () => AuthenticationService(get<UserDataService>()));
  gh.factory<ItemViewModel>(() => ItemViewModel(
        get<FirestoreService>(),
        get<UserDataService>(),
        get<NavigationService>(),
      ));
  return get;
}

class _$ThirdPartyServicesModule extends ThirdPartyServicesModule {
  @override
  DialogService get dialogService => DialogService();
  @override
  NavigationService get navigationService => NavigationService();
  @override
  SnackbarService get snackbarService => SnackbarService();
}
