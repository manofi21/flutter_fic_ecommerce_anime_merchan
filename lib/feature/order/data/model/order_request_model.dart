
class OrderRequestModel {
    final List<Item> items;
    final int totalPrice;
    final String deliveryAddress;
    final String courierName;
    final int shippingCost;

    OrderRequestModel({
        required this.items,
        required this.totalPrice,
        required this.deliveryAddress,
        required this.courierName,
        required this.shippingCost,
    });

    factory OrderRequestModel.fromJson(Map<String, dynamic> json) => OrderRequestModel(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        totalPrice: json["total_price"],
        deliveryAddress: json["delivery_address"],
        courierName: json["courier_name"],
        shippingCost: json["shipping_cost"],
    );

    Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "total_price": totalPrice,
        "delivery_address": deliveryAddress,
        "courier_name": courierName,
        "shipping_cost": shippingCost,
    };
}

class Item {
    final int id;
    final String productName;
    final int price;
    final int qty;

    Item({
        required this.id,
        required this.productName,
        required this.price,
        required this.qty,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
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
