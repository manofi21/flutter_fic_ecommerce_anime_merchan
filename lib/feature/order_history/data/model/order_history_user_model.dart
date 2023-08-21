class OrderHistoryUserModel {
    final int id;
    final List<ItemProductHistory> items;
    final int totalPrice;
    final String deliveryAddress;
    final String courierName;
    final int shippingCost;
    final String orderStatus;
    final DateTime createdAt;
    final DateTime updatedAt;
    final DateTime publishedAt;
    final String urlPayment;

    OrderHistoryUserModel({
        required this.id,
        required this.items,
        required this.totalPrice,
        required this.deliveryAddress,
        required this.courierName,
        required this.shippingCost,
        required this.orderStatus,
        required this.createdAt,
        required this.updatedAt,
        required this.publishedAt,
        required this.urlPayment,
    });

    factory OrderHistoryUserModel.fromJson(Map<String, dynamic> json) => OrderHistoryUserModel(
        id: json["id"],
        items: List<ItemProductHistory>.from(json["items"].map((x) => ItemProductHistory.fromJson(x))),
        totalPrice: json["total_price"],
        deliveryAddress: json["delivery_address"],
        courierName: json["courier_name"],
        shippingCost: json["shipping_cost"],
        orderStatus: json["order_status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        publishedAt: DateTime.parse(json["publishedAt"]),
        urlPayment: json["url_payment"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "total_price": totalPrice,
        "delivery_address": deliveryAddress,
        "courier_name": courierName,
        "shipping_cost": shippingCost,
        "order_status": orderStatus,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "publishedAt": publishedAt.toIso8601String(),
        "url_payment": urlPayment,
    };
}

class ItemProductHistory {
    final int id;
    final String productName;
    final int price;
    final int qty;

    ItemProductHistory({
        required this.id,
        required this.productName,
        required this.price,
        required this.qty,
    });

    factory ItemProductHistory.fromJson(Map<String, dynamic> json) => ItemProductHistory(
        id: json["id"],
        productName: json["productName"],
        price: json["price"],
        qty: json["qty"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "productName": productName,
        "price": price,
        "qty": qty,
    };
}
