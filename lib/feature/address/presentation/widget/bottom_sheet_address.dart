import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/locator.dart';

import '../../../../core/bottom_sheet/bottom_sheet.dart';
import '../cubit/choosed_address/choosed_address_cubit.dart';
import '../cubit/list_address/list_address_cubit.dart';
import '../cubit/list_address/list_address_state.dart';

Future<void> showListAddressBottomSheet(BuildContext context) async {
  await showBaseBottomSheet(
    currentcontext: context,
    builder: const BottomSheetAddress(),
  );
}

class BottomSheetAddress extends StatelessWidget {
  const BottomSheetAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ListAddressCubit>(
      create: (context) => getIt<ListAddressCubit>(
        param1: context.read<ChoosedAddressCubit>(),
      ),
      child: const ListAddressBlocWidget(),
    );
  }
}

class ListAddressBlocWidget extends StatefulWidget {
  const ListAddressBlocWidget({super.key});

  @override
  State<ListAddressBlocWidget> createState() => _ListAddressBlocWidgetState();
}

class _ListAddressBlocWidgetState extends State<ListAddressBlocWidget> {
  late ListAddressCubit listAddressCubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    listAddressCubit = context.read<ListAddressCubit>();
    listAddressCubit.onGetListAddress();
  }

  @override
  void dispose() {
    listAddressCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<ListAddressCubit, ListAddressState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const SizedBox(
            height: 35,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state.isSuccess) {
          final listValue = state.successValue;
          return SizedBox(
            height: size.height * (1 / 3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Pilih Alamat Pengiriman",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        if (index == listValue.length) {
                          return Container(
                            height: size.height * (1 / 3),
                            width: (size.width * (3 / 4)) - 40,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(12.0),
                              ),
                              border: Border.all(
                                width: 1.0,
                                color: Colors.grey[900]!,
                              ),
                            ),
                            child: const Center(
                              child: Text("+ Tambah"),
                            ),
                          );
                        }

                        final addressValue = listValue[index];
                        return InkWell(
                          onTap: () {
                            context.read<ListAddressCubit>().onUpdateSelectedId(addressValue.id);
                          },
                          child: Container(
                            width: (size.width * (3 / 4)) - 40,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(12.0),
                              ),
                              border: Border.all(
                                width: addressValue.id == state.idSelectedAddress ? 5.0 : 1.0,
                                color: addressValue.id == state.idSelectedAddress
                                    ? const Color(0xff7CFC00)
                                    : const Color(0xFF000000),
                              ),
                            ),
                            padding: EdgeInsets.all(addressValue.id == state.idSelectedAddress ? 10 : 14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text(("${addressValue.id} == ${state.idSelectedAddress}").toString()),
                                Text(addressValue.labelAddress),
                                Text(addressValue.recipientName),
                                Text(addressValue.phoneNumber),
                                Expanded(
                                    child: Text(addressValue.fullAddress,
                                        maxLines: 2)),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (_, __) => const SizedBox(width: 10),
                      itemCount: listValue.length + 1,
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text("Simpan"),
                  ),
                )
              ],
            ),
          );
        }

        if (state.isError) {
          return Center(
            child: Text(state.msgError),
          );
        }

        return Container();
      },
    );
  }
}
