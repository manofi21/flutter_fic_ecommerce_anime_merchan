// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

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
      child: ListView(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Stack(
            children: [
              if (listItem.isNotEmpty) ...{
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(
                    listItem.first,
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: 20.w,
                  ),
                )
              } else ...{
                const Text('Image Not Found')
              },
              const Align(
                alignment: AlignmentDirectional.topStart,
                child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(Icons.accessibility_outlined)
                    // Image.network(
                    //   product.customStickerImage!,
                    //   width: 8.w,
                    //   height: 8.w,
                    //   fit: BoxFit.cover,
                    // ),
                    ),
              ),
              const Align(
                alignment: AlignmentDirectional.topEnd,
                child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(Icons.accessibility_outlined)),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
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
      // const SizedBox(
      //   width: 9,
      // ),
      // Text(
      //   'Rp 2.000.000',
      //   style: TextStyle(
      //       color: Colors.black26,
      //       decoration: TextDecoration.lineThrough,
      //       decorationColor: Colors.black,
      //       fontSize: 9.sp),
      // ),
    ],
  );
}
