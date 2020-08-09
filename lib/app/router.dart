import 'package:auto_route/auto_route_annotations.dart';
import 'package:fire_manager/ui/views/items/items_view.dart';
import 'package:fire_manager/ui/views/login/login_view.dart';

@MaterialAutoRouter(routes: [
  AutoRoute(page: ItemsView, initial: true),
  AutoRoute(page: LoginView),
])
class $Router {}
