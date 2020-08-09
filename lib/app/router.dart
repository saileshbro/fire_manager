import 'package:auto_route/auto_route_annotations.dart';
import 'package:fire_manager/ui/views/items/add_item_view.dart';
import 'package:fire_manager/ui/views/items/edit_item_view.dart';
import 'package:fire_manager/ui/views/items/items_view.dart';
import 'package:fire_manager/ui/views/login/login_view.dart';
import 'package:fire_manager/ui/views/profile/profile_view.dart';

@MaterialAutoRouter(routes: [
  AutoRoute(page: ItemsView, initial: true),
  AutoRoute(page: LoginView),
  AutoRoute(page: ProfileView),
  AutoRoute(page: AddItemView),
  AutoRoute(page: EditItemView),
])
class $Router {}
