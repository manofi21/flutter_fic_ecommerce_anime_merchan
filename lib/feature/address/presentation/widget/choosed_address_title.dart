import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/address/presentation/widget/bottom_sheet_address.dart';

import '../cubit/choosed_address/choosed_address_cubit.dart';
import '../cubit/choosed_address/choosed_address_state.dart';

class ChoosedAddressTitle extends StatelessWidget {
  const ChoosedAddressTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChoosedAddressCubit, ChoosedAddressState>(
      builder: (context, state) {
        final choosedAddressCubit = context.read<ChoosedAddressCubit>();
        if (state.isLoading) {
          return const Text('Mengambil alamat email');
        }

        if (state.isSuccess) {
          final shortAddress = choosedAddressCubit.getShortChoosedAddress?.address;
          return InkWell(
            onTap: () async {
              await showListAddressBottomSheet(context);
              await choosedAddressCubit.onGetChoosedAddress();
            },
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Alamat Penerima : $shortAddress",
                  ),
                ),
                const SizedBox(width: 3),
                const Icon(Icons.keyboard_arrow_down_outlined)
              ],
            ),
          );
        }

        if (state.isError) {
          return Text(state.msgError);
        }

        return Container();
      },
    );
  }
}
