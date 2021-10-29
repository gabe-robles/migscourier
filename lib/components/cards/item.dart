import 'package:cached_network_image/cached_network_image.dart';
import 'package:migscourier/models/item.dart';
import 'package:migscourier/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatefulWidget {

  const ItemCard({
    Key key,
    this.item,
  }) : super(key: key);

  final Item item;

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {

  double quantity;

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      quantity = widget.item.quantity;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 10.0, right: 10.0),
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[300]),
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 10, right: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: CachedNetworkImage(
                              height: 90,
                              width: 90,
                              alignment: FractionalOffset.center,
                              fit: BoxFit.fitWidth,
                              imageUrl: widget.item.imageUrl,
                              placeholder: (context, placeholder) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                              errorWidget: (context, error, _) {
                                return Center(
                                  child: Icon(Icons.error),
                                );
                              },
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.item.name}',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              'Size: ${widget.item.size}\n${widget.item.merchantName}, ${widget.item.marketName}',
                              style: TextStyle(fontSize: 12, color: kDisabledColor),
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  '\P ${widget.item.pricePerUnit} per ${widget.item.unit}',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 1,
                      indent: 15,
                      endIndent: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text('Quantity: ${widget.item.quantity} ${widget.item.unit}(s)'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 120,
                  ),
                  Container(
                    height: 30,
                    width: 100,
                    decoration: BoxDecoration(
                      color: kMainThemeColor,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Text(
                          // 'Fresh',
                          'P ${(widget.item.pricePerUnit * quantity).toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

}
