class AddressModel {
    final int id;
    final Attributes attributes;

    AddressModel({
        required this.id,
        required this.attributes,
    });

    AddressModel copyWith({
        int? id,
        Attributes? attributes,
    }) => 
        AddressModel(
            id: id ?? this.id,
            attributes: attributes ?? this.attributes,
        );

    static AddressModel fromJson(dynamic json) => AddressModel(
        id: json["id"],
        attributes: Attributes.fromJson(json["attributes"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "attributes": attributes.toJson(),
    };
}

class Attributes {
    final String labelAddress;
    final String fullAddress;
    final String? detailAddress;
    final String recipientName;
    final String phoneNumber;
    final DateTime createdAt;
    final DateTime updatedAt;
    final DateTime publishedAt;
    final bool isMainAddress;

    Attributes({
        required this.labelAddress,
        required this.fullAddress,
        required this.detailAddress,
        required this.recipientName,
        required this.phoneNumber,
        required this.createdAt,
        required this.updatedAt,
        required this.publishedAt,
        required this.isMainAddress,
    });

    Attributes copyWith({
        String? labelAddress,
        String? fullAddress,
        String? detailAddress,
        String? recipientName,
        String? phoneNumber,
        DateTime? createdAt,
        DateTime? updatedAt,
        DateTime? publishedAt,
        bool? isMainAddress,
    }) => 
        Attributes(
            labelAddress: labelAddress ?? this.labelAddress,
            fullAddress: fullAddress ?? this.fullAddress,
            detailAddress: detailAddress ?? this.detailAddress,
            recipientName: recipientName ?? this.recipientName,
            phoneNumber: phoneNumber ?? this.phoneNumber,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            publishedAt: publishedAt ?? this.publishedAt,
            isMainAddress: isMainAddress ?? this.isMainAddress,
        );

    factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        labelAddress: json["label_address"],
        fullAddress: json["full_address"],
        detailAddress: json["detail_address"],
        recipientName: json["recipient_name"],
        phoneNumber: json["phone_number"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        publishedAt: DateTime.parse(json["publishedAt"]),
        isMainAddress: json["is_main_address"],
    );

    Map<String, dynamic> toJson() => {
        "label_address": labelAddress,
        "full_address": fullAddress,
        "detail_address": detailAddress,
        "recipient_name": recipientName,
        "phone_number": phoneNumber,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "publishedAt": publishedAt.toIso8601String(),
        "is_main_address": isMainAddress,
    };
}
