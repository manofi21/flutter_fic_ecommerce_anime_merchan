import 'package:flutter/material.dart';

import '../../../../core/base_widget/price_text_widget.dart';
import '../../../../core/constant/constant.dart';

class CardOrderDetailItemWidget extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final double productPrice;
  final int productQtyItem;
  const CardOrderDetailItemWidget(
      {super.key,
      required this.imageUrl,
      required this.productName,
      required this.productPrice,
      required this.productQtyItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage('http://$baseUrl$imageUrl'),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productName,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Text("$productQtyItem x "),
                          PriceTextWidget(
                            price: productPrice,
                            textStyle: const TextStyle(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(height: 2),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Total Harga"),
                  PriceTextWidget(
                    price: productPrice * productQtyItem,
                    textStyle: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              OutlinedButton(onPressed: () {}, child: const Text("Beli Lagi"))
            ],
          )
        ],
      ),
    );
  }
}
