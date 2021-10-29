import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:migscourier/models/item.dart';
import 'package:migscourier/models/order.dart';
import 'package:migscourier/models/status.dart';
import 'package:migscourier/services/dialogs.dart';

class OrdersServices extends ChangeNotifier {

  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  final DialogsServices _dialogs = DialogsServices();

  bool showSpinner = false;

  setSpinner(bool value) {
    showSpinner = value;
    notifyListeners();
  }

  Future<List<Item>> getItems(BuildContext context, String orderId) async {
    try {
      final Uri uri = Uri.parse("https://us-central1-migs-marketplace-app.cloudfunctions.net/riders/order/items/$orderId");

      print("Calling Get Order Items API for Order: $orderId");
      final http.Response response = await http.get(uri);

      if(response.body.isNotEmpty) {
        if (response.statusCode == 200) {
          print("Order Items retrieved.");
          final List<Item> orderItems = (json.decode(response.body)["items"] as List).map((item) => Item.fromJson(item)).toList();
          return orderItems;
        } else {
          print("Response Status Code: ${response.statusCode}");
          return _dialogs.showError(context, "Cannot process transaction at this time");
        }
      } else {
        return null;
      }
    } on SocketException {
      print("No internet connection.");
      Navigator.of(context).pop();
      return _dialogs.showOffline(context);
    }
  }

  Future<void> acceptOrder(BuildContext context, Order order) async {
    setSpinner(true);
    try {
      final DateTime messageDate = DateTime.now();
      final String messageId = 'message-${messageDate.toString().replaceAll(':', '-').replaceAll(' ', '-')}';
      final Uri uri = Uri.parse("https://us-central1-migs-marketplace-app.cloudfunctions.net/riders/orders/accept");

      print("Calling Accept Order API for Order ID: ${order.id}");
      final http.Response response = await http.post(uri,
        headers: <String, String> {
          "Content-Type": "application/json",
        },
        body: jsonEncode(<String, dynamic>{
          "riderId": _auth.currentUser.uid,
          "orderId": order.id,
          "customerId": order.customerId,
          "customerName": order.customerName,
          "customerPhone": order.customerPhone,
          "customerAddress": order.customerAddress,
          "customerCity": order.city,
          "total": order.total,
          "serviceFee": order.serviceFee,
          "pickedUp": order.pickedUp,
          "messageId": messageId,
          "messageDate": messageDate,
        }),
      );

      if (response.body.isNotEmpty) {
        if (response.statusCode == 200) {
          setSpinner(false);
          Navigator.of(context).popUntil((route) => route.isFirst);
        } else {
          setSpinner(false);
          Navigator.of(context).pop();
          final String message = json.decode(response.body)["message"];
          _dialogs.showError(context, message);
        }
      }
    } on SocketException {
      setSpinner(false);
      print("No internet connection.");
      Navigator.of(context).pop();
      _dialogs.showOffline(context);
    }
  }

  Future<void> pickUpOrder(BuildContext context, Status order) async {
    setSpinner(true);
    try {
      final DateTime messageDate = DateTime.now();
      final String messageId = 'message-${messageDate.toString().replaceAll(':', '-').replaceAll(' ', '-')}';
      final Uri uri = Uri.parse("https://us-central1-migs-marketplace-app.cloudfunctions.net/riders/orders/pickup");
      print("Calling Pick Up Order API for Order ID: ${order.orderId}");
      final http.Response response = await http.post(uri,
        headers: <String, String> {
          "Content-Type": "application/json",
        },
        body: jsonEncode(<String, dynamic> {
          "riderId": _auth.currentUser.uid,
          "orderId": order.orderId,
          "customerId": order.customerId,
          "messageId": messageId,
          "messageDate": messageDate,
        }),
      );

      if (response.body.isNotEmpty) {
        if (response.statusCode == 200) {
          setSpinner(false);
          Navigator.of(context).pop();
        } else {
          setSpinner(false);
          Navigator.of(context).pop();
          final String message = json.decode(response.body)["message"];
          _dialogs.showError(context, message);
        }
      }
    } on SocketException {
      setSpinner(false);
      print("No internet connection.");
      Navigator.of(context).pop();
      _dialogs.showOffline(context);
    }

  }

  Future<void> confirmOrderDelivered(BuildContext context, Status order) async {
    setSpinner(true);
    DateTime currentDate = DateTime.now();
    String messageId = 'message-${currentDate.toString().replaceAll(':', '-').replaceAll(' ', '-')}';
    String revenueId = 'revenue-${currentDate.toString().replaceAll(':', '-').replaceAll(' ', '-')}';

    try {
      final Uri uri = Uri.parse("https://us-central1-migs-marketplace-app.cloudfunctions.net/riders/orders/deliver");
      print("Calling Deliver Order API for Order: ${order.orderId}");
      final http.Response response = await http.post(uri,
        headers: <String, String> {
          "Content-Type": "application/json",
        },
        body: jsonEncode(<String, dynamic> {
          "orderId": order.orderId,
          "riderId": _auth.currentUser.uid,
          "customerId": order.customerId,
          "revenueId": revenueId,
          "messageId": messageId,
          "currentDate": currentDate,
          "serviceFee": order.serviceFee,
        }),
      );
      if (response.body.isNotEmpty) {
        final String message = json.decode(response.body)["message"];
        if (response.statusCode == 200) {
          setSpinner(false);
          print("Return message: $message");
          _dialogs.showCustom(
            context: context,
            title: 'Order Complete!',
            content: 'This order has been completed. Great job!',
            enableSecondaryButton: false,
            mainButtonTitle: 'Okay',
            mainButtonOnPressed: () {
              Navigator.of(context).pop();
            },
          );
        } else {
          setSpinner(false);
          print("Response Status Code: ${response.statusCode}");
          _dialogs.showError(context, message);
        }
      }
    } on SocketException {
      setSpinner(false);
      _dialogs.showOffline(context);
    }
  }

}