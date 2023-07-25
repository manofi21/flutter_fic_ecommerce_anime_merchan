class Product {
    final int id;
    final Attributes attributes;

    Product({
        required this.id,
        required this.attributes,
    });

    static Product fromJson(dynamic json) => Product(
        id: json["id"],
        attributes: Attributes.fromJson(json["attributes"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "attributes": attributes.toJson(),
    };
}

class Attributes {
    final String name;
    final String description;
    final int quantity;
    final int price;
    final bool inStock;
    final String image;
    final String distributor;
    final DateTime createdAt;
    final DateTime updatedAt;
    final DateTime publishedAt;
    final Images images;

    Attributes({
        required this.name,
        required this.description,
        required this.quantity,
        required this.price,
        required this.inStock,
        required this.image,
        required this.distributor,
        required this.createdAt,
        required this.updatedAt,
        required this.publishedAt,
        required this.images,
    });

    factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        name: json["name"],
        description: json["description"],
        quantity: json["quantity"],
        price: json["price"],
        inStock: json["inStock"],
        image: json["image"],
        distributor: json["distributor"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        publishedAt: DateTime.parse(json["publishedAt"]),
        images: Images.fromJson(json["images"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "quantity": quantity,
        "price": price,
        "inStock": inStock,
        "image": image,
        "distributor": distributor,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "publishedAt": publishedAt.toIso8601String(),
        "images": images.toJson(),
    };
}

class Images {
    final dynamic data;

    Images({
        this.data,
    });

    factory Images.fromJson(Map<String, dynamic> json) => Images(
        data: json["data"],
    );

    Map<String, dynamic> toJson() => {
        "data": data,
    };
}
