import 'package:migscourier/components/cards/item.dart';
import 'package:migscourier/components/modals/custom.dart';
import 'package:migscourier/constants.dart';
import 'package:flutter/material.dart';
import 'package:migscourier/models/item.dart';
import 'package:migscourier/models/order.dart';
import 'package:migscourier/services/network/orders.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class OrderDetailsScreen extends StatefulWidget {

  const OrderDetailsScreen({
    this.order,
  });

  final Order order;

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {

  Future orderItemsFuture;

  final OrdersServices _ordersServices = OrdersServices();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getOrderItems();
    });
  }

  getOrderItems() {
    setState(() {
      orderItemsFuture = _ordersServices.getItems(context, widget.order.id);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<OrdersServices>(
      builder: (context, orderService, _) {
        return ModalProgressHUD(
          inAsyncCall: orderService.showSpinner,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Order Details'),
            ),
            body: Container(
              width: MediaQuery.of(context).size.width,
              child: ListView(
                children: <Widget>[
                  //List of Order Details Grouped as Column
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(widget.order.customerName, style: kH3),
                        Text(widget.order.customerPhone),
                        Text(widget.order.customerAddress + ', ' + widget.order.city),
                        SizedBox(height: 10)
                      ],
                    ),
                  ),

                  //List of Orders
                  FutureBuilder<List<Item>>(
                    future: orderItemsFuture,
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

                      List<Item> items = snapshot.data;

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: items.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ItemCard(
                            item: items[index],
                          );
                        },
                      );
                    }
                  ),

                  ListTile(
                    leading: Text('Items Amount: '),
                    trailing: Text('P' + (widget.order.total - widget.order.serviceFee).toStringAsFixed(2), style: kH6Blue),
                  ),

                  ListTile(
                    leading: Text('Service Fee: '),
                    trailing: Text('P' + widget.order.serviceFee.toStringAsFixed(2), style: kH6Blue),
                  ),

                  //Display Total Amount
                  ListTile(
                    title: Text('Total Amount: '),
                    trailing: Text('P' + widget.order.total.toStringAsFixed(2), style: kH3Blue),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 80.0),
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton.extended(
              icon: Icon(Icons.delivery_dining),
              label: Text('Accept'),
              backgroundColor: kMainThemeColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(24.0)),
              ),
              onPressed: () async {
                await showDialog(context: context, builder: (_) {
                  return CustomDialogBox(
                    title: 'Accept Order?',
                    content: 'Are you sure you want to accept this order?',
                    enableSecondaryButton: true,
                    mainButtonTitle: 'Yes',
                    secondaryButtonTitle: 'No',
                    mainButtonOnPressed: () {
                      Navigator.of(context).pop();
                      orderService.acceptOrder(context, widget.order);
                    },
                  );
                });
              },
            ),
          ),
        );
      }
    );
  }
}
