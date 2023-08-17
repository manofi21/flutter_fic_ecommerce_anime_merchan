import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/address/domain/entities/address_entities.dart';

import '../bloc/address_checkout_bloc.dart';

class AddressCheckoutBlocBuilder extends StatelessWidget {
  const AddressCheckoutBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressCheckoutBloc, AddressCheckoutState>(
      builder: (context, state) {
        final addressCheckoutBloc = context.read<AddressCheckoutBloc>();
        return Column(
          children: [
            if (state is AddressCheckoutLoading) ...{
              const CircularProgressIndicator()
            } else if (state is AddressCheckoutLoaded) ...{
              AddressCheckoutWidget(
                addressEntities: addressCheckoutBloc.getSelectedAddress(),
              ),
            } else if (state is AddressCheckoutError) ...{
              Text(state.message)
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
