import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:migscourier/models/rider.dart';
import 'package:migscourier/services/dialogs.dart';
import 'package:migscourier/services/network/user.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

class AuthServices extends ChangeNotifier {

  AuthServices({this.packageInfo});

  final PackageInfo packageInfo;

  //Declare Firebase Instances
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  final DialogsServices _dialogs = DialogsServices();

  //Initiate Variables
  final TextEditingController phone = TextEditingController();
  final TextEditingController password = TextEditingController();

  bool showSpinner = false;
  UserData userData;

  clearControllers() {
    phone.clear();
    password.clear();
  }

  startSpinner() {
    showSpinner = true;
    notifyListeners();
  }

  stopSpinner() {
    showSpinner = false;
    notifyListeners();
  }

  /// LOGIN
  logIn (BuildContext context) async {
    final UserDataServices user = Provider.of<UserDataServices>(context, listen: false);
    try {
      startSpinner();
      /// SIGN IN WITH FIREBASE AUTH
      await _auth.signInWithEmailAndPassword(
        email: "${phone.text}@email.com",
        password: password.text,
      );
      /// CHECK USER TYPE BEFORE LOGIN
      final String userType = await user.getType();
      if (userType == "rider") {
        stopSpinner();
        user.getData();
        clearControllers();
        return Navigator.of(context).popUntil((route) => route.isFirst);
      } else {
        stopSpinner();
        unauthorizedSignOut();
        clearControllers();
        return _dialogs.showError(context, "Unauthorized access.\nSorry you don't have access to this application.");
      }
    } on auth.FirebaseAuthException catch (e) {
      stopSpinner();
      clearControllers();
      if(e.code == "user-not-found") {
        return _dialogs.showError(context, "User not found. Please try again.");
      } else if (e.code == "wrong-password") {
        return _dialogs.showError(context, "Incorrect Credentials. Please try again.");
      }
    }
  }

  /// UPDATE USER PHONE NUMBER
  Future<void> updateUserPhone(BuildContext context, String updatedPhoneNumber) async {
    startSpinner();
    try {
      final Uri uri = Uri.parse("https://us-central1-migs-marketplace-app.cloudfunctions.net/riders/update/phone?riderId=${_auth.currentUser.uid}&phone=$updatedPhoneNumber");
      print("Calling Update Phone API for User: ${_auth.currentUser.uid}");
      final http.Response response = await http.put(uri,
        headers: <String, String> {
          "Content-Type": "application/json",
        },
      );
      if (response.body.isNotEmpty) {
        final String message = json.decode(response.body)["message"];
        if (response.statusCode == 200) {
          stopSpinner();
          print("Http response message: $message");
        } else {
          stopSpinner();
          _dialogs.showError(context, message);
        }
      }
    } on SocketException {
      stopSpinner();
      _dialogs.showOffline(context);
    }
  }

  unauthorizedSignOut() async {
    _auth.signOut();
    notifyListeners();
  }

  /// SIGN OUT
  Future signOut(context) async {
    try {
      _dialogs.showCustom(
        context: context,
        title: "Log Out",
        content: "Are you sure you want to log out?",
        enableSecondaryButton: true,
        mainButtonTitle: "Log out",
        secondaryButtonTitle: "Cancel",
        mainButtonOnPressed: () async {
          Navigator.of(context).pop();
          await _auth.signOut();
          notifyListeners();
        }
      );
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

}