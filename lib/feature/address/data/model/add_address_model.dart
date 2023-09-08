class AddAddressModel {
    AddAddressDataModel data;

    AddAddressModel({
        required this.data,
    });

    factory AddAddressModel.fromJson(Map<String, dynamic> json) => AddAddressModel(
        data: AddAddressDataModel.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
    };
}

class AddAddressDataModel {
    String labelAddress;
    String fullAddress;
    String detailAddress;
    String recipientName;
    String phoneNumber;
    bool isMainAddress;
    bool isChoosedAddress;

    AddAddressDataModel({
        required this.labelAddress,
        required this.fullAddress,
        required this.detailAddress,
        required this.recipientName,
        required this.phoneNumber,
        required this.isMainAddress,
        required this.isChoosedAddress,
    });

    factory AddAddressDataModel.fromJson(Map<String, dynamic> json) => AddAddressDataModel(
        labelAddress: json["label_address"],
        fullAddress: json["full_address"],
        detailAddress: json["detail_address"],
        recipientName: json["recipient_name"],
        phoneNumber: json["phone_number"],
        isMainAddress: json["is_main_address"],
        isChoosedAddress: json["is_choosed_address"],
    );

    Map<String, dynamic> toJson() => {
        "label_address": labelAddress,
        "full_address": fullAddress,
        "detail_address": detailAddress,
        "recipient_name": recipientName,
        "phone_number": phoneNumber,
        "is_main_address": isMainAddress,
        "is_choosed_address": isChoosedAddress,
    };
}
