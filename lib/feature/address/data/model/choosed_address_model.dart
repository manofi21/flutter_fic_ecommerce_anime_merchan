// ignore_for_file: public_member_api_docs, sort_constructors_first
class ChoosedAddressModel {
  final String address;
  final int id;
  ChoosedAddressModel({
    required this.address,
    required this.id,
  });


  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'address': address,
      'id': id,
    };
  }

  factory ChoosedAddressModel.fromJson(Map<String, dynamic> map) {
    return ChoosedAddressModel(
      address: map['address'] as String,
      id: map['id'] as int,
    );
  }

}
