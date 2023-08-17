// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class AddressEntities extends Equatable {
  final int id;
  final String labelAddress;
  final String fullAddress;
  final String? detailAddress;
  final String recipientName;
  final String phoneNumber;
  final bool isMainAddress;
  final bool isChoosedAddress;

  const AddressEntities({
    required this.id,
    required this.labelAddress,
    required this.fullAddress,
    this.detailAddress,
    required this.recipientName,
    required this.phoneNumber,
    required this.isMainAddress,
    required this.isChoosedAddress,
  });

  @override
  List<Object?> get props => [
        id,
        labelAddress,
        fullAddress,
        detailAddress,
        recipientName,
        phoneNumber,
        isMainAddress,
        isChoosedAddress,
      ];
}
