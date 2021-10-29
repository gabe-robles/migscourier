class Item {

  Item({
    this.id,
    this.productId,
    this.merchantId,
    this.name,
    this.size,
    this.pricePerUnit,
    this.unit,
    this.quantity,
    this.merchantName,
    this.marketName,
    this.imageUrl,
    this.dateAdded,
  });

  final String id;
  final String productId;
  final String merchantId;
  final String name;
  final String size;
  final double pricePerUnit;
  final String unit;
  final double quantity;
  final String merchantName;
  final String marketName;
  final String imageUrl;
  final DateTime dateAdded;

  factory Item.fromJson(Map<String, dynamic> json) {

    return Item(
      id: json["id"] as String,
      productId: json["productId"] as String,
      merchantId: json["merchantId"] as String,
      name: json["name"] as String,
      size: json["size"] as String,
      pricePerUnit: json["pricePerUnit"] as double,
      unit: json["unit"] as String,
      quantity: json["quantity"] as double,
      merchantName: json["merchantName"] as String,
      marketName: json["marketName"] as String,
      imageUrl: json["imageUrl"] as String,
      dateAdded: json["date"].toDate(),
    );
  }

}