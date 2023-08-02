// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constant/constant.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../domain/entities/product_item.dart';

class CardProduct extends StatefulWidget {
  final ProductItem productItem;
  const CardProduct({Key? key, required this.productItem}) : super(key: key);

  @override
  State<CardProduct> createState() => _CardProductState();
}

class _CardProductState extends State<CardProduct> {
  @override
  Widget build(BuildContext context) {
    final listItem = widget.productItem.urlImages;
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      elevation: 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Stack(
                  children: [
                    if (listItem.isNotEmpty) ...{
                      AspectRatio(
                        aspectRatio: 16 / 17,
                        child: Image.network(
                          'http://$baseUrl${listItem.first}',
                          fit: BoxFit.fill,
                          width: double.infinity,
                          height: 20.w,
                        ),
                      )
                    } else ...{
                      const Text('Image Not Found')
                    },
                    // const Align(
                    //   alignment: AlignmentDirectional.topStart,
                    //   child: Padding(
                    //     padding: EdgeInsets.all(8),
                    //     child: Icon(Icons.accessibility_outlined),
                    //   ),
                    // ),
                    // const Align(
                    //   alignment: AlignmentDirectional.topEnd,
                    //   child: Padding(
                    //       padding: EdgeInsets.all(8),
                    //       child: Icon(Icons.accessibility_outlined)),
                    // )
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.productItem.productName,
                        style: TextStyle(
                            fontSize: 9.sp,
                            color: Colors.black45,
                            fontWeight: FontWeight.w600),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      buildPriceWidget(widget.productItem.productPrice),
                    ],
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              final cartBloc = context.watch<CartBloc>();
              Widget? buttonWidget;

              if (cartBloc.isProductExit(widget.productItem.productId)) {
                buttonWidget = OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    // foregroundColor: Colors.blueGrey,
                    side: const BorderSide(
                      color: Colors.blueGrey,
                    ),
                  ),
                  onPressed: () {
                    cartBloc.discardProduct(
                      productId: widget.productItem.productId,
                    );
                  },
                  child: const Text("Hapus Dari Keranjang"),
                );
              }

              buttonWidget ??= ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                ),
                onPressed: () {
                  cartBloc.addProduct(
                    productItem: widget.productItem,
                  );
                },
                child: const Text("Ke Keranjang"),
              );

              return SizedBox(width: double.infinity, child: buttonWidget);
            },
          )
        ],
      ),
    );
  }
}

Widget buildPriceWidget(int price) {
  final idrFormatter = CurrencyFormatterSettings(
    symbol: 'Rp',
    thousandSeparator: '.',
    decimalSeparator: ',',
  );

  final stringCurrency =
      CurrencyFormatter.format(price, idrFormatter, decimal: 0);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        stringCurrency,
        style: TextStyle(
            color: Colors.black12, fontSize: 9.sp, fontWeight: FontWeight.w600),
      ),
    ],
  );
}
