import 'package:migscourier/components/cards/item.dart';
import 'package:migscourier/components/modals/custom.dart';
import 'package:migscourier/constants.dart';
import 'package:flutter/material.dart';
import 'package:migscourier/models/item.dart';
import 'package:migscourier/models/status.dart';
import 'package:migscourier/services/network/orders.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class CurrentOrderScreen extends StatefulWidget {

  CurrentOrderScreen({
    this.order,
  });

  final Status order;

  @override
  _CurrentOrderScreenState createState() => _CurrentOrderScreenState();
}

class _CurrentOrderScreenState extends State<CurrentOrderScreen> {

  Future itemsFuture;

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
      itemsFuture = _ordersServices.getItems(context, widget.order.orderId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrdersServices>(
      builder: (context, orderConsumer, _) {
        return ModalProgressHUD(
          inAsyncCall: orderConsumer.showSpinner,
          child: Scaffold(
            appBar: AppBar(
              brightness: Brightness.dark,
              automaticallyImplyLeading: false,
              title: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text('Delivering'),
              ),
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
                        Text(widget.order.customerAddress + ', ' + widget.order.customerCity),
                        SizedBox(height: 10)
                      ],
                    ),
                  ),

                  //List of Orders
                  FutureBuilder<List<Item>>(
                      future: itemsFuture,
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
                            return ItemCard(item: items[index]);
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
            floatingActionButton: widget.order.pickedUp == true ? FloatingActionButton.extended(
              icon: Icon(Icons.delivery_dining),
              label: Text('Confirm Delivery'),
              backgroundColor: kMainThemeColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(24.0)),
              ),
              onPressed: () {
                showDialog(context: context, builder: (_) {
                  return CustomDialogBox(
                    title: 'Confirm Delivery?',
                    content: 'Customer has received the order?',
                    enableSecondaryButton: true,
                    mainButtonTitle: 'Yes',
                    secondaryButtonTitle: 'No',
                    mainButtonOnPressed: () {
                      _ordersServices.confirmOrderDelivered(context, widget.order);
                    },
                  );
                });
              },
            ) : FloatingActionButton.extended(
              icon: Icon(Icons.delivery_dining),
              label: Text('Confirm Pick Up'),
              backgroundColor: kSecondaryThemeColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(24.0)),
              ),
              onPressed: () {
                showDialog(context: context, builder: (_) {
                  return CustomDialogBox(
                    title: 'Confirm Pick Up?',
                    content: 'Have you picked up all the items in the list?',
                    enableSecondaryButton: true,
                    mainButtonTitle: 'Yes',
                    secondaryButtonTitle: 'No',
                    mainButtonOnPressed: () {
                      _ordersServices.pickUpOrder(context, widget.order);
                    },
                  );
                });
              },
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          ),
        );
      }
    );
  }
}
