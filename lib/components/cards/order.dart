import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:migscourier/constants.dart';
import 'package:flutter/material.dart';
import 'package:migscourier/models/order.dart';

class OrderCard extends StatelessWidget {

  OrderCard({
    this.order,
  });

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18.0, 16.0, 12.0, 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FaIcon(FontAwesomeIcons.shoppingBasket, color: kMainThemeColor),
            SizedBox(width: 18.0),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(order.customerName, style: kH3),
                  SizedBox(height: 12.0),
                  Text(order.customerAddress,
                    style: kBody,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
