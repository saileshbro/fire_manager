import 'package:fire_manager/app/locator.dart';
import 'package:fire_manager/app/router.gr.dart';
import 'package:fire_manager/datamodels/item_model.dart';
import 'package:fire_manager/services/firestore_service.dart';
import 'package:fire_manager/services/user_data_service.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

@injectable
class ItemViewModel extends BaseViewModel {
  final FirestoreService _firestoreService;
  final UserDataService _userDataService;
  final NavigationService _navigationService;
  List<ItemModel> _items;
  ItemViewModel(
      this._firestoreService, this._userDataService, this._navigationService) {
    _firestoreService.items.listen(_onItemsAdded);
  }
  bool get isLoggedIn => _userDataService.isLoggedin;
  List<ItemModel> get items => _items;
  void _onItemsAdded(List<ItemModel> items) {
    _items = items;
    if (_items == null) {
      setBusy(true);
    } else {
      if (_items.isEmpty) {
        setError("No Items available");
      } else {
        clearErrors();
        setBusy(false);
      }
    }
  }

  void onFloatingActionButtonPressed() {}

  List<String> getColumns() {
    return ["#", ...items[0].toVisibleMap().keys.toList()];
  }

  void goToLogin() {
    _navigationService.navigateTo(Routes.loginView);
  }

  void profilePressed() {
    if (!isLoggedIn) {
      goToLogin();
    }
  }

  void logoutPressed() {}
}
