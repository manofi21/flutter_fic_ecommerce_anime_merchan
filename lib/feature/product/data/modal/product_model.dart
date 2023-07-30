class Product {
    final int id;
    final ProductAttributes attributes;

    Product({
        required this.id,
        required this.attributes,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        attributes: ProductAttributes.fromJson(json["attributes"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "attributes": attributes.toJson(),
    };
}

class ProductAttributes {
    final String name;
    final String description;
    final int quantity;
    final int price;
    final bool inStock;
    final String distributor;
    final DateTime createdAt;
    final DateTime updatedAt;
    final DateTime publishedAt;
    final Images images;

    ProductAttributes({
        required this.name,
        required this.description,
        required this.quantity,
        required this.price,
        required this.inStock,
        required this.distributor,
        required this.createdAt,
        required this.updatedAt,
        required this.publishedAt,
        required this.images,
    });

    factory ProductAttributes.fromJson(Map<String, dynamic> json) => ProductAttributes(
        name: json["name"],
        description: json["description"],
        quantity: json["quantity"],
        price: json["price"],
        inStock: json["inStock"],
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
        "distributor": distributor,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "publishedAt": publishedAt.toIso8601String(),
        "images": images.toJson(),
    };
}

class Images {
    final List<Datum> data;

    Images({
        required this.data,
    });

    factory Images.fromJson(Map<String, dynamic> json) => Images(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    final int id;
    final DatumAttributes attributes;

    Datum({
        required this.id,
        required this.attributes,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        attributes: DatumAttributes.fromJson(json["attributes"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "attributes": attributes.toJson(),
    };
}

class DatumAttributes {
    final String name;
    final String alternativeText;
    final dynamic caption;
    final int width;
    final int height;
    final Formats formats;
    final String hash;
    final String ext;
    final String mime;
    final double size;
    final String url;
    final dynamic previewUrl;
    final String provider;
    final dynamic providerMetadata;
    final DateTime createdAt;
    final DateTime updatedAt;

    DatumAttributes({
        required this.name,
        required this.alternativeText,
        this.caption,
        required this.width,
        required this.height,
        required this.formats,
        required this.hash,
        required this.ext,
        required this.mime,
        required this.size,
        required this.url,
        this.previewUrl,
        required this.provider,
        this.providerMetadata,
        required this.createdAt,
        required this.updatedAt,
    });

    factory DatumAttributes.fromJson(Map<String, dynamic> json) => DatumAttributes(
        name: json["name"],
        alternativeText: json["alternativeText"],
        caption: json["caption"],
        width: json["width"],
        height: json["height"],
        formats: Formats.fromJson(json["formats"]),
        hash: json["hash"],
        ext: json["ext"],
        mime: json["mime"],
        size: json["size"]?.toDouble(),
        url: json["url"],
        previewUrl: json["previewUrl"],
        provider: json["provider"],
        providerMetadata: json["provider_metadata"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "alternativeText": alternativeText,
        "caption": caption,
        "width": width,
        "height": height,
        "formats": formats.toJson(),
        "hash": hash,
        "ext": ext,
        "mime": mime,
        "size": size,
        "url": url,
        "previewUrl": previewUrl,
        "provider": provider,
        "provider_metadata": providerMetadata,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}

class Formats {
    final Small thumbnail;
    final Small small;

    Formats({
        required this.thumbnail,
        required this.small,
    });

    factory Formats.fromJson(Map<String, dynamic> json) => Formats(
        thumbnail: Small.fromJson(json["thumbnail"]),
        small: Small.fromJson(json["small"]),
    );

    Map<String, dynamic> toJson() => {
        "thumbnail": thumbnail.toJson(),
        "small": small.toJson(),
    };
}

class Small {
    final String name;
    final String hash;
    final String ext;
    final String mime;
    final dynamic path;
    final int width;
    final int height;
    final double size;
    final String url;

    Small({
        required this.name,
        required this.hash,
        required this.ext,
        required this.mime,
        this.path,
        required this.width,
        required this.height,
        required this.size,
        required this.url,
    });

    factory Small.fromJson(Map<String, dynamic> json) => Small(
        name: json["name"],
        hash: json["hash"],
        ext: json["ext"],
        mime: json["mime"],
        path: json["path"],
        width: json["width"],
        height: json["height"],
        size: json["size"]?.toDouble(),
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "hash": hash,
        "ext": ext,
        "mime": mime,
        "path": path,
        "width": width,
        "height": height,
        "size": size,
        "url": url,
    };
}
