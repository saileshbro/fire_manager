// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../datamodels/item_model.dart';
import '../ui/views/items/add_item_view.dart';
import '../ui/views/items/edit_item_view.dart';
import '../ui/views/items/items_view.dart';
import '../ui/views/login/login_view.dart';
import '../ui/views/profile/profile_view.dart';

class Routes {
  static const String itemsView = '/';
  static const String loginView = '/login-view';
  static const String profileView = '/profile-view';
  static const String addItemView = '/add-item-view';
  static const String editItemView = '/edit-item-view';
  static const all = <String>{
    itemsView,
    loginView,
    profileView,
    addItemView,
    editItemView,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.itemsView, page: ItemsView),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.profileView, page: ProfileView),
    RouteDef(Routes.addItemView, page: AddItemView),
    RouteDef(Routes.editItemView, page: EditItemView),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    ItemsView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ItemsView(),
        settings: data,
      );
    },
    LoginView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginView(),
        settings: data,
      );
    },
    ProfileView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ProfileView(),
        settings: data,
      );
    },
    AddItemView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => AddItemView(),
        settings: data,
      );
    },
    EditItemView: (data) {
      final args = data.getArgs<EditItemViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => EditItemView(
          key: args.key,
          itemModel: args.itemModel,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// EditItemView arguments holder class
class EditItemViewArguments {
  final Key key;
  final ItemModel itemModel;
  EditItemViewArguments({this.key, @required this.itemModel});
}
