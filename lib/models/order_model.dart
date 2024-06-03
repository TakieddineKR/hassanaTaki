class OrderModel {
  final String orderId;
  final String orderUser; //!!NGO OR RESTAURANT
  final String userName; //!!name of NGO OR name RESTAURANT
  final String orderStatus;
  final String orderDescription;
  final DateTime orderDate;
  final String orderAddress;
  final String orderPhone;
  final int orderAmount;
  final bool hasEmployee;

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
  });
  //!! Serialization
  Map<String, dynamic> toJson() => {
        'orderId': orderId,
        'orderUser': orderUser,
        'userName': userName,
        'orderStatus': orderStatus,
        'orderDescription': orderDescription,
        'orderDate': orderDate,
        'orderAddress': orderAddress,
        'orderPhone': orderPhone,
        'orderAmount': orderAmount,
        'hasEmployee': hasEmployee
      };
  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        orderId: json['orderId'],
        orderUser: json['orderUser'],
        userName: json['userName'],
        orderStatus: json['orderStatus'],
        orderDescription: json['orderDescription'],
        orderDate: json['orderDate']?.toDate(),
        orderAddress: json['orderAddress'],
        orderPhone: json['orderPhone'],
        orderAmount: json['orderAmount'],
        hasEmployee: json['hasEmployee'],
      );
}
