import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:migscourier/models/user.dart';

class UserManager {

  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  // auth change user stream
  Stream<User> get user {
    return _auth.authStateChanges().map((user) {
      return user != null ? User(id: user.uid) : null;
    });
  }

}