// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
    final List<ProductModelDatum> data;
    final Meta meta;

    ProductModel({
        required this.data,
        required this.meta,
    });

    static ProductModel fromJson(dynamic json) => ProductModel(
        data: List<ProductModelDatum>.from(json["data"].map((x) => ProductModelDatum.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
    };
}

class ProductModelDatum {
    final int id;
    final ProductAttributes attributes;

    ProductModelDatum({
        required this.id,
        required this.attributes,
    });

    static ProductModelDatum fromJson(dynamic json) => ProductModelDatum(
        id: json["id"],
        attributes: ProductAttributes.fromJson(json["attributes"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "attributes": attributes.toJson(),
    };
}

class ProductAttributes {
    final String productName;
    final String description;
    final int quantity;
    final int price;
    final bool inStock;
    final String distributor;
    final DateTime createdAt;
    final DateTime updatedAt;
    final DateTime publishedAt;
    final Images images;
    final SubSourceItem subItemType;
    final SourceItem sourceItem;

    ProductAttributes({
        required this.productName,
        required this.description,
        required this.quantity,
        required this.price,
        required this.inStock,
        required this.distributor,
        required this.createdAt,
        required this.updatedAt,
        required this.publishedAt,
        required this.images,
        required this.subItemType,
        required this.sourceItem,
    });

    factory ProductAttributes.fromJson(Map<String, dynamic> json) => ProductAttributes(
        productName: json["product_name"],
        description: json["description"],
        quantity: json["quantity"],
        price: json["price"],
        inStock: json["in_stock"],
        distributor: json["distributor"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        publishedAt: DateTime.parse(json["publishedAt"]),
        images: Images.fromJson(json["images"]),
        subItemType: SubSourceItem.fromJson(json["sub_item_type"]),
        sourceItem: SourceItem.fromJson(json["source_item"]),
    );

    Map<String, dynamic> toJson() => {
        "product_name": productName,
        "description": description,
        "quantity": quantity,
        "price": price,
        "in_stock": inStock,
        "distributor": distributor,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "publishedAt": publishedAt.toIso8601String(),
        "images": images.toJson(),
        "sub_item_type": subItemType.toJson(),
        "source_item": sourceItem.toJson(),
    };
}

class Images {
    final List<ImagesDatum> data;

    Images({
        required this.data,
    });

    factory Images.fromJson(Map<String, dynamic> json) => Images(
        data: List<ImagesDatum>.from(json["data"].map((x) => ImagesDatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class ImagesDatum {
    final int id;
    final ImagesAttributes attributes;

    ImagesDatum({
        required this.id,
        required this.attributes,
    });

    factory ImagesDatum.fromJson(Map<String, dynamic> json) => ImagesDatum(
        id: json["id"],
        attributes: ImagesAttributes.fromJson(json["attributes"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "attributes": attributes.toJson(),
    };
}

class ImagesAttributes {
    final String name;
    final dynamic alternativeText;
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

    ImagesAttributes({
        required this.name,
        this.alternativeText,
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

    factory ImagesAttributes.fromJson(Map<String, dynamic> json) => ImagesAttributes(
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
    final Small? medium;

    Formats({
        required this.thumbnail,
        required this.small,
        this.medium,
    });

    factory Formats.fromJson(Map<String, dynamic> json) => Formats(
        thumbnail: Small.fromJson(json["thumbnail"]),
        small: Small.fromJson(json["small"]),
        medium: json["medium"] == null ? null : Small.fromJson(json["medium"]),
    );

    Map<String, dynamic> toJson() => {
        "thumbnail": thumbnail.toJson(),
        "small": small.toJson(),
        "medium": medium?.toJson(),
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

class SourceItem {
    final int id;
    final String sourceItem;

    SourceItem({
        required this.id,
        required this.sourceItem,        
    });

    factory SourceItem.fromJson(Map<String, dynamic> json) => SourceItem(
        id: json['data']['id'],
        sourceItem: json['data']['attributes']['source_item']
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "source_item": sourceItem,
    };
}

class SubSourceItem  {
    final int id;
    final String subSourceItem;

    SubSourceItem({
        required this.id,
        required this.subSourceItem,        
    });

    factory SubSourceItem.fromJson(Map<String, dynamic> json) => SubSourceItem(
        id: json['data']['id'],
        subSourceItem: json['data']['attributes']['sub_item_type']
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "sub_item_type": subSourceItem,
    };
}

class Meta {
    final Pagination pagination;

    Meta({
        required this.pagination,
    });

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        pagination: Pagination.fromJson(json["pagination"]),
    );

    Map<String, dynamic> toJson() => {
        "pagination": pagination.toJson(),
    };
}

class Pagination {
    final int page;
    final int pageSize;
    final int pageCount;
    final int total;

    Pagination({
        required this.page,
        required this.pageSize,
        required this.pageCount,
        required this.total,
    });

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        page: json["page"],
        pageSize: json["pageSize"],
        pageCount: json["pageCount"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "pageSize": pageSize,
        "pageCount": pageCount,
        "total": total,
    };
}
