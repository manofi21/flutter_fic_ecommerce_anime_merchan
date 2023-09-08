import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/address/domain/entities/address_entities.dart';

import '../../../address/presentation/cubit/choosed_address/choosed_address_cubit.dart';
import '../../../address/presentation/cubit/choosed_address/choosed_address_state.dart';


class AddressCheckoutBlocBuilder extends StatelessWidget {
  const AddressCheckoutBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChoosedAddressCubit, ChoosedAddressState>(
      builder: (context, state) {
        return Column(
          children: [
            if (state.isLoading) ...{
              const CircularProgressIndicator()
            } else if (state.isSuccess) ...{
              AddressCheckoutWidget(
                addressEntities: state.successValue,
              ),
            } else if (state.isError) ...{
              Text(state.msgError)
            }
          ],
        );
      },
    );
  }
}

class AddressCheckoutWidget extends StatelessWidget {
  final AddressEntities? addressEntities;
  const AddressCheckoutWidget({super.key, required this.addressEntities});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Alamat Pengiriman'),
                InkWell(
                  onTap: () {},
                  child: const Text('Pilih Alamat'),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 13.0),
              child: Divider(),
            ),
            if (addressEntities != null) ...{
              Row(
                children: [
                  Text(addressEntities!.labelAddress),
                  if (addressEntities!.isMainAddress) ...{
                    Container(
                      padding: const EdgeInsets.all(2),
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(3)),
                      child: Text(
                        'Utama',
                        style: TextStyle(
                          color: Colors.red.shade200,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  }
                ],
              ),
              Text(
                '${addressEntities!.recipientName} (${addressEntities!.phoneNumber})',
              ),
              Text(
                addressEntities!.fullAddress,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            } else ...{
              const Center(
                child: Text(
                  "Silahkan Mengisikan Alamat Terlebih Dahulu",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            }
          ],
        ),
      ),
    );
  }
}
