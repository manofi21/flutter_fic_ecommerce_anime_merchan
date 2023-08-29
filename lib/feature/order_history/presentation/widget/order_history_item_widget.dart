import 'package:flutter/material.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/core/base_widget/price_text_widget.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/order_history/data/extension/order_status_to_entity.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/order_history/presentation/page/detail_order_history_page.dart';

import '../../../../core/constant/constant.dart';
import '../../domain/entities/order_history_entity.dart';

class OrderHistoryItemWidget extends StatefulWidget {
  final OrderHistoryEntity orderHistoryEntity;
  final bool isFirst;
  const OrderHistoryItemWidget(
      {super.key, required this.orderHistoryEntity, required this.isFirst});

  @override
  State<OrderHistoryItemWidget> createState() => _OrderHistoryItemWidgetState();
}

class _OrderHistoryItemWidgetState extends State<OrderHistoryItemWidget> {
  @override
  Widget build(BuildContext context) {
    final orderItemList = widget.orderHistoryEntity.items;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: widget.isFirst ? 10 : 0,
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DetailOrderHistoryPage(
                  orderHistoryEntity: widget.orderHistoryEntity),
            ),
          );
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text(widget.orderHistoryEntity.orderStatus.toOrderStatusEntity)],
                ),
                const Flexible(
                  flex: 1,
                  child: Divider(),
                ),
                ...orderItemList.map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 80,
                              width: 80,
                              child: Image.network(
                                'http://$baseUrl${e.urlImage}',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 2.5,
                                child: Text(
                                  e.productName,
                                  maxLines: 2,
                                ),
                              ),
                            )
                          ],
                        ),
                        Text('x${e.qty}'),
                      ],
                    ),
                  ),
                ),
                const Flexible(
                  flex: 1,
                  child: Divider(),
                ),
                PriceTextWidget(
                  price: widget.orderHistoryEntity.totalPrice.toDouble(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
