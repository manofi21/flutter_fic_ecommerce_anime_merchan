
class CheckoutOrderRequestModel {
    final List<Item> items;
    final int totalPrice;
    final String deliveryAddress;
    final String courierName;
    final int shippingCost;

    CheckoutOrderRequestModel({
        required this.items,
        required this.totalPrice,
        required this.deliveryAddress,
        required this.courierName,
        required this.shippingCost,
    });

    factory CheckoutOrderRequestModel.fromJson(Map<String, dynamic> json) => CheckoutOrderRequestModel(
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
    final String urlImage;

    Item({
        required this.id,
        required this.productName,
        required this.price,
        required this.qty,
        required this.urlImage,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        productName: json["product_name"],
        price: json["price"],
        qty: json["qty"],
        urlImage: json["url_image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "price": price,
        "qty": qty,
        "url_image": urlImage,
    };
}
