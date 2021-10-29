import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:migscourier/models/rider.dart';

class UserDataServices extends ChangeNotifier {

  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  UserData data;

  /// GET USER TYPE
  Future<String> getType() async {

    final String userId = _auth.currentUser.uid;

    try {
      final Uri uri = Uri.parse("https://us-central1-migs-marketplace-app.cloudfunctions.net/general/user-type?userId=$userId");

      print("Calling Rider: User Type API for $userId");
      final http.Response response = await http.get(uri);

      if (response.body.isNotEmpty) {
        if (response.statusCode == 200) {
          final String userType = json.decode(response.body)["userType"];
          print("User type retrieved: $userType");
          return userType;
        } else {
          print("Response Status Code: ${response.statusCode}");
          return "";
        }
      } else {
        return "";
      }
    } on SocketException {
      print("No internet connection");
      return "";
    }

  }

  /// GET USER DATA
  Future<UserData> getData() async {

    final String userId = _auth.currentUser.uid;

    try {
      final Uri uri = Uri.parse("https://us-central1-migs-marketplace-app.cloudfunctions.net/riders/data?riderId=$userId");

      print("Calling Rider: User Data API for $userId");
      final http.Response response = await http.get(uri);

      if (response.body.isNotEmpty) {
        if (response.statusCode == 200) {
          data = UserData.fromJson(json.decode(response.body));
          notifyListeners();
          print("Rider data retrieved for ${data.name}");
          return data;
        } else {
          print("Response Status Code: ${response.statusCode}");
          return null;
        }
      } else {
        return null;
      }
    } on SocketException {
      print("No internet connection");
      return null;
    }

  }



}