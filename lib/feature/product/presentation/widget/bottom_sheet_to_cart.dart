import 'package:flutter/material.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/cart/presentation/page/cart_page.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/product/presentation/page/product_page.dart';

import '../../../../core/bottom_sheet/bottom_sheet.dart';
import '../../../../core/constant/constant.dart';
import '../../domain/entities/product_item.dart';

void bottomSheetToCart({
  required BuildContext context,
  required ProductItem productItem,
}) {
  showBaseBottomSheet(
    currentcontext: context,
    builder: SizedBox(
      height: (MediaQuery.of(context).size.height * (2 / 3) - 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                              'http://$baseUrl${productItem.urlImages.first.urlSmallImage}'),
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
          Text("Lihat Product Lainnya",
              style: Theme.of(context).textTheme.headlineSmall),
          SizedBox(
            height: (MediaQuery.of(context).size.height / 2) - 40,
            child: const ProductPage(),
          )
        ],
      ),
    ),
  );
}
