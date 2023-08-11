import 'package:flutter/material.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/product/presentation/page/detail_product_page.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/base_widget/price_text_widget.dart';
import '../../../../core/constant/constant.dart';
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
                    const Align(
                      alignment: AlignmentDirectional.topEnd,
                      child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(Icons.favorite_border_outlined)),
                    )
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
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      PriceTextWidget(
                        price: widget.productItem.productPrice.toDouble(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        DetailProductPage(productItem: widget.productItem),
                  ),
                );
              },
              child: const Text("Lihat Detail"),
            ),
          )
        ],
      ),
    );
  }
}
