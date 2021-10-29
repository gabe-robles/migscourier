import 'package:migscourier/components/cards/order.dart';
import 'package:migscourier/constants.dart';
import 'package:flutter/material.dart';
import 'package:migscourier/models/order.dart';
import 'package:migscourier/screens/order/details.dart';
import 'package:migscourier/managers/firestore.dart';
import 'package:migscourier/services/navigation.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {

  final NavigationServices _nav = NavigationServices();

  @override
  Widget build(BuildContext context) {

    final _ordersStream = Provider.of<FirestoreManager>(context).ordersFromFirebase;

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text('Orders', style: kH3),
        ),
        brightness: Brightness.dark,
      ),
      body: StreamBuilder<List<Order>>(
        stream: _ordersStream,
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

          List<Order> orders = snapshot.data;

          return orders.length > 0 ? ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                child: OrderCard(order: orders[index]),
                onTap: () {
                  Navigator.of(context).push(_nav.createRoute(OrderDetailsScreen(order: orders[index])));
                },
              );
            },
          ) : Center(
            child: Text('There are no orders\nat this moment.', textAlign: TextAlign.center),
          );
        },
      ),
    );
  }
}
