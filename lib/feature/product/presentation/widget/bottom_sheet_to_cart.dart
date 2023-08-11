import 'package:flutter/material.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/cart/presentation/page/cart_page.dart';

import '../../../../core/bottom_sheet/bottom_sheet.dart';
import '../../../../core/constant/constant.dart';
import '../../domain/entities/product_item.dart';

void bottomSheetToCart({
  required BuildContext context,
  required ProductItem productItem,
}) {
  showBaseBottomSheet(
    currentcontext: context,
    builder: Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(
                          'http://$baseUrl${productItem.urlImages.first}'),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Text(
                        'Product berhasil ditambahkan',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        productItem.productName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const CartPage()));
              },
              child: const SizedBox(
                height: 20,
                width: double.infinity,
                child: Text('Lihat Keranjang', textAlign: TextAlign.center),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
