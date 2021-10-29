import 'package:flutter/material.dart';
import 'package:migscourier/models/status.dart';
import 'package:migscourier/screens/order/current.dart';
import 'package:migscourier/screens/order/orders.dart';
import 'package:migscourier/managers/firestore.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final riderStatusStream = Provider.of<FirestoreManager>(context).riderStatus;

    return StreamBuilder<Status>(
      stream: riderStatusStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('An unexpected error occurred.'),
          );
        }

        if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        Status status = snapshot.data;

        return status.currentlyDelivering == false ? OrdersScreen() : CurrentOrderScreen(order: status);
      },
    );
  }
}
