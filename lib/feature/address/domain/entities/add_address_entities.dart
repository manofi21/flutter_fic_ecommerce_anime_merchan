class AddAddressEntities {
  final String labelAddress;
  final String fullAddress;
  final String detailAddress;
  final String recipientName;
  final String phoneNumber;
  final bool isMainAddress;
  final bool isChoosedAddress;

  AddAddressEntities({
    required this.labelAddress,
    required this.fullAddress,
    required this.detailAddress,
    required this.recipientName,
    required this.phoneNumber,
    this.isMainAddress = false,
    this.isChoosedAddress = false,
  });
}
