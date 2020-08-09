import 'package:fire_manager/app/router.gr.dart';
import 'package:fire_manager/app/setup_snackbar.dart';
import 'package:fire_manager/datamodels/item_model.dart';
import 'package:fire_manager/services/authentication_service.dart';
import 'package:fire_manager/services/firestore_service.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

@lazySingleton
class ItemViewModel extends BaseViewModel {
  final FirestoreService _firestoreService;
  final AuthenticationService _authenticationService;
  final DialogService _dialogService;
  final NavigationService _navigationService;
  final SnackbarService _snackbarService;
  List<ItemModel> _items;
  ItemViewModel(this._firestoreService, this._navigationService,
      this._authenticationService, this._snackbarService, this._dialogService) {
    _firestoreService.items.listen(_onItemsAdded);
    _authenticationService.user.listen((event) {
      notifyListeners();
    });
  }
  bool get isLoggedIn => _authenticationService.isLoggedin;
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
    final list = ["#", ...items[0].toMap().keys.toList()];
    if (isLoggedIn) {
      list.add("Edit");
    }
    return list;
  }

  void goToLogin() {
    _navigationService.navigateTo(Routes.loginView);
  }

  void profilePressed() {
    if (!isLoggedIn) {
      goToLogin();
    } else {
      goToProfile();
    }
  }

  void onAddPressed() {
    _navigationService.navigateTo(Routes.addItemView);
  }

  void goToProfile() {
    _navigationService.navigateTo(Routes.profileView);
  }

  Future<bool> addItem(
      {@required String name,
      @required String company,
      @required String rate,
      @required String tag,
      @required String partNo}) async {
    setBusy(true);
    try {
      await _firestoreService.addItem(
        model: ItemModel(
          company: company,
          rate: rate,
          tag: tag,
          name: name,
          partNo: partNo,
        ),
      );
      _snackbarService.showCustomSnackBar(
        variant: SnackbarType.success,
        title: "Success",
        message: "Successfully added!",
        duration: const Duration(seconds: 2),
      );
      setBusy(false);
      return true;
    } catch (e) {
      setBusy(false);
      _snackbarService.showCustomSnackBar(
        variant: SnackbarType.error,
        title: "Error",
        message: "Unexpected Error!",
        duration: const Duration(seconds: 2),
      );
      throw false;
    }
  }

  Future<bool> editItem({
    @required String name,
    @required String company,
    @required String rate,
    @required String tag,
    @required String id,
    @required String partNo,
  }) async {
    setBusy(true);
    try {
      await _firestoreService.editItem(
        id: id,
        model: ItemModel(
          company: company,
          rate: rate,
          tag: tag,
          name: name,
          partNo: partNo,
        ),
      );
      _snackbarService.showCustomSnackBar(
        variant: SnackbarType.success,
        title: "Success",
        message: "Successfully edited!",
        duration: const Duration(seconds: 2),
      );
      setBusy(false);
      return true;
    } catch (e) {
      setBusy(false);
      _snackbarService.showCustomSnackBar(
        variant: SnackbarType.error,
        title: "Error",
        message: "Unexpected Error!",
        duration: const Duration(seconds: 2),
      );
      throw false;
    }
  }

  void onEditPressed(ItemModel item) {
    _navigationService.navigateTo(Routes.editItemView,
        arguments: EditItemViewArguments(itemModel: item));
  }

  Future<void> onDeletePressed(ItemModel model) async {
    final DialogResponse response = await _dialogService.showConfirmationDialog(
      confirmationTitle: "Delete",
      description: "Are you sure you want to delete?",
      title: "Delete Item",
    );
    if (response.confirmed) {
      deleteItem(model);
      _navigationService.back();
    }
  }

  Future deleteItem(ItemModel model) async {
    await _firestoreService.deleteItem(model.id);
  }
}
