class Order {
  Order({
    this.id,
    this.customerId,
    this.customerName,
    this.customerAddress,
    this.customerPhone,
    this.city,
    this.serviceFee,
    this.total,
    this.pickedUp,
    this.delivered,
  });

  final String id;
  final String customerId;
  final String customerName;
  final String customerAddress;
  final String customerPhone;
  final String city;
  final double serviceFee;
  final double total;
  final bool pickedUp;
  final bool delivered;
}
