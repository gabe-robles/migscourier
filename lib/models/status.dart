class Status {

  Status({
    this.currentlyDelivering,
    this.orderId,
    this.customerId,
    this.customerName,
    this.customerPhone,
    this.customerAddress,
    this.customerCity,
    this.serviceFee,
    this.total,
    this.pickedUp,
  });

  final bool currentlyDelivering;
  final String orderId;
  final String customerId;
  final String customerName;
  final String customerPhone;
  final String customerAddress;
  final String customerCity;
  final double serviceFee;
  final double total;
  final bool pickedUp;

}