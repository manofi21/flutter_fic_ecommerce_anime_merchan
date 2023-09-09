import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/core/base_widget/wcon_elevated_button.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/core/show_dialog/show_confirm_dialog.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/address/domain/entities/add_address_entities.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/locator.dart';

import '../../../../core/base_widget/wcon_text_field.dart';
import '../cubit/add_address/add_address_cubit.dart';

class FormAddAddressCubit extends StatelessWidget {
  const FormAddAddressCubit({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddAddressCubit>(
      create: (_) => getIt<AddAddressCubit>(),
      child: const FormAddAddress(),
    );
  }
}

class FormAddAddress extends StatefulWidget {
  const FormAddAddress({super.key});

  @override
  State<FormAddAddress> createState() => _FormAddAddressState();
}

class _FormAddAddressState extends State<FormAddAddress> {
  late AddAddressCubit addAddressCubit;

  late TextEditingController labelAddressController;
  late TextEditingController fullAddressController;
  late TextEditingController detailAddressController;
  late TextEditingController recipientNameController;
  late TextEditingController phoneNumberController;

  @override
  void didChangeDependencies() {
    addAddressCubit = context.read<AddAddressCubit>();

    labelAddressController = TextEditingController();
    fullAddressController = TextEditingController();
    detailAddressController = TextEditingController();
    recipientNameController = TextEditingController();
    phoneNumberController = TextEditingController();

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    addAddressCubit.close();

    labelAddressController.dispose();
    fullAddressController.dispose();
    detailAddressController.dispose();
    recipientNameController.dispose();
    phoneNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Save Alamat"),
      ),
      body: Column(
        children: [
          WConTextField(
            labelText: "Label Alamat",
            controller: labelAddressController,
          ),
          WConTextField(
            labelText: "Alamat Lengkap",
            controller: fullAddressController,
          ),
          WConTextField(
            labelText: "Detail Alamat (Optional)",
            controller: detailAddressController,
          ),
          WConTextField(
            labelText: "Nama Penerima di Tempat",
            controller: recipientNameController,
          ),
          WConTextField(
            labelText: "Nomor telepon",
            controller: phoneNumberController,
            textInputType: TextInputType.number,
          ),
          BlocConsumer<AddAddressCubit, AddAddressState>(
            listener: (context, state) {
              final successCheck = state.isCreateSuccess;
              if (successCheck != null) {
                if (successCheck) {
                  showConfirmDialog(
                    context: context,
                    message: "Address Sukses dibuat",
                    trueFalseOption: false,
                    ok: () {
                      Navigator.of(context).pop();
                      // Navigator.of(context).pop();
                    },
                  );
                }

                if (!successCheck) {
                  showConfirmDialog(
                    context: context,
                    message: state.msgError,
                    trueFalseOption: false,
                    ok: () {
                      Navigator.of(context).pop();
                    },
                  );
                }
              }
            },
            builder: (context, state) {
              if (state.isLoading) {
                return const SizedBox(
                  height: 40,
                  width: 40,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              return WConElevatedButton(
                title: "Simpan",
                onPressed: () {
                  context.read<AddAddressCubit>().onAddAddress(
                        AddAddressEntities(
                          labelAddress: labelAddressController.text,
                          fullAddress: fullAddressController.text,
                          detailAddress: detailAddressController.text,
                          recipientName: recipientNameController.text,
                          phoneNumber: phoneNumberController.text,
                        ),
                      );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
