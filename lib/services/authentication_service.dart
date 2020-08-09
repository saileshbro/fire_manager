import 'package:fire_manager/services/user_data_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final UserDataService _userDataService;

  AuthenticationService(this._userDataService);
}
