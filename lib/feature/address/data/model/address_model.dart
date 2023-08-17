class AddressModel {
    final int id;
    final String labelAddress;
    final String fullAddress;
    final String detailAddress;
    final String recipientName;
    final String phoneNumber;
    final DateTime createdAt;
    final DateTime updatedAt;
    final DateTime publishedAt;
    final bool isMainAddress;
    final bool isChoosedAddress;

    AddressModel({
        required this.id,
        required this.labelAddress,
        required this.fullAddress,
        required this.detailAddress,
        required this.recipientName,
        required this.phoneNumber,
        required this.createdAt,
        required this.updatedAt,
        required this.publishedAt,
        required this.isMainAddress,
        required this.isChoosedAddress,
    });

    static AddressModel fromJson(dynamic json) => AddressModel(
        id: json["id"],
        labelAddress: json["label_address"],
        fullAddress: json["full_address"],
        detailAddress: json["detail_address"],
        recipientName: json["recipient_name"],
        phoneNumber: json["phone_number"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        publishedAt: DateTime.parse(json["publishedAt"]),
        isMainAddress: json["is_main_address"],
        isChoosedAddress: json["is_choosed_address"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "label_address": labelAddress,
        "full_address": fullAddress,
        "detail_address": detailAddress,
        "recipient_name": recipientName,
        "phone_number": phoneNumber,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "publishedAt": publishedAt.toIso8601String(),
        "is_main_address": isMainAddress,
        "is_choosed_address": isChoosedAddress,
    };
}
