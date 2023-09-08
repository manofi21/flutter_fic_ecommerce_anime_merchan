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
        if (state.isLoading) {
          return const Text('Mengambil data');
        }

        if (state.isSuccess) {
          final shortAddress = context.read<ChoosedAddressCubit>().getShortChoosedAddress?.address;
          return InkWell(
            onTap: () {
              showListAddressBottomSheet(context);
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
