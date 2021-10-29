import 'dart:convert';
import 'dart:io';

import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:migscourier/services/dialogs.dart';

class RevenueServices extends ChangeNotifier {

  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  final DialogsServices _dialogs = DialogsServices();

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  double amount;

  Future getRevenue(BuildContext context) async {
    final DateTime selectedStart = startDate;
    final String _startDate = "${selectedStart.year}-${selectedStart.month}-${selectedStart.day}";
    final DateTime selectedEnd = endDate.add(Duration(days: 1));
    final String _endDate = "${selectedEnd.year}-${selectedEnd.month}-${selectedEnd.day}";
    try {
      final Uri uri = Uri.parse("https://us-central1-migs-marketplace-app.cloudfunctions.net/riders/revenue?riderId=${_auth.currentUser.uid}&startDate=$_startDate&endDate=$_endDate");
      print("Calling Get Revenue API");
      final http.Response response = await http.get(uri);
      if (response.body.isNotEmpty) {
        if (response.statusCode == 200) {
          print("Response Body:\n${response.body.replaceAll("{", "{\n").replaceAll(",", ",\n").replaceAll("}", "\n}")}");
          amount = json.decode(response.body)["amount"].toDouble();
          notifyListeners();
        } else {
          print("Response Status Code: ${response.statusCode}");
          final String message = json.decode(response.body)["message"];
          _dialogs.showError(context, message);
        }
      }
    } on SocketException {
      print("No internet connection.");
      _dialogs.showOffline(context);
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final List<DateTime> pickedDate = await DateRangePicker.showDatePicker(
        context: context,
        initialFirstDate: startDate,
        initialLastDate: endDate,
        firstDate: DateTime(2020),
        lastDate: DateTime(2101));
    if (pickedDate != null) {
      startDate = pickedDate[0];
      endDate = pickedDate[1];
      getRevenue(context);
    }
    if (pickedDate == []) {

    }
    notifyListeners();
  }

}