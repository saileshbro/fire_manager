import 'package:injectable/injectable.dart';

@lazySingleton
class UserDataService {
  String _token;
  String _name;
  // ignore: unused_field
  bool _isLoggedIn;

  String get token => _token;
  String get name => _name;

  bool get isLoggedin => _isLoggedIn ?? false;
}
