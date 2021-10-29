import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:migscourier/models/order.dart';
import 'package:migscourier/models/status.dart';

class FirestoreManager {

  FirestoreManager({
    this.uid,
  });

  final String uid;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<Status> get riderStatus {
    return _firestore
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((DocumentSnapshot rider) => Status(
          currentlyDelivering: rider['currentlyDelivering'],
          orderId: rider['order']['id'],
          customerId: rider['order']['customerId'],
          customerName: rider['order']['customerName'],
          customerPhone: rider['order']['customerPhone'],
          customerAddress: rider['order']['customerAddress'],
          customerCity: rider['order']['customerCity'],
          serviceFee: rider['order']['serviceFee'].toDouble(),
          total: rider['order']['total'].toDouble(),
          pickedUp: rider['order']['pickedUp'],
    ));
  }

  Stream<List<Order>> get ordersFromFirebase {
    return _firestore
        .collection('orders')
        .where('delivered', isEqualTo: false)
        .where('riderAccepted', isEqualTo: false)
        .orderBy('date', descending: true)
        .snapshots()
        .map((QuerySnapshot snapshot) {
          return snapshot.docs.map((QueryDocumentSnapshot order) =>
              Order(
                id: order.id,
                customerId: order["customerId"],
                customerName: order['customerName'],
                customerAddress: order['customerAddress'],
                customerPhone: order['customerPhone'],
                city: order['customerCity'],
                serviceFee: order['serviceFee'].toDouble(),
                total: order['total'].toDouble(),
                pickedUp: order['pickedUp'],
                delivered: order['delivered'],
              ),
          ).toList();
        }
    );
  }

}