import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hassana/core/enums/order_status_enum.dart'; // Import the correct enum

class OrderModel {
  final String orderId;
  final String orderUser; // ID of the user who created the order
  final String userName; // Name of the user who created the order
  OrderStatusEnum orderStatus;
  final String orderDescription;
  final DateTime orderDate;
  final String orderAddress;
  final String orderPhone;
  final int orderAmount;
  final bool hasEmployee;
  final String? acceptedById; // ID of the user who accepted the order
  final String? acceptedByName; // Name of the user who accepted the order
  final String?
      acceptedByPhone; // Phone number of the user who accepted the order

  OrderModel({
    required this.orderId,
    required this.orderUser,
    required this.userName,
    required this.orderStatus,
    required this.orderDescription,
    required this.orderDate,
    required this.orderAddress,
    required this.orderPhone,
    required this.orderAmount,
    required this.hasEmployee,
    this.acceptedById,
    this.acceptedByName,
    this.acceptedByPhone,
  });

  Map<String, dynamic> toJson() => {
        'orderId': orderId,
        'orderUser': orderUser,
        'userName': userName,
        'orderStatus': orderStatus.toString().split('.').last,
        'orderDescription': orderDescription,
        'orderDate': orderDate,
        'orderAddress': orderAddress,
        'orderPhone': orderPhone,
        'orderAmount': orderAmount,
        'hasEmployee': hasEmployee,
        'acceptedById': acceptedById,
        'acceptedByName': acceptedByName,
        'acceptedByPhone': acceptedByPhone,
      };

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        orderId: json['orderId'],
        orderUser: json['orderUser'],
        userName: json['userName'],
        orderStatus: OrderStatusEnum.values.firstWhere(
            (e) => e.toString().split('.').last == json['orderStatus']),
        orderDescription: json['orderDescription'],
        orderDate: (json['orderDate'] as Timestamp).toDate(),
        orderAddress: json['orderAddress'],
        orderPhone: json['orderPhone'],
        orderAmount: json['orderAmount'],
        hasEmployee: json['hasEmployee'],
        acceptedById: json['acceptedById'],
        acceptedByName: json['acceptedByName'],
        acceptedByPhone: json['acceptedByPhone'],
      );
}
